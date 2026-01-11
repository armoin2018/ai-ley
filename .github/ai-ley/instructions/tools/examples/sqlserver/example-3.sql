-- Clinical decision support for drug interaction checking
CREATE OR ALTER PROCEDURE clinical.CheckDrugInteractions
    @PatientID BIGINT,
    @NewMedicationName NVARCHAR(200) = NULL,
    @InteractionCount INT OUTPUT,
    @CriticalInteractionCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @InteractionResults TABLE (
        Medication1 NVARCHAR(200),
        Medication2 NVARCHAR(200),
        InteractionSeverity NVARCHAR(20),
        ClinicalEffect NVARCHAR(500),
        Recommendation NVARCHAR(1000)
    );

    -- Get current active prescriptions plus new medication
    WITH PatientMedications AS (
        SELECT DISTINCT MedicationName
        FROM clinical.Prescriptions
        WHERE PatientID = @PatientID
          AND Status = 'Active'
          AND EndDate >= GETDATE()
        UNION ALL
        SELECT @NewMedicationName
        WHERE @NewMedicationName IS NOT NULL
    ),
    MedicationPairs AS (
        SELECT
            m1.MedicationName AS Med1,
            m2.MedicationName AS Med2
        FROM PatientMedications m1
        CROSS JOIN PatientMedications m2
        WHERE m1.MedicationName < m2.MedicationName
    )
    INSERT INTO @InteractionResults
    SELECT
        mp.Med1,
        mp.Med2,
        di.InteractionSeverity,
        di.ClinicalEffect,
        di.Recommendation
    FROM MedicationPairs mp
    INNER JOIN clinical.DrugInteractions di ON (
        (di.Medication1 = mp.Med1 AND di.Medication2 = mp.Med2) OR
        (di.Medication1 = mp.Med2 AND di.Medication2 = mp.Med1)
    )
    WHERE di.IsActive = 1
    ORDER BY
        CASE di.InteractionSeverity
            WHEN 'Critical' THEN 1
            WHEN 'Major' THEN 2
            WHEN 'Moderate' THEN 3
            ELSE 4
        END;

    SELECT @InteractionCount = COUNT(*) FROM @InteractionResults;
    SELECT @CriticalInteractionCount = COUNT(*)
    FROM @InteractionResults
    WHERE InteractionSeverity IN ('Critical', 'Major');

    -- Return interaction details
    SELECT * FROM @InteractionResults;

    -- Log the interaction check for audit
    INSERT INTO clinical.DrugInteractionChecks (
        PatientID, CheckedBy, CheckDate, NewMedication,
        InteractionCount, CriticalInteractionCount
    )
    VALUES (
        @PatientID, SUSER_SNAME(), SYSUTCDATETIME(), @NewMedicationName,
        @InteractionCount, @CriticalInteractionCount
    );
END;
GO

-- Clinical risk scoring for sepsis detection
CREATE OR ALTER FUNCTION clinical.CalculateSepsisScore(
    @PatientID BIGINT,
    @AssessmentTime DATETIME2
)
RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @Score INT = 0;
    DECLARE @Temperature DECIMAL(4,1);
    DECLARE @HeartRate INT;
    DECLARE @RespiratoryRate INT;
    DECLARE @WBC DECIMAL(8,2);
    DECLARE @SystolicBP INT;
    DECLARE @Lactate DECIMAL(5,2);

    -- Get most recent vital signs within 4 hours
    SELECT TOP 1
        @Temperature = VitalSigns_Temperature,
        @HeartRate = VitalSigns_HeartRate,
        @RespiratoryRate = VitalSigns_RespiratoryRate,
        @SystolicBP = VitalSigns_BloodPressure_Systolic
    FROM clinical.MedicalRecords
    WHERE PatientID = @PatientID
      AND VisitDate >= DATEADD(HOUR, -4, @AssessmentTime)
      AND VisitDate <= @AssessmentTime
      AND VitalSigns_Temperature IS NOT NULL
    ORDER BY VisitDate DESC;

    -- Get most recent lab values within 24 hours
    SELECT
        @WBC = MAX(CASE WHEN TestName = 'White Blood Cell Count' THEN CAST(ResultValue AS DECIMAL(8,2)) END),
        @Lactate = MAX(CASE WHEN TestName = 'Lactate' THEN CAST(ResultValue AS DECIMAL(5,2)) END)
    FROM clinical.LabResults
    WHERE PatientID = @PatientID
      AND ResultDate >= DATEADD(HOUR, -24, @AssessmentTime)
      AND ResultDate <= @AssessmentTime
      AND Status = 'Completed';

    -- Calculate SIRS criteria
    -- Temperature > 38°C (100.4°F) or < 36°C (96.8°F)
    IF @Temperature > 38.0 OR @Temperature < 36.0
        SET @Score = @Score + 1;

    -- Heart Rate > 90 bpm
    IF @HeartRate > 90
        SET @Score = @Score + 1;

    -- Respiratory Rate > 20 breaths/min
    IF @RespiratoryRate > 20
        SET @Score = @Score + 1;

    -- WBC > 12,000 or < 4,000 cells/μL
    IF @WBC > 12.0 OR @WBC < 4.0
        SET @Score = @Score + 1;

    -- Additional sepsis indicators
    -- Elevated lactate > 2 mmol/L
    IF @Lactate > 2.0
        SET @Score = @Score + 2;

    -- Hypotension (systolic BP < 90 mmHg)
    IF @SystolicBP < 90
        SET @Score = @Score + 3;

    RETURN @Score;
END;
GO
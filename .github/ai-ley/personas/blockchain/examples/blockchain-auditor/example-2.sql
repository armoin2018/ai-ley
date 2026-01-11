-- Blockchain Transaction Audit Queries
-- Comprehensive transaction analysis for audit evidence collection

-- 1. Fund Flow Analysis with Risk Scoring
WITH transaction_analysis AS (
    SELECT
        block_number,
        transaction_hash,
        from_address,
        to_address,
        value_eth,
        gas_used,
        gas_price,
        transaction_fee,
        contract_address,
        input_data,
        transaction_status,
        timestamp,
        -- Risk scoring based on transaction patterns
        CASE
            WHEN value_eth > 1000 THEN 'HIGH'
            WHEN value_eth > 100 THEN 'MEDIUM'
            ELSE 'LOW'
        END as value_risk_level,
        -- Velocity analysis for suspicious activity
        COUNT(*) OVER (
            PARTITION BY from_address
            ORDER BY timestamp
            RANGE BETWEEN INTERVAL '1 hour' PRECEDING AND CURRENT ROW
        ) as hourly_transaction_count
    FROM ethereum_transactions
    WHERE block_number BETWEEN ? AND ?
),

-- 2. Address Classification and Risk Assessment
address_classification AS (
    SELECT
        address,
        address_type, -- 'EOA', 'Contract', 'Exchange', 'DeFi', 'Unknown'
        risk_score,
        kyc_status,
        sanctions_status,
        first_transaction_date,
        last_transaction_date,
        total_transaction_count,
        total_value_transferred
    FROM address_metadata
),

-- 3. Smart Contract Interaction Analysis
contract_interactions AS (
    SELECT
        t.transaction_hash,
        t.contract_address,
        c.contract_name,
        c.contract_type,
        c.audit_status,
        c.verification_status,
        t.method_signature,
        t.decoded_input,
        t.event_logs,
        -- Compliance validation
        CASE
            WHEN c.audit_status = 'AUDITED' AND c.verification_status = 'VERIFIED' THEN 'COMPLIANT'
            WHEN c.audit_status = 'UNAUDITED' THEN 'HIGH_RISK'
            ELSE 'MEDIUM_RISK'
        END as compliance_status
    FROM ethereum_transactions t
    JOIN contract_metadata c ON t.contract_address = c.address
    WHERE t.contract_address IS NOT NULL
),

-- 4. Anomaly Detection for Audit Exceptions
transaction_anomalies AS (
    SELECT
        transaction_hash,
        anomaly_type,
        anomaly_score,
        deviation_magnitude,
        detection_timestamp,
        investigation_status
    FROM (
        SELECT
            transaction_hash,
            'HIGH_VALUE' as anomaly_type,
            (value_eth - AVG(value_eth) OVER ()) / STDDEV(value_eth) OVER () as anomaly_score,
            value_eth as deviation_magnitude,
            NOW() as detection_timestamp,
            'PENDING' as investigation_status
        FROM transaction_analysis
        WHERE value_eth > (SELECT PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY value_eth) FROM transaction_analysis)

        UNION ALL

        SELECT
            transaction_hash,
            'HIGH_FREQUENCY' as anomaly_type,
            hourly_transaction_count as anomaly_score,
            hourly_transaction_count as deviation_magnitude,
            NOW() as detection_timestamp,
            'PENDING' as investigation_status
        FROM transaction_analysis
        WHERE hourly_transaction_count > 50
    ) anomaly_union
)

-- 5. Audit Evidence Collection Query
SELECT
    ta.transaction_hash,
    ta.block_number,
    ta.timestamp,
    ta.from_address,
    ta.to_address,
    ta.value_eth,
    ta.value_risk_level,
    ac_from.address_type as from_address_type,
    ac_from.risk_score as from_risk_score,
    ac_to.address_type as to_address_type,
    ac_to.risk_score as to_risk_score,
    ci.contract_name,
    ci.compliance_status,
    an.anomaly_type,
    an.anomaly_score,
    -- Audit trail validation
    CASE
        WHEN ta.transaction_status = 'SUCCESS'
         AND ac_from.sanctions_status = 'CLEAN'
         AND ac_to.sanctions_status = 'CLEAN'
         AND (ci.compliance_status = 'COMPLIANT' OR ci.compliance_status IS NULL)
         AND an.anomaly_type IS NULL
        THEN 'AUDIT_PASSED'
        ELSE 'AUDIT_EXCEPTION'
    END as audit_status,
    -- Evidence collection
    CONCAT(
        'Block: ', ta.block_number,
        ' | Hash: ', ta.transaction_hash,
        ' | Validation: ', ta.transaction_status,
        ' | Compliance: ', COALESCE(ci.compliance_status, 'N/A')
    ) as audit_evidence
FROM transaction_analysis ta
LEFT JOIN address_classification ac_from ON ta.from_address = ac_from.address
LEFT JOIN address_classification ac_to ON ta.to_address = ac_to.address
LEFT JOIN contract_interactions ci ON ta.transaction_hash = ci.transaction_hash
LEFT JOIN transaction_anomalies an ON ta.transaction_hash = an.transaction_hash
ORDER BY ta.timestamp DESC, ta.value_eth DESC;
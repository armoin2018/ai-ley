// GDPR-compliant user registration system
class GDPRCompliantUserService {
  async registerUser(userData, consentData) {
    try {
      // Validate explicit consent
      const validConsent = await this.validateGDPRConsent(consentData);
      if (!validConsent) {
        throw new ComplianceError('GDPR consent validation failed');
      }
      
      // Log consent for audit trail
      await this.auditLogger.log({
        action: 'CONSENT_RECORDED',
        userId: userData.email,
        consentDetails: consentData,
        legalBasis: 'consent',
        timestamp: new Date().toISOString()
      });
      
      // Encrypt personal data
      const encryptedUserData = await this.encryptPersonalData(userData);
      
      // Store with retention metadata
      const user = await this.userRepository.create({
        ...encryptedUserData,
        gdprMetadata: {
          consentId: validConsent.id,
          dataRetentionUntil: this.calculateRetentionDate(),
          processingPurposes: consentData.purposes
        }
      });
      
      return { userId: user.id, complianceStatus: 'GDPR_COMPLIANT' };
      
    } catch (error) {
      await this.auditLogger.log({
        action: 'COMPLIANCE_VIOLATION',
        error: error.message,
        timestamp: new Date().toISOString()
      });
      throw error;
    }
  }
}
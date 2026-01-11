// Example privacy-compliant data handling
class UserDataHandler {
  constructor(config) {
    this.encryptionKey = config.encryptionKey;
    this.retentionPolicy = config.retentionPolicy;
    this.auditLogger = config.auditLogger;
  }
  
  // GDPR-compliant data collection
  collectUserData(userData, consent) {
    // Validate explicit consent
    if (!this.validateConsent(consent)) {
      throw new Error('Invalid or missing user consent');
    }
    
    // Log data collection for audit trail
    this.auditLogger.log({
      action: 'DATA_COLLECTION',
      userId: userData.userId,
      dataTypes: Object.keys(userData),
      consentId: consent.id,
      timestamp: new Date().toISOString(),
      legalBasis: consent.legalBasis
    });
    
    // Encrypt sensitive data before storage
    const encryptedData = this.encryptSensitiveFields(userData);
    
    // Set retention schedule
    this.scheduleDataRetention(userData.userId, this.retentionPolicy);
    
    return encryptedData;
  }
  
  // Data subject rights implementation
  async processDataSubjectRequest(userId, requestType) {
    this.auditLogger.log({
      action: 'DATA_SUBJECT_REQUEST',
      userId: userId,
      requestType: requestType,
      timestamp: new Date().toISOString()
    });
    
    switch (requestType) {
      case 'ACCESS':
        return await this.exportUserData(userId);
      case 'DELETION':
        return await this.deleteUserData(userId);
      case 'PORTABILITY':
        return await this.exportPortableData(userId);
      default:
        throw new Error(`Unsupported request type: ${requestType}`);
    }
  }
}
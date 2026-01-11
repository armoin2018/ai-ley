// SOX-compliant financial transaction processing
@Service
@SOXCompliant
public class FinancialTransactionService {
    
    @Autowired
    private AuditLogger auditLogger;
    
    @Autowired
    private ApprovalWorkflow approvalWorkflow;
    
    @SOXAuditTrail
    @Transactional
    public TransactionResult processTransaction(TransactionRequest request) {
        try {
            // Validate user authorization
            if (!securityService.hasAuthorization(request.getUserId(), "PROCESS_TRANSACTION")) {
                throw new SOXComplianceException("Insufficient authorization for transaction processing");
            }
            
            // Log transaction initiation
            auditLogger.logSOXEvent(SOXEventType.TRANSACTION_INITIATED, request);
            
            // Require dual approval for large transactions
            if (request.getAmount().compareTo(SOX_THRESHOLD) > 0) {
                ApprovalResult approval = approvalWorkflow.requireDualApproval(request);
                if (!approval.isApproved()) {
                    auditLogger.logSOXEvent(SOXEventType.TRANSACTION_REJECTED, request);
                    throw new SOXComplianceException("Transaction requires dual approval");
                }
            }
            
            // Process transaction with segregation of duties
            TransactionResult result = transactionProcessor.process(request);
            
            // Generate SOX-compliant audit trail
            auditLogger.logSOXEvent(SOXEventType.TRANSACTION_COMPLETED, result);
            
            return result;
            
        } catch (Exception e) {
            auditLogger.logSOXEvent(SOXEventType.TRANSACTION_FAILED, request, e);
            throw new SOXComplianceException("Transaction processing failed: " + e.getMessage());
        }
    }
}
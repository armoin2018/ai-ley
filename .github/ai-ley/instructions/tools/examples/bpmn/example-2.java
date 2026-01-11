// Enterprise BPMN Workflow Execution Engine
package com.enterprise.bpmn.engine;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Enterprise BPMN Workflow Execution Engine
 * Provides high-performance workflow execution with enterprise features
 */
@Service
@Transactional
@Slf4j
@RequiredArgsConstructor
public class EnterpriseBPMNExecutionEngine {

    private final ProcessRepository processRepository;
    private final TaskService taskService;
    private final DecisionService decisionService;
    private final IntegrationService integrationService;
    private final MonitoringService monitoringService;
    private final SecurityService securityService;
    private final AuditService auditService;

    private final ExecutorService executorService = Executors.newFixedThreadPool(20);

    /**
     * Start workflow process with comprehensive enterprise features
     */
    public ProcessInstanceResponse startProcess(ProcessStartRequest request) {
        log.info("Starting process: {} for user: {}", request.getProcessKey(), request.getUserId());

        try {
            // Security validation
            securityService.validateProcessAccess(request.getUserId(), request.getProcessKey());

            // Process definition validation
            ProcessDefinition processDefinition = processRepository.findByKey(request.getProcessKey())
                .orElseThrow(() -> new ProcessNotFoundException("Process not found: " + request.getProcessKey()));

            // Create process instance with enterprise metadata
            ProcessInstance processInstance = ProcessInstance.builder()
                .processDefinitionId(processDefinition.getId())
                .processKey(request.getProcessKey())
                .businessKey(request.getBusinessKey())
                .initiatorId(request.getUserId())
                .variables(request.getVariables())
                .priority(request.getPriority())
                .dueDate(request.getDueDate())
                .tenantId(request.getTenantId())
                .startTime(Instant.now())
                .status(ProcessStatus.ACTIVE)
                .build();

            // Persist process instance
            processInstance = processRepository.save(processInstance);

            // Initialize monitoring
            monitoringService.trackProcessStart(processInstance);

            // Start process execution
            ExecutionContext executionContext = createExecutionContext(processInstance, request);
            executeProcess(executionContext);

            // Audit logging
            auditService.logProcessStart(processInstance, request.getUserId());

            return ProcessInstanceResponse.builder()
                .processInstanceId(processInstance.getId())
                .processKey(processInstance.getProcessKey())
                .businessKey(processInstance.getBusinessKey())
                .status(processInstance.getStatus())
                .startTime(processInstance.getStartTime())
                .build();

        } catch (Exception e) {
            log.error("Failed to start process: {}", request.getProcessKey(), e);
            auditService.logProcessError(request, e);
            throw new ProcessExecutionException("Failed to start process", e);
        }
    }

    /**
     * Execute process with intelligent task routing and parallel processing
     */
    private void executeProcess(ExecutionContext context) {
        ProcessInstance processInstance = context.getProcessInstance();
        ProcessDefinition processDefinition = context.getProcessDefinition();

        // Start from initial activities
        List<Activity> initialActivities = processDefinition.getInitialActivities();

        for (Activity activity : initialActivities) {
            CompletableFuture.runAsync(() -> {
                executeActivity(context, activity);
            }, executorService);
        }
    }

    /**
     * Execute individual activity with comprehensive error handling
     */
    private void executeActivity(ExecutionContext context, Activity activity) {
        log.debug("Executing activity: {} in process: {}", activity.getId(), context.getProcessInstance().getId());

        try {
            // Pre-execution validation
            validateActivityExecution(context, activity);

            // Create activity instance
            ActivityInstance activityInstance = createActivityInstance(context, activity);

            // Execute based on activity type
            ActivityResult result = switch (activity.getType()) {
                case SERVICE_TASK -> executeServiceTask(context, activity);
                case USER_TASK -> executeUserTask(context, activity);
                case BUSINESS_RULE_TASK -> executeBusinessRuleTask(context, activity);
                case SCRIPT_TASK -> executeScriptTask(context, activity);
                case SEND_TASK -> executeSendTask(context, activity);
                case RECEIVE_TASK -> executeReceiveTask(context, activity);
                case MANUAL_TASK -> executeManualTask(context, activity);
                case EXCLUSIVE_GATEWAY -> executeExclusiveGateway(context, activity);
                case PARALLEL_GATEWAY -> executeParallelGateway(context, activity);
                case INCLUSIVE_GATEWAY -> executeInclusiveGateway(context, activity);
                case EVENT_BASED_GATEWAY -> executeEventBasedGateway(context, activity);
                default -> throw new UnsupportedActivityException("Unsupported activity type: " + activity.getType());
            };

            // Update activity instance
            activityInstance.setStatus(ActivityStatus.COMPLETED);
            activityInstance.setEndTime(Instant.now());
            activityInstance.setResult(result);

            // Continue execution to next activities
            continueExecution(context, activity, result);

            // Monitoring and metrics
            monitoringService.trackActivityCompletion(activityInstance);

        } catch (Exception e) {
            log.error("Activity execution failed: {} in process: {}", activity.getId(), context.getProcessInstance().getId(), e);
            handleActivityError(context, activity, e);
        }
    }

    /**
     * Execute service task with enterprise integration patterns
     */
    private ActivityResult executeServiceTask(ExecutionContext context, Activity activity) {
        ServiceTaskActivity serviceTask = (ServiceTaskActivity) activity;

        // Get enterprise configuration
        EnterpriseServiceConfig config = serviceTask.getEnterpriseConfig();

        // Circuit breaker pattern
        if (config.hasCircuitBreaker()) {
            return executeWithCircuitBreaker(context, serviceTask, config);
        }

        // Retry pattern
        if (config.hasRetryPolicy()) {
            return executeWithRetry(context, serviceTask, config);
        }

        // Standard execution
        return executeServiceTaskDirect(context, serviceTask);
    }

    private ActivityResult executeWithCircuitBreaker(ExecutionContext context, ServiceTaskActivity serviceTask, EnterpriseServiceConfig config) {
        CircuitBreaker circuitBreaker = circuitBreakerRegistry.circuitBreaker(serviceTask.getServiceEndpoint());

        return circuitBreaker.executeSupplier(() -> {
            return integrationService.callService(
                serviceTask.getServiceEndpoint(),
                context.getVariables(),
                config.getTimeout()
            );
        });
    }

    private ActivityResult executeWithRetry(ExecutionContext context, ServiceTaskActivity serviceTask, EnterpriseServiceConfig config) {
        RetryPolicy retryPolicy = RetryPolicy.builder()
            .maxAttempts(config.getMaxRetryAttempts())
            .backoffStrategy(config.getBackoffStrategy())
            .retryOn(Exception.class)
            .build();

        return Retry.of("serviceTask-" + serviceTask.getId(), retryPolicy)
            .executeSupplier(() -> {
                return integrationService.callService(
                    serviceTask.getServiceEndpoint(),
                    context.getVariables(),
                    config.getTimeout()
                );
            });
    }

    /**
     * Execute user task with role-based assignment and escalation
     */
    private ActivityResult executeUserTask(ExecutionContext context, Activity activity) {
        UserTaskActivity userTask = (UserTaskActivity) activity;

        // Create task instance with enterprise features
        TaskInstance taskInstance = TaskInstance.builder()
            .processInstanceId(context.getProcessInstance().getId())
            .activityId(userTask.getId())
            .name(userTask.getName())
            .description(userTask.getDescription())
            .assignee(userTask.getAssignee())
            .candidateUsers(userTask.getCandidateUsers())
            .candidateRoles(userTask.getCandidateRoles())
            .priority(userTask.getPriority())
            .dueDate(userTask.getDueDate())
            .formKey(userTask.getFormKey())
            .variables(context.getVariables())
            .createTime(Instant.now())
            .status(TaskStatus.CREATED)
            .build();

        // Apply enterprise task assignment rules
        applyTaskAssignmentRules(taskInstance, userTask);

        // Schedule escalation if configured
        if (userTask.hasEscalation()) {
            scheduleTaskEscalation(taskInstance, userTask.getEscalationConfig());
        }

        // Persist task
        taskInstance = taskService.createTask(taskInstance);

        // Send notifications
        notificationService.notifyTaskAssignment(taskInstance);

        // Return pending result (task will be completed separately)
        return ActivityResult.pending(taskInstance.getId());
    }

    /**
     * Execute business rule task with decision engine integration
     */
    private ActivityResult executeBusinessRuleTask(ExecutionContext context, Activity activity) {
        BusinessRuleTaskActivity ruleTask = (BusinessRuleTaskActivity) activity;

        // Prepare decision input
        DecisionExecutionRequest decisionRequest = DecisionExecutionRequest.builder()
            .decisionKey(ruleTask.getDecisionTable())
            .variables(context.getVariables())
            .tenantId(context.getProcessInstance().getTenantId())
            .build();

        // Execute decision with rule engine
        DecisionExecutionResult decisionResult = decisionService.executeDecision(decisionRequest);

        // Update context variables with decision output
        context.getVariables().putAll(decisionResult.getOutputVariables());

        return ActivityResult.success(decisionResult.getOutputVariables());
    }

    /**
     * Handle activity errors with comprehensive error management
     */
    private void handleActivityError(ExecutionContext context, Activity activity, Exception error) {
        // Create error instance
        ErrorInstance errorInstance = ErrorInstance.builder()
            .processInstanceId(context.getProcessInstance().getId())
            .activityId(activity.getId())
            .errorType(error.getClass().getSimpleName())
            .errorMessage(error.getMessage())
            .stackTrace(getStackTrace(error))
            .timestamp(Instant.now())
            .build();

        // Check for error boundary events
        List<BoundaryEvent> errorBoundaryEvents = activity.getErrorBoundaryEvents();

        if (!errorBoundaryEvents.isEmpty()) {
            // Handle with boundary event
            BoundaryEvent matchingEvent = findMatchingErrorBoundaryEvent(errorBoundaryEvents, error);
            if (matchingEvent != null) {
                log.info("Handling error with boundary event: {}", matchingEvent.getId());
                executeActivity(context, matchingEvent.getNextActivity());
                return;
            }
        }

        // Check process-level error handling
        if (context.getProcessDefinition().hasErrorHandling()) {
            handleProcessError(context, error);
            return;
        }

        // Default error handling - terminate process
        terminateProcessWithError(context, errorInstance);
    }
}
// Generated from UML Class Diagram
package com.enterprise.services;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * Enterprise User Management Service
 * Generated from UML Class: UserService
 * Stereotype: <<Service>>
 * Last Modified: 2025-01-15 10:30:00 UTC
 */
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
@Slf4j
public class UserService {

    private final UserRepository userRepository;
    private final UserValidationService validationService;
    private final AuditService auditService;
    private final SecurityService securityService;

    /**
     * Create new user with enterprise validation and auditing
     * UML Operation: +createUser(userData: UserCreateRequest): UserResponse
     */
    @Transactional
    public UserResponse createUser(@Valid UserCreateRequest request) {
        log.info("Creating user: {}", request.getEmail());

        // Enterprise validation
        validationService.validateUserCreation(request);

        // Security checks
        securityService.checkCreatePermission(getCurrentUser());

        // Business logic
        User user = User.builder()
            .email(request.getEmail())
            .firstName(request.getFirstName())
            .lastName(request.getLastName())
            .roles(determineDefaultRoles())
            .status(UserStatus.ACTIVE)
            .createdAt(Instant.now())
            .createdBy(getCurrentUser().getId())
            .build();

        user = userRepository.save(user);

        // Audit logging
        auditService.logUserCreation(user, getCurrentUser());

        log.info("User created successfully: {}", user.getId());
        return UserMapper.toResponse(user);
    }

    /**
     * Retrieve users with advanced filtering and pagination
     * UML Operation: +getUsers(filter: UserFilter, pageable: Pageable): Page<UserResponse>
     */
    public Page<UserResponse> getUsers(UserFilter filter, Pageable pageable) {
        log.debug("Retrieving users with filter: {}", filter);

        // Security filtering
        filter = securityService.applyUserAccessFilters(filter, getCurrentUser());

        // Execute query with specifications
        Page<User> users = userRepository.findAll(
            UserSpecifications.withFilter(filter),
            pageable
        );

        // Audit access
        auditService.logUserAccess(filter, getCurrentUser());

        return users.map(UserMapper::toResponse);
    }

    /**
     * Update user with optimistic locking and validation
     * UML Operation: +updateUser(id: Long, userData: UserUpdateRequest): UserResponse
     */
    @Transactional
    public UserResponse updateUser(Long id, @Valid UserUpdateRequest request) {
        log.info("Updating user: {}", id);

        User existingUser = userRepository.findById(id)
            .orElseThrow(() -> new UserNotFoundException("User not found: " + id));

        // Security authorization
        securityService.checkUpdatePermission(existingUser, getCurrentUser());

        // Optimistic locking check
        if (!Objects.equals(existingUser.getVersion(), request.getVersion())) {
            throw new OptimisticLockingException("User has been modified by another process");
        }

        // Validation
        validationService.validateUserUpdate(existingUser, request);

        // Apply updates
        existingUser.setFirstName(request.getFirstName());
        existingUser.setLastName(request.getLastName());
        existingUser.setModifiedAt(Instant.now());
        existingUser.setModifiedBy(getCurrentUser().getId());

        existingUser = userRepository.save(existingUser);

        // Audit logging
        auditService.logUserUpdate(existingUser, getCurrentUser());

        log.info("User updated successfully: {}", id);
        return UserMapper.toResponse(existingUser);
    }

    private User getCurrentUser() {
        return securityService.getCurrentUser();
    }

    private Set<Role> determineDefaultRoles() {
        return Set.of(roleService.findByName("USER"));
    }
}
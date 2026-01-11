-- Advanced multi-tenant schema with proper isolation
CREATE DATABASE saas_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE saas_platform;

-- Enable JSON functions and full-text search
SET @sql_mode = 'TRADITIONAL,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

-- Organizations (Tenants)
CREATE TABLE organizations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    subdomain VARCHAR(50) UNIQUE NOT NULL,
    plan_type ENUM('free', 'basic', 'pro', 'enterprise') DEFAULT 'free',
    billing_email VARCHAR(255),
    settings JSON DEFAULT (JSON_OBJECT()),
    limits JSON DEFAULT (JSON_OBJECT(
        'users', 10,
        'storage', 1073741824,
        'api_calls', 1000
    )),
    usage_stats JSON DEFAULT (JSON_OBJECT(
        'users', 0,
        'storage', 0,
        'api_calls', 0
    )),
    is_active BOOLEAN DEFAULT TRUE,
    trial_ends_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_slug (slug),
    INDEX idx_subdomain (subdomain),
    INDEX idx_plan_type (plan_type),
    INDEX idx_trial_ends_at (trial_ends_at),
    FULLTEXT idx_name_search (name)
) ENGINE=InnoDB;

-- Multi-tenant users with organization isolation
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    email VARCHAR(255) NOT NULL,
    username VARCHAR(50),
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role ENUM('owner', 'admin', 'member', 'viewer') DEFAULT 'member',
    permissions JSON DEFAULT (JSON_ARRAY()),
    profile_data JSON DEFAULT (JSON_OBJECT()),
    preferences JSON DEFAULT (JSON_OBJECT(
        'theme', 'light',
        'timezone', 'UTC',
        'notifications', JSON_OBJECT(
            'email', true,
            'push', false,
            'sms', false
        )
    )),
    last_login_at TIMESTAMP NULL,
    last_login_ip VARCHAR(45),
    email_verified_at TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    UNIQUE KEY unique_email_per_org (organization_id, email),
    UNIQUE KEY unique_username_per_org (organization_id, username),
    INDEX idx_organization_id (organization_id),
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_last_login (last_login_at),
    FULLTEXT idx_user_search (first_name, last_name, email, username)
) ENGINE=InnoDB;

-- Projects with advanced metadata and search
CREATE TABLE projects (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('active', 'archived', 'deleted') DEFAULT 'active',
    visibility ENUM('private', 'internal', 'public') DEFAULT 'private',
    metadata JSON DEFAULT (JSON_OBJECT()),
    settings JSON DEFAULT (JSON_OBJECT(
        'auto_assign', false,
        'notifications', true,
        'public_access', false
    )),
    tags JSON DEFAULT (JSON_ARRAY()),
    custom_fields JSON DEFAULT (JSON_OBJECT()),
    created_by BIGINT UNSIGNED NOT NULL,
    updated_by BIGINT UNSIGNED,
    archived_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    UNIQUE KEY unique_slug_per_org (organization_id, slug),
    INDEX idx_organization_id (organization_id),
    INDEX idx_status (status),
    INDEX idx_visibility (visibility),
    INDEX idx_created_by (created_by),
    INDEX idx_created_at (created_at),
    FULLTEXT idx_project_search (name, description)
) ENGINE=InnoDB;

-- Tasks with hierarchical structure and advanced features
CREATE TABLE tasks (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    project_id BIGINT UNSIGNED NOT NULL,
    parent_id BIGINT UNSIGNED NULL,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    title VARCHAR(500) NOT NULL,
    description TEXT,
    status ENUM('backlog', 'todo', 'in_progress', 'review', 'done', 'cancelled') DEFAULT 'backlog',
    priority ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium',
    task_type ENUM('feature', 'bug', 'improvement', 'documentation', 'research') DEFAULT 'feature',

    -- Assignment and ownership
    assignee_id BIGINT UNSIGNED NULL,
    reporter_id BIGINT UNSIGNED NOT NULL,
    reviewer_id BIGINT UNSIGNED NULL,

    -- Metadata and custom fields
    labels JSON DEFAULT (JSON_ARRAY()),
    custom_fields JSON DEFAULT (JSON_OBJECT()),
    attachments JSON DEFAULT (JSON_ARRAY()),

    -- Time tracking
    estimated_hours DECIMAL(8,2) DEFAULT 0,
    actual_hours DECIMAL(8,2) DEFAULT 0,
    story_points TINYINT UNSIGNED DEFAULT 0,

    -- Dates
    due_date DATE NULL,
    start_date DATE NULL,
    completed_at TIMESTAMP NULL,

    -- Hierarchy and ordering
    path VARCHAR(1000) GENERATED ALWAYS AS (
        CASE
            WHEN parent_id IS NULL THEN CAST(id AS CHAR)
            ELSE CONCAT(parent_id, '/', id)
        END
    ) STORED,
    position INTEGER DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES tasks(id) ON DELETE SET NULL,
    FOREIGN KEY (assignee_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (reporter_id) REFERENCES users(id),
    FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE SET NULL,

    INDEX idx_organization_project (organization_id, project_id),
    INDEX idx_parent_id (parent_id),
    INDEX idx_assignee (assignee_id),
    INDEX idx_status_priority (status, priority),
    INDEX idx_due_date (due_date),
    INDEX idx_path (path),
    FULLTEXT idx_task_search (title, description)
) ENGINE=InnoDB;

-- Activity log for audit trail
CREATE TABLE activity_logs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id BIGINT UNSIGNED NOT NULL,
    action VARCHAR(50) NOT NULL,
    changes JSON DEFAULT (JSON_OBJECT()),
    metadata JSON DEFAULT (JSON_OBJECT()),
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,

    INDEX idx_organization_id (organization_id),
    INDEX idx_entity (entity_type, entity_id),
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB;

-- Performance optimization views
CREATE VIEW project_stats AS
SELECT
    p.id,
    p.organization_id,
    p.name,
    COUNT(t.id) as total_tasks,
    COUNT(CASE WHEN t.status = 'done' THEN 1 END) as completed_tasks,
    COUNT(CASE WHEN t.status IN ('todo', 'in_progress', 'review') THEN 1 END) as active_tasks,
    COUNT(CASE WHEN t.priority = 'critical' THEN 1 END) as critical_tasks,
    AVG(t.actual_hours) as avg_task_hours,
    SUM(t.story_points) as total_story_points,
    MAX(t.updated_at) as last_activity
FROM projects p
LEFT JOIN tasks t ON p.id = t.project_id AND t.status != 'cancelled'
WHERE p.status = 'active'
GROUP BY p.id, p.organization_id, p.name;

-- Stored procedures for complex operations
DELIMITER //

CREATE PROCEDURE GetOrganizationDashboard(IN org_id BIGINT UNSIGNED)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Organization overview
    SELECT
        o.name,
        o.plan_type,
        o.usage_stats,
        o.limits,
        COUNT(u.id) as total_users,
        COUNT(p.id) as total_projects,
        COUNT(t.id) as total_tasks
    FROM organizations o
    LEFT JOIN users u ON o.id = u.organization_id AND u.is_active = 1
    LEFT JOIN projects p ON o.id = p.organization_id AND p.status = 'active'
    LEFT JOIN tasks t ON o.id = t.organization_id
    WHERE o.id = org_id
    GROUP BY o.id;

    -- Recent activity
    SELECT
        al.action,
        al.entity_type,
        al.entity_id,
        u.first_name,
        u.last_name,
        al.created_at
    FROM activity_logs al
    LEFT JOIN users u ON al.user_id = u.id
    WHERE al.organization_id = org_id
    ORDER BY al.created_at DESC
    LIMIT 20;

    -- Task statistics by status
    SELECT
        t.status,
        COUNT(*) as count,
        AVG(t.actual_hours) as avg_hours
    FROM tasks t
    WHERE t.organization_id = org_id
    GROUP BY t.status
    ORDER BY
        CASE t.status
            WHEN 'backlog' THEN 1
            WHEN 'todo' THEN 2
            WHEN 'in_progress' THEN 3
            WHEN 'review' THEN 4
            WHEN 'done' THEN 5
            WHEN 'cancelled' THEN 6
        END;

    COMMIT;
END //

DELIMITER ;

-- Triggers for activity logging
DELIMITER //

CREATE TRIGGER tasks_activity_insert
AFTER INSERT ON tasks
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (
        organization_id,
        user_id,
        entity_type,
        entity_id,
        action,
        changes
    ) VALUES (
        NEW.organization_id,
        NEW.reporter_id,
        'task',
        NEW.id,
        'created',
        JSON_OBJECT(
            'title', NEW.title,
            'status', NEW.status,
            'priority', NEW.priority,
            'assignee_id', NEW.assignee_id
        )
    );
END //

CREATE TRIGGER tasks_activity_update
AFTER UPDATE ON tasks
FOR EACH ROW
BEGIN
    DECLARE changes_json JSON DEFAULT JSON_OBJECT();

    IF OLD.title != NEW.title THEN
        SET changes_json = JSON_SET(changes_json, '$.title', JSON_OBJECT('old', OLD.title, 'new', NEW.title));
    END IF;

    IF OLD.status != NEW.status THEN
        SET changes_json = JSON_SET(changes_json, '$.status', JSON_OBJECT('old', OLD.status, 'new', NEW.status));
    END IF;

    IF OLD.assignee_id != NEW.assignee_id OR (OLD.assignee_id IS NULL AND NEW.assignee_id IS NOT NULL) OR (OLD.assignee_id IS NOT NULL AND NEW.assignee_id IS NULL) THEN
        SET changes_json = JSON_SET(changes_json, '$.assignee_id', JSON_OBJECT('old', OLD.assignee_id, 'new', NEW.assignee_id));
    END IF;

    IF JSON_LENGTH(changes_json) > 0 THEN
        INSERT INTO activity_logs (
            organization_id,
            entity_type,
            entity_id,
            action,
            changes
        ) VALUES (
            NEW.organization_id,
            'task',
            NEW.id,
            'updated',
            changes_json
        );
    END IF;
END //

DELIMITER ;
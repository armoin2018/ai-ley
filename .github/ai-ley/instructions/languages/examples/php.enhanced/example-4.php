<?php
declare(strict_types=1);

namespace App\Repositories;

use PDO;
use PDOException;
use App\Models\User;
use App\Exceptions\DatabaseException;

class UserRepository
{
    public function __construct(
        private readonly PDO $pdo
    ) {}

    /**
     * Find user by ID with proper error handling
     */
    public function findById(int $id): ?User
    {
        try {
            $stmt = $this->pdo->prepare(
                'SELECT id, email, name, created_at FROM users WHERE id = :id'
            );
            $stmt->bindValue(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

            $userData = $stmt->fetch(PDO::FETCH_ASSOC);
            
            return $userData ? User::fromArray($userData) : null;
        } catch (PDOException $e) {
            throw new DatabaseException('Failed to fetch user', 0, $e);
        }
    }

    /**
     * Save user with transaction support
     */
    public function save(User $user): User
    {
        $this->pdo->beginTransaction();
        
        try {
            if ($user->getId() === null) {
                $user = $this->insert($user);
            } else {
                $user = $this->update($user);
            }
            
            $this->pdo->commit();
            return $user;
        } catch (PDOException $e) {
            $this->pdo->rollBack();
            throw new DatabaseException('Failed to save user', 0, $e);
        }
    }

    private function insert(User $user): User
    {
        $stmt = $this->pdo->prepare(
            'INSERT INTO users (email, name, password_hash, created_at) 
             VALUES (:email, :name, :password_hash, NOW())'
        );
        
        $stmt->execute([
            ':email' => $user->getEmail(),
            ':name' => $user->getName(),
            ':password_hash' => $user->getPasswordHash()
        ]);

        $userId = (int) $this->pdo->lastInsertId();
        return $user->withId($userId);
    }

    /**
     * Optimized batch operations for performance
     */
    public function findMultipleById(array $ids): array
    {
        if (empty($ids)) {
            return [];
        }

        $placeholders = str_repeat('?,', count($ids) - 1) . '?';
        $stmt = $this->pdo->prepare(
            "SELECT id, email, name, created_at FROM users WHERE id IN ($placeholders)"
        );
        
        $stmt->execute($ids);
        
        return array_map(
            fn(array $userData) => User::fromArray($userData),
            $stmt->fetchAll(PDO::FETCH_ASSOC)
        );
    }
}
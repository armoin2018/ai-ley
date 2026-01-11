<?php
declare(strict_types=1);

namespace App\Services;

use App\Models\User;
use App\Exceptions\ValidationException;
use Psr\Log\LoggerInterface;

/**
 * User management service with modern PHP features
 */
class UserService
{
    public function __construct(
        private readonly LoggerInterface $logger,
        private readonly UserRepository $userRepository
    ) {}

    /**
     * Create a new user with validation
     *
     * @param array{email: string, name: string, password: string} $userData
     * @throws ValidationException
     */
    public function createUser(array $userData): User
    {
        $validatedData = $this->validateUserData($userData);
        
        $user = new User(
            email: $validatedData['email'],
            name: $validatedData['name'],
            passwordHash: $this->hashPassword($validatedData['password'])
        );

        $savedUser = $this->userRepository->save($user);
        
        $this->logger->info('User created successfully', [
            'user_id' => $savedUser->getId(),
            'email' => $savedUser->getEmail()
        ]);

        return $savedUser;
    }

    /**
     * Validate user registration data
     *
     * @param array<string, mixed> $data
     * @return array{email: string, name: string, password: string}
     * @throws ValidationException
     */
    private function validateUserData(array $data): array
    {
        $errors = [];

        if (!filter_var($data['email'] ?? '', FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = 'Invalid email format';
        }

        if (strlen($data['name'] ?? '') < 2) {
            $errors['name'] = 'Name must be at least 2 characters';
        }

        if (strlen($data['password'] ?? '') < 8) {
            $errors['password'] = 'Password must be at least 8 characters';
        }

        if (!empty($errors)) {
            throw new ValidationException('Validation failed', $errors);
        }

        return [
            'email' => $data['email'],
            'name' => $data['name'], 
            'password' => $data['password']
        ];
    }

    private function hashPassword(string $password): string
    {
        return password_hash($password, PASSWORD_ARGON2ID, [
            'memory_cost' => 65536,
            'time_cost' => 4,
            'threads' => 3
        ]);
    }
}
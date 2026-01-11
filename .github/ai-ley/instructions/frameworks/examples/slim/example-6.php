// src/Controllers/UserController.php
<?php

declare(strict_types=1);

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Services\UserService;
use Respect\Validation\Validator as v;

class UserController
{
    private UserService $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    public function getUsers(Request $request, Response $response): Response
    {
        try {
            $queryParams = $request->getQueryParams();
            $page = (int) ($queryParams['page'] ?? 1);
            $limit = (int) ($queryParams['limit'] ?? 10);

            $users = $this->userService->getAllUsers($page, $limit);
            
            $payload = json_encode([
                'status' => 'success',
                'data' => $users,
                'pagination' => [
                    'page' => $page,
                    'limit' => $limit
                ]
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function getUser(Request $request, Response $response, array $args): Response
    {
        try {
            $userId = (int) $args['id'];
            
            if (!v::intVal()->positive()->validate($userId)) {
                return $this->errorResponse($response, 'Invalid user ID', 400);
            }

            $user = $this->userService->getUserById($userId);
            
            if (!$user) {
                return $this->errorResponse($response, 'User not found', 404);
            }

            $payload = json_encode([
                'status' => 'success',
                'data' => $user
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function createUser(Request $request, Response $response): Response
    {
        try {
            $data = $request->getParsedBody();

            // Validation
            $validation = $this->validateUserData($data);
            if (!$validation['isValid']) {
                return $this->errorResponse($response, 'Validation failed', 400, $validation['errors']);
            }

            $user = $this->userService->createUser($data);

            $payload = json_encode([
                'status' => 'success',
                'message' => 'User created successfully',
                'data' => $user
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json')->withStatus(201);
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function updateUser(Request $request, Response $response, array $args): Response
    {
        try {
            $userId = (int) $args['id'];
            $data = $request->getParsedBody();

            if (!v::intVal()->positive()->validate($userId)) {
                return $this->errorResponse($response, 'Invalid user ID', 400);
            }

            $user = $this->userService->updateUser($userId, $data);
            
            if (!$user) {
                return $this->errorResponse($response, 'User not found', 404);
            }

            $payload = json_encode([
                'status' => 'success',
                'message' => 'User updated successfully',
                'data' => $user
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function deleteUser(Request $request, Response $response, array $args): Response
    {
        try {
            $userId = (int) $args['id'];

            if (!v::intVal()->positive()->validate($userId)) {
                return $this->errorResponse($response, 'Invalid user ID', 400);
            }

            $deleted = $this->userService->deleteUser($userId);
            
            if (!$deleted) {
                return $this->errorResponse($response, 'User not found', 404);
            }

            $payload = json_encode([
                'status' => 'success',
                'message' => 'User deleted successfully'
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    private function validateUserData(array $data): array
    {
        $errors = [];

        if (!v::notEmpty()->validate($data['name'] ?? '')) {
            $errors[] = 'Name is required';
        }

        if (!v::email()->validate($data['email'] ?? '')) {
            $errors[] = 'Valid email is required';
        }

        if (!v::notEmpty()->validate($data['password'] ?? '')) {
            $errors[] = 'Password is required';
        } elseif (!v::length(8, null)->validate($data['password'])) {
            $errors[] = 'Password must be at least 8 characters';
        }

        return [
            'isValid' => empty($errors),
            'errors' => $errors
        ];
    }

    private function errorResponse(Response $response, string $message, int $statusCode, array $errors = []): Response
    {
        $payload = json_encode([
            'status' => 'error',
            'message' => $message,
            'errors' => $errors
        ]);

        $response->getBody()->write($payload);
        return $response->withHeader('Content-Type', 'application/json')->withStatus($statusCode);
    }
}
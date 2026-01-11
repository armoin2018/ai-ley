<?php
declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Services\UserService;
use App\Http\Requests\CreateUserRequest;
use App\Http\Resources\UserResource;
use App\Exceptions\ValidationException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * User API controller following REST principles
 */
class UserController
{
    public function __construct(
        private readonly UserService $userService
    ) {}

    /**
     * Create a new user
     * 
     * @api {post} /api/users Create User
     * @apiName CreateUser
     * @apiGroup Users
     */
    public function store(Request $request): JsonResponse
    {
        try {
            $userData = $this->validateCreateUserRequest($request);
            $user = $this->userService->createUser($userData);

            return new JsonResponse(
                data: new UserResource($user),
                status: Response::HTTP_CREATED
            );
        } catch (ValidationException $e) {
            return new JsonResponse(
                data: [
                    'error' => 'Validation failed',
                    'message' => $e->getMessage(),
                    'errors' => $e->getErrors()
                ],
                status: Response::HTTP_UNPROCESSABLE_ENTITY
            );
        } catch (\Exception $e) {
            return new JsonResponse(
                data: [
                    'error' => 'Internal server error',
                    'message' => 'An unexpected error occurred'
                ],
                status: Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    /**
     * Get user by ID
     */
    public function show(int $id): JsonResponse
    {
        $user = $this->userService->findUserById($id);
        
        if ($user === null) {
            return new JsonResponse(
                data: ['error' => 'User not found'],
                status: Response::HTTP_NOT_FOUND
            );
        }

        return new JsonResponse(
            data: new UserResource($user),
            status: Response::HTTP_OK
        );
    }

    /**
     * List users with pagination
     */
    public function index(Request $request): JsonResponse
    {
        $page = (int) ($request->query->get('page', '1'));
        $perPage = (int) ($request->query->get('per_page', '15'));
        
        // Validate pagination parameters
        $page = max(1, $page);
        $perPage = min(100, max(1, $perPage));

        $users = $this->userService->getUsers($page, $perPage);

        return new JsonResponse(
            data: [
                'data' => UserResource::collection($users->getItems()),
                'pagination' => [
                    'current_page' => $users->getCurrentPage(),
                    'per_page' => $users->getPerPage(),
                    'total' => $users->getTotal(),
                    'last_page' => $users->getLastPage()
                ]
            ],
            status: Response::HTTP_OK
        );
    }

    private function validateCreateUserRequest(Request $request): array
    {
        $data = json_decode($request->getContent(), true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new ValidationException('Invalid JSON payload');
        }

        return $data;
    }
}
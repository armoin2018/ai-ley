// PHPUnit test example
<?php
declare(strict_types=1);

namespace Tests\Unit\Services;

use PHPUnit\Framework\TestCase;
use App\Services\UserService;
use App\Repositories\UserRepository;
use App\Exceptions\ValidationException;

class UserServiceTest extends TestCase
{
    private UserService $userService;
    private UserRepository $userRepository;

    protected function setUp(): void
    {
        $this->userRepository = $this->createMock(UserRepository::class);
        $this->userService = new UserService($this->userRepository);
    }

    public function testCreateUserWithValidData(): void
    {
        $userData = [
            'email' => 'test@example.com',
            'name' => 'John Doe',
            'password' => 'securepassword123'
        ];

        $expectedUser = new User(
            id: 1,
            email: 'test@example.com',
            name: 'John Doe'
        );

        $this->userRepository
            ->expects($this->once())
            ->method('save')
            ->willReturn($expectedUser);

        $result = $this->userService->createUser($userData);

        $this->assertEquals($expectedUser, $result);
    }

    public function testCreateUserWithInvalidEmailThrowsException(): void
    {
        $userData = [
            'email' => 'invalid-email',
            'name' => 'John Doe',
            'password' => 'securepassword123'
        ];

        $this->expectException(ValidationException::class);
        $this->expectExceptionMessage('Invalid email format');

        $this->userService->createUser($userData);
    }
}
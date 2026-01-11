<?php
declare(strict_types=1);

namespace App\Events;

class UserCreated
{
    public function __construct(
        public readonly User $user,
        public readonly \DateTimeImmutable $occurredAt = new \DateTimeImmutable()
    ) {}
}

// Event dispatcher
namespace App\Services;

class EventDispatcher
{
    private array $listeners = [];

    public function addListener(string $eventClass, callable $listener): void
    {
        $this->listeners[$eventClass][] = $listener;
    }

    public function dispatch(object $event): void
    {
        $eventClass = get_class($event);
        
        foreach ($this->listeners[$eventClass] ?? [] as $listener) {
            $listener($event);
        }
    }
}

// Usage in service
class UserService
{
    public function __construct(
        private readonly UserRepository $repository,
        private readonly EventDispatcher $eventDispatcher
    ) {}

    public function createUser(array $userData): User
    {
        $user = User::create($userData);
        $savedUser = $this->repository->save($user);
        
        $this->eventDispatcher->dispatch(new UserCreated($savedUser));
        
        return $savedUser;
    }
}
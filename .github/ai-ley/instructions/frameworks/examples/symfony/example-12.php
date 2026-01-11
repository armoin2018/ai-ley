// src/EventListener/UserCreatedListener.php
<?php

namespace App\EventListener;

use App\Event\UserCreatedEvent;
use App\Service\EmailService;
use App\Service\LoggingService;
use Symfony\Component\EventDispatcher\Attribute\AsEventListener;

class UserCreatedListener
{
    public function __construct(
        private EmailService $emailService,
        private LoggingService $loggingService
    ) {}

    #[AsEventListener(event: UserCreatedEvent::class)]
    public function onUserCreated(UserCreatedEvent $event): void
    {
        $user = $event->getUser();
        
        // Send welcome email
        $this->emailService->sendWelcomeEmail(
            $user->getEmail(),
            $user->getFirstName()
        );
        
        // Log user creation
        $this->loggingService->logUserAction('user_created', $user->getId());
    }
}
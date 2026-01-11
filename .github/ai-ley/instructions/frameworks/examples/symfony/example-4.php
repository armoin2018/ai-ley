// config/services.yaml
services:
    _defaults:
        autowire: true
        autoconfigure: true

    App\:
        resource: '../src/'
        exclude:
            - '../src/DependencyInjection/'
            - '../src/Entity/'
            - '../src/Kernel.php'

    App\Service\EmailService:
        arguments:
            $mailerDsn: '%env(MAILER_DSN)%'
            $fromEmail: '%env(FROM_EMAIL)%'

# Service class with dependency injection
// src/Service/EmailService.php
<?php

namespace App\Service;

use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;

class EmailService
{
    public function __construct(
        private MailerInterface $mailer,
        private string $mailerDsn,
        private string $fromEmail
    ) {}

    public function sendWelcomeEmail(string $to, string $name): void
    {
        $email = (new Email())
            ->from($this->fromEmail)
            ->to($to)
            ->subject('Welcome!')
            ->text("Welcome {$name}!");

        $this->mailer->send($email);
    }
}
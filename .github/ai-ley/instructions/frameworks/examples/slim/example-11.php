// src/Validators/UserValidator.php
<?php

declare(strict_types=1);

namespace App\Validators;

use Respect\Validation\Validator as v;

class UserValidator
{
    public static function validateCreate(array $data): array
    {
        $errors = [];

        if (!v::notEmpty()->validate($data['name'] ?? '')) {
            $errors['name'] = 'Name is required';
        } elseif (!v::length(2, 50)->validate($data['name'])) {
            $errors['name'] = 'Name must be between 2 and 50 characters';
        }

        if (!v::email()->validate($data['email'] ?? '')) {
            $errors['email'] = 'Valid email is required';
        }

        if (!v::notEmpty()->validate($data['password'] ?? '')) {
            $errors['password'] = 'Password is required';
        } elseif (!v::length(8, null)->validate($data['password'])) {
            $errors['password'] = 'Password must be at least 8 characters';
        }

        return [
            'isValid' => empty($errors),
            'errors' => $errors
        ];
    }

    public static function validateUpdate(array $data): array
    {
        $errors = [];

        if (isset($data['name']) && !v::length(2, 50)->validate($data['name'])) {
            $errors['name'] = 'Name must be between 2 and 50 characters';
        }

        if (isset($data['email']) && !v::email()->validate($data['email'])) {
            $errors['email'] = 'Valid email is required';
        }

        if (isset($data['password']) && !v::length(8, null)->validate($data['password'])) {
            $errors['password'] = 'Password must be at least 8 characters';
        }

        return [
            'isValid' => empty($errors),
            'errors' => $errors
        ];
    }
}
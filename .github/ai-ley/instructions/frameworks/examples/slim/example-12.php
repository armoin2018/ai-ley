// src/Services/AuthService.php
<?php

declare(strict_types=1);

namespace App\Services;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuthService
{
    private string $jwtSecret;
    private string $algorithm;
    private int $expirationTime;

    public function __construct(string $jwtSecret, string $algorithm = 'HS256', int $expirationTime = 3600)
    {
        $this->jwtSecret = $jwtSecret;
        $this->algorithm = $algorithm;
        $this->expirationTime = $expirationTime;
    }

    public function generateToken(array $userData): string
    {
        $issuedAt = time();
        $expirationTime = $issuedAt + $this->expirationTime;

        $payload = [
            'iat' => $issuedAt,
            'exp' => $expirationTime,
            'user' => [
                'id' => $userData['id'],
                'email' => $userData['email'],
                'name' => $userData['name']
            ]
        ];

        return JWT::encode($payload, $this->jwtSecret, $this->algorithm);
    }

    public function validateToken(string $token): ?array
    {
        try {
            $decoded = JWT::decode($token, new Key($this->jwtSecret, $this->algorithm));
            return (array) $decoded;
        } catch (\Exception $e) {
            return null;
        }
    }

    public function refreshToken(string $token): ?string
    {
        $decoded = $this->validateToken($token);
        
        if (!$decoded) {
            return null;
        }

        return $this->generateToken($decoded['user']);
    }
}
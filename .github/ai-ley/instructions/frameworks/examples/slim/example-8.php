// src/Services/UserService.php
<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\User;
use Illuminate\Database\Capsule\Manager as DB;

class UserService
{
    public function getAllUsers(int $page = 1, int $limit = 10): array
    {
        $offset = ($page - 1) * $limit;
        
        $users = DB::table('users')
            ->select(['id', 'name', 'email', 'created_at'])
            ->offset($offset)
            ->limit($limit)
            ->get()
            ->toArray();

        return array_map(function($user) {
            return (array) $user;
        }, $users);
    }

    public function getUserById(int $id): ?array
    {
        $user = DB::table('users')
            ->select(['id', 'name', 'email', 'created_at'])
            ->where('id', $id)
            ->first();

        return $user ? (array) $user : null;
    }

    public function createUser(array $data): array
    {
        $hashedPassword = password_hash($data['password'], PASSWORD_DEFAULT);
        
        $userId = DB::table('users')->insertGetId([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $hashedPassword,
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s')
        ]);

        return $this->getUserById($userId);
    }

    public function updateUser(int $id, array $data): ?array
    {
        $updateData = [
            'updated_at' => date('Y-m-d H:i:s')
        ];

        if (isset($data['name'])) {
            $updateData['name'] = $data['name'];
        }

        if (isset($data['email'])) {
            $updateData['email'] = $data['email'];
        }

        if (isset($data['password'])) {
            $updateData['password'] = password_hash($data['password'], PASSWORD_DEFAULT);
        }

        $updated = DB::table('users')
            ->where('id', $id)
            ->update($updateData);

        return $updated ? $this->getUserById($id) : null;
    }

    public function deleteUser(int $id): bool
    {
        return DB::table('users')->where('id', $id)->delete() > 0;
    }

    public function authenticateUser(string $email, string $password): ?array
    {
        $user = DB::table('users')
            ->where('email', $email)
            ->first();

        if ($user && password_verify($password, $user->password)) {
            return [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email
            ];
        }

        return null;
    }
}
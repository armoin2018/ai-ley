// src/Helpers/ResponseHelper.php
<?php

declare(strict_types=1);

namespace App\Helpers;

use Psr\Http\Message\ResponseInterface as Response;

class ResponseHelper
{
    public static function json(Response $response, array $data, int $status = 200): Response
    {
        $payload = json_encode($data);
        $response->getBody()->write($payload);
        
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus($status);
    }

    public static function success(Response $response, $data = null, string $message = 'Success'): Response
    {
        return self::json($response, [
            'status' => 'success',
            'message' => $message,
            'data' => $data
        ]);
    }

    public static function error(Response $response, string $message, int $status = 400, array $errors = []): Response
    {
        return self::json($response, [
            'status' => 'error',
            'message' => $message,
            'errors' => $errors
        ], $status);
    }

    public static function paginated(Response $response, array $data, int $page, int $limit, int $total): Response
    {
        return self::json($response, [
            'status' => 'success',
            'data' => $data,
            'pagination' => [
                'page' => $page,
                'limit' => $limit,
                'total' => $total,
                'pages' => ceil($total / $limit)
            ]
        ]);
    }
}
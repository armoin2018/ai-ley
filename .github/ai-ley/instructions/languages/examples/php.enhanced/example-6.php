<?php
declare(strict_types=1);

namespace App\Repositories;

use Psr\Cache\CacheItemPoolInterface;
use App\Models\User;

class CachedUserRepository implements UserRepositoryInterface
{
    public function __construct(
        private readonly UserRepositoryInterface $repository,
        private readonly CacheItemPoolInterface $cache
    ) {}

    public function findById(int $id): ?User
    {
        $cacheKey = "user.{$id}";
        $cacheItem = $this->cache->getItem($cacheKey);

        if ($cacheItem->isHit()) {
            return $cacheItem->get();
        }

        $user = $this->repository->findById($id);
        
        if ($user !== null) {
            $cacheItem->set($user);
            $cacheItem->expiresAfter(3600); // 1 hour
            $this->cache->save($cacheItem);
        }

        return $user;
    }

    public function save(User $user): User
    {
        $savedUser = $this->repository->save($user);
        
        // Invalidate cache
        $this->cache->deleteItem("user.{$savedUser->getId()}");
        
        return $savedUser;
    }
}
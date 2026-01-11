// src/Controller/ProductController.php
<?php

namespace App\Controller;

use App\Entity\Product;
use App\Service\ProductService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Attributes as OA;

#[Route('/api/products')]
#[OA\Tag(name: 'Products')]
class ProductController extends AbstractController
{
    public function __construct(
        private ProductService $productService,
        private SerializerInterface $serializer,
        private ValidatorInterface $validator
    ) {}

    #[Route('', methods: ['GET'])]
    #[OA\Get(description: 'Get all products')]
    #[OA\Response(response: 200, description: 'List of products')]
    public function index(): JsonResponse
    {
        $products = $this->productService->getAllProducts();
        
        return $this->json($products, context: [
            'groups' => 'product:read'
        ]);
    }

    #[Route('', methods: ['POST'])]
    #[OA\Post(description: 'Create a new product')]
    #[OA\RequestBody(content: new OA\JsonContent(ref: '#/components/schemas/Product'))]
    public function create(Request $request): JsonResponse
    {
        $product = $this->serializer->deserialize(
            $request->getContent(),
            Product::class,
            'json',
            ['groups' => 'product:write']
        );

        $errors = $this->validator->validate($product);
        if (count($errors) > 0) {
            return $this->json(['errors' => (string) $errors], 400);
        }

        $product = $this->productService->createProduct($product);
        
        return $this->json($product, 201, [], ['groups' => 'product:read']);
    }
}
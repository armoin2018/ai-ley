// app/Controllers/PostController.php
<?php

namespace App\Controllers;

use App\Models\PostModel;
use CodeIgniter\RESTful\ResourceController;

class PostController extends ResourceController
{
    protected $modelName = 'App\Models\PostModel';
    protected $format = 'json';

    public function create()
    {
        $rules = [
            'title' => 'required|min_length[3]|max_length[255]',
            'content' => 'required|min_length[10]',
            'category_id' => 'required|is_natural_no_zero',
            'featured_image' => 'uploaded[featured_image]|is_image[featured_image]|max_size[featured_image,2048]'
        ];

        if (!$this->validate($rules)) {
            return $this->failValidationErrors($this->validator->getErrors());
        }

        // Handle file upload
        $file = $this->request->getFile('featured_image');
        $imagePath = null;
        
        if ($file->isValid() && !$file->hasMoved()) {
            $imagePath = $file->store('uploads/posts');
        }

        $data = [
            'title' => $this->request->getPost('title'),
            'content' => $this->request->getPost('content'),
            'category_id' => $this->request->getPost('category_id'),
            'featured_image' => $imagePath,
            'user_id' => session()->get('user_id'),
            'status' => 'published'
        ];

        $postId = $this->model->insert($data);
        $post = $this->model->find($postId);

        return $this->respondCreated($post);
    }

    public function update($id = null)
    {
        $post = $this->model->find($id);
        
        if (!$post) {
            return $this->failNotFound('Post not found');
        }

        // Check ownership
        if ($post['user_id'] !== session()->get('user_id')) {
            return $this->failForbidden('You can only edit your own posts');
        }

        $rules = [
            'title' => 'required|min_length[3]|max_length[255]',
            'content' => 'required|min_length[10]',
            'category_id' => 'required|is_natural_no_zero'
        ];

        if (!$this->validate($rules)) {
            return $this->failValidationErrors($this->validator->getErrors());
        }

        $data = [
            'title' => $this->request->getPost('title'),
            'content' => $this->request->getPost('content'),
            'category_id' => $this->request->getPost('category_id')
        ];

        // Handle file upload if new image provided
        $file = $this->request->getFile('featured_image');
        if ($file && $file->isValid() && !$file->hasMoved()) {
            // Delete old image
            if ($post['featured_image'] && file_exists(WRITEPATH . 'uploads/' . $post['featured_image'])) {
                unlink(WRITEPATH . 'uploads/' . $post['featured_image']);
            }
            
            $data['featured_image'] = $file->store('uploads/posts');
        }

        $this->model->update($id, $data);
        $post = $this->model->find($id);

        return $this->respond($post);
    }
}
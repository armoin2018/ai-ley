// app/Controllers/UserController.php
<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;

class UserController extends ResourceController
{
    use ResponseTrait;

    protected $modelName = 'App\Models\UserModel';
    protected $format = 'json';

    public function index()
    {
        $users = $this->model->findAll();
        return $this->respond($users);
    }

    public function show($id = null)
    {
        $user = $this->model->find($id);
        
        if (!$user) {
            return $this->failNotFound('User not found');
        }
        
        return $this->respond($user);
    }

    public function create()
    {
        $data = $this->request->getJSON(true);
        
        if (!$this->validate($this->getValidationRules())) {
            return $this->failValidationErrors($this->validator->getErrors());
        }
        
        $userId = $this->model->insert($data);
        $user = $this->model->find($userId);
        
        return $this->respondCreated($user);
    }

    public function update($id = null)
    {
        $user = $this->model->find($id);
        
        if (!$user) {
            return $this->failNotFound('User not found');
        }
        
        $data = $this->request->getJSON(true);
        
        if (!$this->validate($this->getValidationRules())) {
            return $this->failValidationErrors($this->validator->getErrors());
        }
        
        $this->model->update($id, $data);
        $user = $this->model->find($id);
        
        return $this->respond($user);
    }

    private function getValidationRules()
    {
        return [
            'name' => 'required|min_length[3]|max_length[50]',
            'email' => 'required|valid_email|is_unique[users.email]',
            'password' => 'required|min_length[8]'
        ];
    }
}
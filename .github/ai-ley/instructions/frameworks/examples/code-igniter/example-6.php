// app/Views/users/index.php
<?= $this->extend('layouts/main') ?>

<?= $this->section('title') ?>User Management<?= $this->endSection() ?>

<?= $this->section('content') ?>
<div class="container">
    <h1>Users</h1>
    
    <div class="row mb-3">
        <div class="col">
            <a href="<?= route_to('users.create') ?>" class="btn btn-primary">Add New User</a>
        </div>
    </div>
    
    <?php if (session()->getFlashdata('success')): ?>
        <div class="alert alert-success">
            <?= session()->getFlashdata('success') ?>
        </div>
    <?php endif; ?>
    
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($users as $user): ?>
                <tr>
                    <td><?= $user['id'] ?></td>
                    <td><?= esc($user['name']) ?></td>
                    <td><?= esc($user['email']) ?></td>
                    <td>
                        <span class="badge bg-<?= $user['status'] === 'active' ? 'success' : 'secondary' ?>">
                            <?= ucfirst($user['status']) ?>
                        </span>
                    </td>
                    <td><?= date('M j, Y', strtotime($user['created_at'])) ?></td>
                    <td>
                        <a href="<?= route_to('users.show', $user['id']) ?>" class="btn btn-sm btn-info">View</a>
                        <a href="<?= route_to('users.edit', $user['id']) ?>" class="btn btn-sm btn-warning">Edit</a>
                        <form method="post" action="<?= route_to('users.delete', $user['id']) ?>" style="display:inline;">
                            <?= csrf_field() ?>
                            <input type="hidden" name="_method" value="DELETE">
                            <button type="submit" class="btn btn-sm btn-danger" 
                                    onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    
    <?= $pager->links() ?>
</div>
<?= $this->endSection() ?>

// app/Views/layouts/main.php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $this->renderSection('title') ?> - My App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <?= $this->renderSection('head') ?>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="<?= route_to('/') ?>">My App</a>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="<?= route_to('users.index') ?>">Users</a>
                </li>
            </ul>
        </div>
    </nav>
    
    <main class="py-4">
        <?= $this->renderSection('content') ?>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <?= $this->renderSection('scripts') ?>
</body>
</html>
// Good: Parameterized query
$stmt = $pdo->prepare("
    SELECT id, username, email
    FROM user_accounts
    WHERE username = ? AND status = ?
");
$stmt->execute([$username, 'active']);
$user = $stmt->fetch();

// Good: Named parameters
$stmt = $pdo->prepare("
    UPDATE user_accounts
    SET
        email = :email,
        updated_at = NOW()
    WHERE id = :user_id AND status = 'active'
");
$stmt->execute([
    'email' => $new_email,
    'user_id' => $user_id
]);
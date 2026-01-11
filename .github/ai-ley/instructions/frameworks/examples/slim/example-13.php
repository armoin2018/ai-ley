$capsule = new \Illuminate\Database\Capsule\Manager;
  $capsule->addConnection($databaseConfig);
  $capsule->setAsGlobal();
  $capsule->bootEloquent();
$redis = new \Predis\Client();
  $redis->set('key', 'value', 'EX', 3600);
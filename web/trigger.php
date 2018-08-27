<?php
require_once __DIR__.'/vendor/autoload.php';

use Monolog\Handler\ElasticSearchHandler;
use Monolog\Logger;
use Elastica\Client;

$client = new Client(['host' => 'elk', 'port' => 9200]);
$options = ['index' => 'security_log'];

$handler = new ElasticSearchHandler($client, $options);
$log = new Logger('security_log');
$log->pushHandler($handler);

$message = 'This is a test';

for ($i = 0; $i < 10; $i++) {
    $rand = md5(random_bytes(64));
    $log->error($message, ['rand' => $rand]);
}

?>
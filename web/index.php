<?php

require_once __DIR__.'/vendor/autoload.php';

use Monolog\Handler\ElasticSearchHandler;
use Monolog\Logger;
use Elastica\Client;

$index = 'security_log';
$recordData = [
    'message' => 'This is a test'
];

$client = new \Elastica\Client(['host' => 'elk', 'port' => 9200]);
$index = $client->getIndex($index);
$type = $index->getType('record');

$id = hash('sha256', random_bytes(64));
$doc = new \Elastica\Document($id, $recordData);
$response = $type->addDocument($doc);

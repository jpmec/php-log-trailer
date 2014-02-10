<?php

set_include_path('lib');

require 'Slim/Slim.php';


\Slim\Slim::registerAutoloader();


$app = new \Slim\Slim();




$app->get('/', function () use ($app) {

    //$app->response->headers->set('Content-Type', 'application/json');

    //$result = array();

    //$result['filename'] = '/private/var/log/apache2/error_log';
    //$result['stat'] = stat('/private/var/log/apache2/error_log');

    $filename = '/Library/WebServer/Documents/trailer/stats.json';


    echo file_get_contents($filename);

});




$app->get('/stats/', function () use ($app) {
    $filename = '/Library/WebServer/Documents/trailer/stats.json';
    echo file_get_contents($filename);
});



$app->get('/log/', function () {
    echo file_get_contents('/private/var/log/apache2/error_log');
});




$app->get('/table/', function () {

    $data = array(
        array('name' => 'Alice'),
        array('name' => 'Bob')
    )

    echo json_encode($data);
});




$app->run();

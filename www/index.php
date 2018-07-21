<?php
define('ROOT_PATH', __DIR__);

$url = ltrim($_SERVER['REQUEST_URI'], '/');

$files = glob('config/*.php');
foreach ($files as $file) {
   require $file;
}

// ignore the current include path!
set_include_path('.' . PATH_SEPARATOR . MVC . PATH_SEPARATOR . CONTROLLERS  . PATH_SEPARATOR . MODELS . PATH_SEPARATOR . VIEWS);

require 'app.php';

$app = new App();
$app->init($url);
$app->run();

?>
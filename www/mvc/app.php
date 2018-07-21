<?php

class App
{
   public function __construct()
   {
      setlocale(LC_ALL, 'de_DE');
      spl_autoload_register(array($this, 'autoloader'));
      set_error_handler(array($this, 'errorHandler'));
   }

   public function autoloader($class)
   {
      $classfile = strtolower($class . '.php');
      require_once $classfile;
   }

   public function init($url)
   {
      $this->url = $url;

      $this->router = new Router();
      $this->request = $this->router->route($this->url);

      $contollerName = $this->request[0] . 'Controller';
      $contollerFilename = DIRECTORY_SEPARATOR . strtolower($contollerName) . '.php';

      if (file_exists(CONTROLLERS . $contollerFilename)) {
         $this->controller = new $contollerName();
      } else {
         $this->controller = new ErrorController();
      }

      $this->controller->init($this->request);
   }

   public function run()
   {
      // nice view of complete structure
      //$this->dump($this);

      $this->controller->run();
   }

   public function errorHandler($type, $message, $file, $line)
   {
      $error = (object) array('type' => $type, 'message' => $message, 'file' => $file, 'line' => $line);
      $this->dump($error);
   }

   public function dump($data)
   {
      echo '<pre>';
      print_r($data);
      echo '</pre>';
      exit();
   }
}

?>
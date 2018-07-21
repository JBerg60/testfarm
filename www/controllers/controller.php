<?php

class Controller
{
   public function init($request)
   {
      $this->request = $request;

      $this->model = $this->loadModel();
      if($this->model) {
         $this->model->init($this);
      }

      $this->view = $this->loadView();
      $this->view->init($this);
   }

   public function loadView()
   {
      $viewName = $this->request[0] . 'view';
      $viewFilename = DIRECTORY_SEPARATOR . $viewName . '.php';

      if (file_exists(VIEWS. $viewFilename)) {
         return new $viewName();
      } else {
         return new View(); // default
      }
   }

   public function loadModel()
   {
      $modelName = $this->request[0] . 'model';
      $modelFilename = DIRECTORY_SEPARATOR . $modelName . '.php';

      if (file_exists(MODELS . $modelFilename)) {
         return new $modelName();
      } else {
         return null;
      }
   }

   public function index()
   {
      $this->dump($this);
   }

   public function run()
   {
      if(count($this->request) < 2) {
         $this->request[1] = 'index';
      }
      $args = array_slice($this->request, 2);
      call_user_func_array(array($this,$this->request[1]), $args);
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
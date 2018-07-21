<?php

class View
{
   public function init($controller)
   {
      $this->controller = $controller;
   }

   public function render($name)
   {
      if (file_exists(VIEWS . DIRECTORY_SEPARATOR . $name . '.php')) {
         require VIEWS . DIRECTORY_SEPARATOR . $name . '.php';
      } else {
         $this->dump($this);
      }
   }

   public function show($fileName, $values)
   {
      if (is_array($values)) {
         foreach ($values as $key => $value) {
            $this->$key = $value;
         }
      }

      include $fileName;
   }

   public function getClass($classname, $condition)
   {
      return $condition ? $classname : "";
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
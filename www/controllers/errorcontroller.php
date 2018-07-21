<?php

class ErrorController extends Controller
{
   public function init($request)
   {
      array_splice($request, 0, 0, 'error');
      array_splice($request, 1, 0, 'index');
      $this->request = $request;
   }

   public function index($a = false, $b = false)
   {
      $this->dump($this);
   }
}

?>
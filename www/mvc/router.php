<?php

class Router
{
   protected $defaulturl = false;
   public $params = [];

   public function __construct($defaulturl = 'index')
   {
      $this->defaulturl = $defaulturl;
   }

   public function route($url)
   {
      // if no url given, fallback to default
      if (!isset($url) || trim($url) === '') {
         $url = $this->defaulturl;
      }

      $args = explode('?', ltrim($url, '/'));

      // parse all outer params into a array
      if (isset($args[1])) {
         parse_str($args[1], $this->params);
      }

      //args[0] is the request
      return explode('/', rtrim($args[0], '/'));
   }
}

?>

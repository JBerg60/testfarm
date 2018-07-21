<?php

class SystemController extends Controller
{
   public function reboot()
   {
      $this->view->render('system/reboot');
      exec('sudo /sbin/reboot', $msg);
   }
}

?>
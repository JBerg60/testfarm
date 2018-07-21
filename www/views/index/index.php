<!DOCTYPE html>
<html lang="de">

<head>
   <?php $this->show(VIEWS . '/head.php', ["title" => 'Raspberry Pi Testfarm']);?>
</head>

<body class="">

   <div id="header" class="row">
      <?php $this->show(VIEWS . '/top.php', []);?>
   </div>

   <div id="menu">
      <?php $this->show(VIEWS . '/menu.php', ["menu" => 1]);?>
   </div>

   <div id="content">
      <div class="well">
         <h5>WiFi</h5>
         <hr />
         <pre>
         <?php
            exec('ip addr show wlan0 | grep inet', $inet);
            $part = explode(' ', trim($inet[0])); //ip v4 and ip v6 address
            print_r($part);
         ?>
         </pre>
      </div>
   </div>

   <div id="status">
      <?php $this->show(VIEWS . '/status.php', []);?>
   </div>
</body>

</html>

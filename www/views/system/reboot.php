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
      <p>
         Rebooting, please wait ...
      </p>
   </div>

   <div id="status">
      <?php $this->show(VIEWS . '/status.php', []);?>
   </div>
</body>

</html>

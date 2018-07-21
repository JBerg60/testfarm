<ul class="pure-menu-list">
   <li class="pure-menu-item
      <?php echo $this->getClass('pure-menu-selected', $this->menu == 1); ?>" >
      <a href="/" class="pure-menu-link">Dashboard</a>
   </li>
   <li class="pure-menu-item
      <?php echo $this->getClass('pure-menu-selected', $this->menu == 2); ?>" >
      <a href="/system/reboot" class="pure-menu-link">Reboot</a>
   </li>
</ul>
import os
os.system('sudo ifconfig eth0 down')
os.system('sudo ifconfig eth0 192.168.51.1')
os.system('sudo ifconfig eth0 up')
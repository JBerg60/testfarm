import json
import subprocess
import os
import pprint
from urllib.request import Request, urlopen


def getserial():
    # Extract serial from cpuinfo file
    cpuserial = "0000000000000000"
    try:
        f = open('/proc/cpuinfo', 'r')
        for line in f:
            if line[0:6] == 'Serial':
                cpuserial = line[10:26]
        f.close()
    except:
        cpuserial = "ERROR000000000"

    return cpuserial.upper()


def getip():
    return os.popen('ip addr show wlan0').read().split("inet ")[1].split("/")[0]


result = subprocess.run(
    ['hostnamectl', 'status'], stdout=subprocess.PIPE).stdout.decode('latin1')
lines = result.split('\n')
values = list(map(lambda line: line.split(':'), lines))
data = {} 

for value in values:
    if not len(value) == 2:
        continue

    data[value[0].strip()] = value[1].strip()

data['Serial'] = getserial()
data['Ip'] = getip()

print("json request:")
pp = pprint.PrettyPrinter(indent=4)
pp.pprint(data)
# print(json.dumps(data).encode())

# request = Request('http://manufacturing.riedel.net/api/v1/testfarm/register', json.dumps(data).encode())
request = Request('http://192.168.0.36/api/v1/testfarm/register', json.dumps(data).encode())
reqestreturn = urlopen(request).read().decode()

print("\njson result:")
pp.pprint(json.loads(reqestreturn))

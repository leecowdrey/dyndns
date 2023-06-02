# Dynamic DNS for CloudFloor DNS (mtgsy)

## PID of dyndns:

- option 1: pgrep dyndns
- option 2: cat /var/run/dyndns.pid
- option 3: grep dyndns /var/log/syslog

## Reload configuration data held in dyndns.json:

- kill -1 $(pgrep dyndns)

##  Clean start/stop dyndns:

- systemctl stop dyndns
- systemctl start dyndns
- systemctl status dyndns

## Supported KILL signals:

- SIGHUP reload configuration: kill -s 1 $(pgrep dyndns)
- SIGINT force exit leave VIP as is: kill -s 2 $(pgrep dyndns)
- SIGKILL force exit leave VIP as is: kill -s 9 $(pgrep dyndns)
- SIGALRM awake from any inactive sleep loop: kill -s 14 $(pgrep dyndns)
- SIGTERM force exit bring down VIP if up: kill -s 15 $(pgrep dyndns)

**BROKEN!**

The Script is currently non functional.

# storj_stats
A bash script to access your Storj Stats using the dashboard API.

# Usage
The Script is called using `storj_stats.sh <stat>`. It can show you the following stats:

stat | unit
--- | ---
egress | byte
ingress | byte
disk | byte
upToDate | 0/1

If you want additional stats like `egress today`, the script is very easily extensible. Alternatively, you could contact me ;)

# How it works
For `egress` and `ingress` the script first reads out the available satellites from the dashboard api. It then collects the traffic for each satellite. The result of this is an array with the traffic for each day, which is then being added up.

The `disk` and `upToDate` stats are being read out from the api directly. `upToDate` returns a true or false, which the script converts into 1 or 0.

# Prerequisites
* The dashboard api has to be accessible at `127.0.0.1:14002`. (Add the -p 14002:14002 argument to your docker run command. [Additional help](https://forum.storj.io/t/remote-dashboard/2003))
* [jq](https://stedolan.github.io/jq/)

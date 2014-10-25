#!/bin/bash
# SSH over DNS Tunnel - Client Helper Script
# Copyright 2010 Kevin Lange <lange7@acm.uiuc.edu>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Default values (change these!)
DNS_USER=klange
DNS_SERVER=dakko.us
DNS_SOCKS=8080

IS_RUNNING=`ps -A aux | grep sshns | grep -v grep`

if [ $1 == "-h" ]; then
    echo "Usage: $0 [-i]"
    echo "  Use -i to start an SSH shell, otherwise the script will start"
    echo "  ssh in interactive session mode and then go to background."
    echo ""
    echo "  SSH DNS Tunnel - Helper Script"
    echo "  Copyright 2010 Kevin Lange <lange7@acm.uiuc.edu>"
    echo "  This program is free software released under the GPLv3."
    echo ""
    echo "  Server:     $DNS_SERVER"
    echo "  User:       $DNS_USER"
    echo "  SOCKS Port: $DNS_SOCKS"
    echo ""
    echo "  NOTICE: Be sure that your server is configured for publickey authentication"
    echo "  and that you have added your key so that you are not prompted for a password"
    echo "  or the tunnel will fail to authenticate!"
else
    if [ ! "$IS_RUNNING" == "" ]; then
        echo "WARNING: Tunnel may already be running!"
    fi
    if [ $1 == "-i" ]; then
        ssh -o BatchMode=no -o ProxyCommand="python2.5 -ui sshns/droute.py" -24 -c blowfish -C $DNS_USER@$DNS_SERVER
    else
        ssh -o BatchMode=yes -o ProxyCommand="python2.5 -ui sshns/droute.py -v" -vv -24 -Nf -c blowfish -D $DNS_SOCKS -C $DNS_USER@$DNS_SERVER
    fi
fi

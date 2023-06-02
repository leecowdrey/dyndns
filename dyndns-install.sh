#!/bin/bash
#MODE="INSTALL|UNINSTALL"
if [ -z "${1}i" ] ; then
 exit 1
else
 MODE="${1^^}"
fi

if [ "${MODE^^}" == "INSTALL" ] ; then

#    test -x jq || apt-get -y install jq
#    test -x curl || apt-get -y install curl
#    test -x logger || apt-get -y install logger
#    test -x sed || apt-get -y install sed
#    test -x systemctl || apt-get -y install systemctl

    if [ ! -f /etc/dyndns.json ] ; then
        cp etc/dyndns.json /etc/ && \
        chown root:root /etc/dyndns.json && \
        chmod 640 /etc/dyndns.json
    fi

    if [ ! -d /usr/local/sbin ] ; then
        mkdir -p /usr/local/sbin && \
        chmod 755 /usr/local/sbin && \
        chown root:root /usr/local/sbin
    fi

    if [ ! -f /etc/systemd/system/dyndns.service ] ; then
        cp etc/systemd/system/dyndns.service /etc/systemd/system/ && \
        chown root:root /etc/systemd/system/dyndns.service && \
        chmod 644 /etc/systemd/system/dyndns.service
    fi

    if [ ! -f /usr/local/sbin/dyndns ] ; then
        cp usr/local/sbin/dyndns /usr/local/sbin/ && \
        chown root:root /usr/local/sbin/dyndns && \
        chmod 755 /usr/local/sbin/dyndns
    fi

    systemctl daemon-reload && \
    systemctl enable dyndns.service && \
    systemctl start dyndns && \
    systemctl status dyndns
elif [ "${MODE^^}" == "UNINSTALL" ] ; then
    systemctl stop dyndns 
    systemctl status dyndns 
    systemctl disable dyndns.service 
    systemctl daemon-reload
    [[ -f /etc/dyndns.json ]] && rm -f /etc/dyndns.json
    [[ -f /etc/systemd/system/dyndns.service ]] && rm -f /etc/systemd/system/dyndns.service
    [[ -f /usr/local/sbin/dyndns ]] && rm -f /usr/local/sbin/dyndns
fi


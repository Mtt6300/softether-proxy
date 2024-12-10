#!/bin/bash

./vpnclient start

sleep 5

./vpncmd localhost /CLIENT /CMD AccountCreate me /SERVER:${VPN_HOST}:${VPN_PORT} /HUB:${VPN_HUB} /USERNAME:${VPN_USERNAME} /NICNAME:soft
./vpncmd localhost /CLIENT /CMD AccountPasswordSet me /PASSWORD:${VPN_PASSWORD} /TYPE:standard
./vpncmd localhost /CLIENT /CMD AccountConnect me


if [ -n "${VPN_STATIC_CLIENT_IP}" ]; then
    echo "Assigning static IP: ${VPN_STATIC_CLIENT_IP}..."
    ip addr add ${VPN_STATIC_CLIENT_IP} dev vpn_vpn
    ip link set vpn_vpn up
fi

ip route add ${VPN_GATEWAY} dev vpn_vpn

IFS=',' read -ra ROUTES <<< "${VPN_ROUTE}"
for ROUTE in "${ROUTES[@]}"; do
    echo "Adding route to ${ROUTE} via ${VPN_GATEWAY}..."
    ip route add ${ROUTE} via ${VPN_GATEWAY} dev vpn_vpn
done


sleep 5
./vpncmd localhost /CLIENT /CMD AccountStatusGet me

tinyproxy -d

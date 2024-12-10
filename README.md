# softether-proxy



## docker-compose.yml
```yaml
version: "3.8"
services:
  vpn-proxy:
    image: mtt6300/softether-proxy:v4.41-9782-beta-2022.11.17
    container_name: vpn-proxy
    privileged: true
    ports:
      - "3128:3128"
    cap_add:
      - NET_ADMIN
    environment:
      VPN_HOST: host
      VPN_PORT: port
      VPN_HUB: DEFAULT
      VPN_USERNAME: username
      VPN_PASSWORD: password
      VPN_GATEWAY: gateway
      VPN_ROUTE: route-ip1,route-ip2,route-ip3
      VPN_STATIC_CLIENT_IP: static-client-ip
```
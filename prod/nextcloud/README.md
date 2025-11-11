#Installeren:
1. zorg dat mariadb draait
2. kubectl apply -f 

#NATS
Neural Autonomic Transport System
| Feature                    | Role of NATS in Nextcloud                 |
| -------------------------- | ----------------------------------------- |
| Real-time events           | Broadcast file/app events across services |
| Microservice messaging     | Decouples internal communication          |
| Push notifications         | Enables scalable mobile/web push          |
| Scaling WebSocket services | Helps distribute WebSocket load           |
#SPREED
"Spread" + "Speed"
Spreed started as a standalone WebRTC project, originally developed by the German company struktur AG.
Struktur AG was later acquired by Nextcloud GmbH, and Spreed became tightly integrated with Nextcloud Talk.
| Feature                    | Role of Spreed                                   |
| -------------------------- | ------------------------------------------------ |
| **Video & voice calls**    | Handles WebRTC signaling for 1:1 and group calls |
| **Text chat**              | Powers chat rooms, messages, mentions, etc.      |
| **Screensharing**          | Facilitates screen sharing over WebRTC           |
| **TURN/STUN support**      | Helps users connect through firewalls/NATs       |
| **Signaling server**       | Coordinates call setup between users             |
| **Multiparty conferences** | Manages group call state and media routing       |
The High-performance backend developed by our Partner Struktur AG available in their 
GitHub organisation. 
The High-performance backend itself consists of multiple modules, the most important ones 
being a: 
- signaling server and a 
- WebRTC media gateway.

Nextcloud Talk comes as an app within Nextcloud, but it needs 
- Spreed (the WebRTC backend) and a 
- TURN server for video and audio calls. The best practice is to set up Coturn for this.

#TURN server: 
This acts as a fallback for peer-to-peer connections if direct connection fails.
A TURN server is used to proxy the traffic from participants behind a firewall. 
If individual participants cannot connect to others a TURN server is most likely required
Voor Matrix en Nextcloud gebruiken we coturn. coturn draait in cluster LattePanda en is door traefik exposed op poorten:

 - name: turn-udp
containerPort: 3478
protocol: UDP
 - name: turn-tcp
containerPort: 3478
protocol: TCP
 - name: turns-tcp
containerPort: 5349
protocol: TCP

#STUN server: 
This is used to discover the public IP address of a client when it's behind a NAT (e.g., router).

#Handige commando's:

kubectl exec -n nextcloud -it deployment/nextcloud -- cat /var/www/html/config/config.php

#Upgrade:
kubectl exec -it nextcloud-55b6c999bd-pzwxb -n nextcloud  -- php /var/www/html/occ upgrade

5-10-2025: upgrade naar 32.0.0





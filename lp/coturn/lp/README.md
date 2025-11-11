#configuratie:

Ik heb: hostNetwork: true — so ports 3478 (UDP/TCP) and 5349 (TCP) are bound directly on the node network interface.

#ACHTERGRONFINFO

#ICE server (Interactive Connectivity Establishment server) 
is a network component used in 
#WebRTC (Web Real-Time Communication) 
and other peer-to-peer communication protocols to facilitate the establishment of a direct connection 
between two devices (peers) over the internet.

ICE is a framework used to handle the complexities of establishing these connections, 
especially when peers are behind firewalls or NATs (Network Address Translators). 
The main role of an ICE server is to help peers find the best possible path for direct communication.

Here are some key components of ICE:

#STUN (Session Traversal Utilities for NAT): 

A STUN server helps clients discover their public-facing IP address and port, which is needed when 
they are behind a NAT or firewall. It assists in detecting if the peer is behind a NAT and helps with 
establishing connectivity.

#TURN (Traversal Using Relays around NAT): 
A TURN server is used when a direct connection cannot be established between peers due to network 
restrictions like strict NATs or firewalls. 
In this case, the TURN server acts as a relay to route traffic between the peers.
ICE servers (STUN and TURN) work together to ensure the peers can communicate by testing various 
potential connection paths and selecting the best one.

In WebRTC, developers often configure ICE servers to make sure the communication is as efficient 
as possible, even when the devices are on different networks with possible connectivity barriers

#Ingressroutes:

Blijkbaar moet je ingressrouteTCP configureren op API traefik.io.
Kortom, geen TLS-interrupt door traefik, maar verkeer op entrypoint 443/websecure gewoon ongewijzigd doorsturen naar argo-server

#Over de workflow

Je moet een pvc aanmaken om gegevens door te geven tussen de steps.
Voor build moet je de docker directory mounten in de container met maven.
Voor deploy moet je een kubeconfig mounten de verwijst naar kubernetes op de host.

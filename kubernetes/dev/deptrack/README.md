#Installatie
kubectl apply -f deptrack.yaml

Opletten dat de API-URL klopt met VIMEXX DNS in stellingen: deptracka.alldcs.nl
Dit kun je controleren door te "pingen".
In de yaml moet de setting staan:

 - name: API_BASE_URL
   value: 'https://deptracka-dev.alldcs.nl'

#configuratie tekton:

- ga naar deptrackmenu -> configuration -> access-management -> teams
- kijk bij team "automation" en kopieer de api-key
- vul die in in de pipelinerun en in de gitea-trigger-template
- Je moet ook een project aanmaken met de juiste versie

#integratie met defectdojo

- haal de api key v2 op in defectdojo (menu rechtsboven bij symbool poppetje);
- vul die in bij deptrack bij integrations -> defectdojo
- je moet ook properties aanmaken:

Attribute	Value	 
Group Name	integrations	 
Property Name	defectdojo.engagementId	 
Property Value	The CI/CD engagement ID to upload findings to, noted in Step 3	s
Property Type	STRING


#ingressroutes

werkt met TCP-route op tls en http

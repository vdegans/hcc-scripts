FILES:
- bevragen.bat - Stuur 20 bevragingen op verschillende bsn's naar de HCC.
- clear-database.bat - Verwijder de database van de HCC uit de docker volumes.
- make_requests.bat - Stuur 100 afnemersindicaties (T/V) op verschillende bsn's van verschillende applicaties naar de HCC.
- send_worker.bat - Hulpbestand voor het versturen van berichten naar de HCC.
- start-frank.bat - Start de Frank applicatie in een Docker container.
- start-frank - STUB - Start de Frank applicatie in een Docker container, met gestubte pipes.


## Ladybug reports toevoegen.
1. Clone de Haalcentraal-connector van https://github.com/wearefrank/haalcentraal-connector
2. Clone dit project in dezelfde map als de Haalcentraal-connector.
voorbeeld mappenstructuur:
```
folder
└── haalcentraal-connector
└── hcc-scripts
```
3. Start docker.
4. Start de haalcentraal-connector met start-frank.bat
5. Run de bevragen.bat om 20 bevragingen te versturen.
6. Run de make_requests.bat om 100 afnemersindicaties te versturen.
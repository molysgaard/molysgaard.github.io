---
title: Start på QuadCopter
date: 2011-09-23
author: Morten Lysgaard
slug: start-pa-quadcopter
archived: true
---

Jeg har startet et nytt prosjekt, bygging av et quadrocopter. Dette er
en avansert fjerstyrt flyvende platform. Her er en video som forklarer
litt:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/3CR5y8qZf0Y?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

Jeg gikk for Ardupilot Mega fra DIYdrones siden denne kjører på
Arduinoplatformen som gjør at jeg kan programmere til den selv. Motorer
og motorkontrollere kommer fra HobbyKing. Jeg planlegger å bygge rammen
selv og har fått tilgang til et verksted oppe på NTNU. Her er
handlelisten:

-   [Motorkontroller](http://www.hobbyking.com/hobbyking/store/uh_viewItem.asp?idproduct=2163)
-   [Motor](http://www.hobbyking.com/hobbyking/store/uh_viewItem.asp?idproduct=5689)
-   [APM](http://store.diydrones.com/ArduPilot_Mega_kit_p/kt-apm-01.htm)

Ardupilot har 6 dof IMU med 3 akse akselerometer og 3 akse gyroskop,
med dette kan man bestemme hvilken orientering quadrotoren har til
enhver tid. I tillegg har den barometrisk trykksensor, denne forteller
relativ høyde, 5Hz GPS som gir absolutt possisjon, og magnetometer som
gir informasjon om rotasjon om vertikal akse. Med disse sensorene har
Aprdupilot ganske god kontroll over hvor den er. Jeg skal selvfølgelig
ikke bare bruke quadrotoren som et leketøy. Det jeg har mest lyst til å
gjøre er å programmere UAV rutiner for den, slik at den blir helt
selvstyrt. Målet er altså å kunne slippe kontrollen å la den kjøre
showet selv. Ardupilot har allerede endel UAV funksjoner, for eksempel
har den en egen backup-chip som er failsafe pilot. Denne kan du
programmere til å fly tilbake til et kjent sted og lande av seg selv
hvis noe skulle gå galt. Alt i alt tror jeg dette kan bli et ganske
spennende robotprosjekt, vi får se hvordan det går videre!

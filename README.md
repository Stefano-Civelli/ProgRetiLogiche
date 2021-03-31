# Final project: Digital Logic Design.

## Requirements

Lo scopo del progetto é quello di realizzare un equalizzatore di immagini in bianco e nero, ovvero un 
componente che permetta di ricalibrare il contrasto al fine di incrementarlo.
Questa operazione viene effettuata modificando i valori di intensitá dei singoli pixel (i quali assumono
un valore compreso tra 0 e 255 che indica la quantitá di bianco presente) per redistribuire in
maniera piú equa la composizione dell’istogramma.


## General specifications

L’immagine è letta sequenzialmente da memoria, dove si trova memorizzata come mostrato in figura.
Ogni pixel dell’immagine è trasformato per mezzo dell’algoritmo fornito e riscritto in memoria a
partire dalla prima cella disponibile.
Un esempio di funzionamento del componente è mostrato di seguito dove il blocco "Elaboratore"
è quello realizzato dalla entity "project_reti_logiche". Il modulo comunica alla memoria gli
indirizzi da cui vuole leggere o su cui vuole scrivere (freccia nera), legge il valore dei pixel (frecce
rosse), applica l’algoritmo e scrive in uscita i valori sulla memoria (frecce blu).
L’indirizzo x rappresenta il primo indirizzo di memoria nel quale si andrá a memorizzare l’immagine.

<img src="https://user-images.githubusercontent.com/62955439/112978638-e2e87700-9157-11eb-88cd-522777e487e6.jpg" width="400" height="400" />


## Data 
Le dimensioni dell’immagine , ciascuna di dimensione di 8 bit, sono memorizzati in una
memoria con indirizzamento al Byte partendo dalla posizione 0: il byte in posizione 0 si
riferisce al numero di colonne (N-COL), il byte in posizione 1 si riferisce al numero di righe
(N-RIG).
I pixel del’immagine , ciascuno di un 8 bit, sono memorizzati in memoria con indirizzamento
al Byte partendo dalla posizione 2.
I pixel della immagine equalizzata , ciascuno di un 8 bit, sono memorizzati in memoria con
indirizzamento al Byte partendo dalla posizione 2+(N-COL*N-RIG) .


La documentazione completa puó essere trovata nel file `RelazioneProgRetiLogiche_DEF.pdf`

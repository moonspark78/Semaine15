<?php 

/*

EXERCICE TP Tchat en ligne : 
-------------------------------

- Création d'un tchat en ligne 


-- ETAPES : 

- 01 - Création de la BDD : dialogue 
    - Table : commentaire 
    - Champs de la table commentaire : 
        - id_commentaire        INT PK AI
        - pseudo                VARCHAR
        - message               TEXT
        - date_enregistrement   DATETIME

- 02 - Créer une connexion à cette base avec PDO

- 03 - Création d'un formulaire html permettant de poster un message 
    - Champs du formulaire : 
        - pseudo (input text)
        - message (text area)
        - bouton submit

- 04 - Récupération des saisies du form avec controle (pseudo et message pas vide, pseudo pas trop court pas trop long, message pas trop court pas trop long etc)

- 05 - Déclenchement d'une requête d'enregistrement pour enregistrer les saisies dans la BDD

- 06 - Requête de récupération des messages afin de les afficher dans cette page 

- 07 - Affichage des messages avec un peu de mise en forme 

- 08 - Affichage en haut des messages du nombre de messages présents dans la BDD

- 09 - Affichage de la date formatée en français 

- 10 - Amélioration CSS

*/
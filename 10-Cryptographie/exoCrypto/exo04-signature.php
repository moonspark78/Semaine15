<?php 

/*

Contexte

Le principe de signature numérique est souvent utilisé avec des fichiers. Voici le processus :

    Création de la signature :
    On génère une signature à partir du contenu du fichier avec une clé privée.
        Stockage :
    La signature est généralement sauvegardée dans un fichier séparé ou transmise avec le fichier original.

    Vérification :
    À l'arrivée, l'utilisateur récupère le fichier original et la signature. Avec la clé publique associée, il vérifie que la signature correspond bien au contenu.

Si le contenu est modifié, la vérification échoue.
<?php

/*

    EXERCICE Chiffrement de données sensibles et hash du password :

        Etapes : 
            - Reprendre l'exercice POST Inscription Utilisateur du dossier PHP - Chapitre Post - Exercices
            - Modifier le code pour le faire correspondre à une réelle insertion en bdd (base "crypto"  table "membre"  id_membre, pseudo, email, password)
            - Bien gérer la vérification du doublon en table
            - Gérer la sécurité de l'insertion
            - Hacher le password avec password_hash et en choisissant un algorithme puissant
            - Chiffrer l'email via un chiffrement symétrique 
                - Création d'une clé (en base64) en utilisant openssl rand en command line, la stocker dans un fichier
                - Penser à décoder cette clé de base64 avant de la manipuler dans le reste du code base64_decode
                - Créer un IV aléatoire en cumulant random_bytes() puis openssl_cipher_iv_length()
                - Crypter ensuite la donnée avec openssl_encrypt() en appliquant bien l'IV
                - La retransformer en base64 avant de la stocker base64_encode
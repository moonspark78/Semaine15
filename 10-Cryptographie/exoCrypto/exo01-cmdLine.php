<?php 

/*
// Chiffrer un fichier via OpenSSL et le terminal 

// Installation de OpenSSL, via setup sur diverse distribution : 
- https://slproweb.com/products/Win32OpenSSL.html 
- https://thesecmaster.com/blog/procedure-to-install-openssl-on-the-windows-platform

// Sur Mac via homebrew 
- https://brew.sh/
- https://formulae.brew.sh/formula/openssl@3

// Sur Linux, à la mano
sudo apt update
sudo apt install openssl

// Documentation openssl : https://docs.openssl.org/master/

// Documentation openssl pour l'outil de cryptage : https://docs.openssl.org/master/man1/openssl-enc/#synopsis

// Vous allez peut être devoir définir une variable d'environnement système 
// OPENSSL_CONF 
    // chemin d'accès (pour moi)  : C:\wamp64\bin\apache\apache2.4.59\conf\openssl.cnf



// Exercice 01 - Chiffrer et déchiffrer un fichier .txt en ligne de commande 

    Etapes : 

   

        1 - Créez un fichier confidentiel.txt contenant un message.
        2 - Chiffrez avec la commande openssl enc -e   (plusieurs options sont à définir, à votre propre choix, un algorithme de cryptage, il faut aussi indiquer le fichier -in et le fichier -out)
        3 - Déchiffrer avec openssl enc -d 

*/
    openssl version
    touch confidentiel.txt
    Chiffrer le fichier : openssl enc -aes-256-cbc -e -in confidentiel.txt -out secret.enc

    enter AES-256-CBC encryption password:
    Verifying - enter AES-256-CBC encryption password:
    *** WARNING : deprecated key derivation used.
    Using -iter or -pbkdf2 would be better.

    cela a creer un fichier secret.enc
    Desktop ➜ cat secret.enc
    Salted__�?�����5&�R���,���}�


    pour le dechiffrer : openssl enc -aes-256-cbc -d -in secret.enc -out dechiffre.txt

    Lire le fichier déchiffré: cat dechiffre.txt
?>
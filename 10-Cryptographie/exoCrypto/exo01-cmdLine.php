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



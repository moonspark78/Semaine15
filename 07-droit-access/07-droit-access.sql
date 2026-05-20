--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------- DROIT D'ACCESS -------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Nos BDDs nous permettent de stocker des données 
    -- Ces BDDs vont fonctionner en liaison avec notre site web (pages html avec php ou autre) et finalement n'importe quel utilisateur peut se "connecter" à notre BDD
    -- Il est donc absolument nécessaire de veiller à ce que les utilisateurs ne possèdent pas plus de droits que nécessaire

    -- En dehors des accès que l'on peut ouvrir/fermer dans notre back/front on peut aussi appliquer des notions de sécurité dans notre BDD 

    -- Notamment en gérant des comptes utilisateurs avec des accès bien spécifiques pour leurs roles

    -- Depuis le début on utilise root, c'est le superadmin de la bdd, avec tous les droits 
        -- SURTOUT NE JAMAIS UTILISER ROOT SUR UN VRAI PROJET !!!
            -- On fera toujours en sorte de créer des comptes utilisateurs spécifiques par exemple un compte root pour les dev, un compte admin pour les gestionnaires, un compte user pour tout le reste 

    -- Pour créer un utilisateur 

    -- CREAATE USER 'nomUser'@'host' IDENTIFIED BY 'password'
    -- Création de l'utilisateur pierra avec son password
    CREATE USER "pierraa"@"localhost" IDENTIFIED BY "azerty";
    -- L'utilisateur est créé mais sans aucuns droits 

    -- Suppresion d'un utilisateur
    DROP USER "login"@"host";

    -- On donne avec root les droits à pierraa sur entreprise table employes SELECT, INSERT, DELETE, UPDATE uniquement sur le champ service 
        -- Si je voulais donner des droits sur toutes les tables j'écrirais entreprise.* ou bien sur toutes les bases toutes les tables j'écrirais *.* 
            -- Si je veux donner tous les accès j'écrirais GRANT ALL 
        GRANT SELECT, INSERT, DELETE, UPDATE(service) 
            ON entreprise.employes 
            TO "pierraa"@"localhost";

    -- Pour activer les droits on utilise FLUSH PRIVILEGES (sinon ils ne sont pas forcément pris en compte immédiatement)
    FLUSH PRIVILEGES;

    -- Limitation de ressources 
        -- MAX_QUERIES_PER_HOUR : Le nombre de requêtes qu'on peut exécuter par heure 
        -- MAX_UPDATES_PER_HOUR : Le nombre de modif qu'il peut exécuter par heure 
        -- MAX_CONNECTIONS_PER_HOUR : Le nombre de fois qu'il peut se connecter à notre serveur 

    -- Important de mettre ça en place pour se protéger des attaques force brute/ddos qui envoie des millions de requête en quelques secondes :) 
    -- On veillera à mettre une limitation suffisamment élevé pour ne pas géner le flux de visite normal :) 

    CREATE USER "pierroo"@"localhost" IDENTIFIED BY "azerty"
    WITH MAX_QUERIES_PER_HOUR 5
    MAX_UPDATES_PER_HOUR 5
    MAX_CONNECTIONS_PER_HOUR 3;


-- EXERCICE : 

USE entreprise; 

-- Créer les comptes utilisateur suivants : 
        -- secretaire : avec le password de votre choix, on lui attribue le privilège de lecture sur les champs suivants id_employes, nom, prenom, sexe, service sur la table employes
        USE entreprise;

        🔹Créer l’utilisateur:
        CREATE USER "secretaire"@"localhost"
        IDENTIFIED BY "secret123";

        🔹Donner les droits
        GRANT SELECT (id_employes, nom, prenom, sexe, service)
        ON entreprise.employes
        TO "secretaire"@"localhost";

        🔹 Activer les droits
        FLUSH PRIVILEGES;



        -- directeur : avec le password de votre choix, on lui attribue les privilèges suivants : selection, modification, insertion, suppression sur la bdd entreprise en plus des droits d'attribution de droits à d'autres utilisateurs 
        🔹 Créer utilisateur
        CREATE USER "directeur"@"localhost"
        IDENTIFIED BY "directeur123";

        🔹 Donner les droits
        GRANT SELECT, INSERT, UPDATE, DELETE
        ON entreprise.*
        TO "directeur"@"localhost"
        WITH GRANT OPTION;

        🔹 Activer
        FLUSH PRIVILEGES;



        -- informaticien : mot de passe au choix, donnez lui tous les droits mais une limitation de ressources à 10 requêtes maximum par heure et un nombre de connexion de 6 maximum par heure 
        🔹 Créer utilisateur + limites
        CREATE USER "informaticien"@"localhost"
        IDENTIFIED BY "info123"

        WITH
        MAX_QUERIES_PER_HOUR 10
        MAX_CONNECTIONS_PER_HOUR 6;

        🔹 Donner tous les droits
        GRANT ALL
        ON entreprise.*
        TO "informaticien"@"localhost";

        🔹 Activer
        FLUSH PRIVILEGES;


-- Déconnectez vous du compte root, et connectez vous en tant que secrétaire et répondre aux requêtes suivantes : 
🔹 Quitter root
exit
🔹 Connexion secrétaire
mysql -u secretaire -p
🔹 Mot de passe
secret123
            -- 1 -- Afficher la profession de l'employé 417
            SELECT profession
            FROM employes
            WHERE id_employes = 417;
Erreur : 🔹 1. La secrétaire a des droits LIMITÉS
On lui a donné :
SELECT (id_employes, nom, prenom, sexe, service)
👉 MAIS PAS :
❌ profession
❌ salaire
❌ date_embauche


            -- 2 -- Afficher le nombre de commerciaux 
            -- 3 -- Afficher le nombre de services différents 
            -- 4 -- Augmenter le salaire de chaque employés de 100 euros 

-- Déconnectez vous du compte secrétaire et connectez vous en tant que directeur et répondre aux requêtes suivantes :
            -- 1 -- Afficher la date d'embauche de Amandine 
            -- 2 -- Afficher le salaire moyen par service 
            -- 3 -- Afficher les informations de l'employé du service commercial gagnant le salaire le plus élevé 

-- Déconnectez vous de directeur, connectez vous comme informaticien
            -- 1 -- Lancez plusieurs requêtes pour tester le maximum de requêtes autorisées
            -- 2 -- Reconnectez vous plusieurs fois pour tester le nombre de connexion autorisées 
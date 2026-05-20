--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------- TRANSACTIONS ---------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------


-- Les transactions en MySQL sont possibles uniquement avec le motteur InnoDB 
-- Les transactions permettent de créer un espace tampon/de stagging pour le lancement de nos requêtes
-- C'est à dire que, lorsque j'ouvre une transaction, une requête n'est réellement validée sur la base que lorsque je "commit" la transaction
-- D'ailleurs, on pourra aussi annuler toutes les requêtes exécutées dans une transaction avec un "rollback"

-- On s'en sert souvent dans le web lorsqu'une opération est composée de plusieurs requêtes qui sont liées. En lançant une transaction on s'assure de bien valider les deux, et que s'il y a un problème, d'annuler les deux ! (deux ou plus)

-- On les utilise généralement au travers de notre langage back (via PDO en PHP) mais c'est un outil existant déjà dans MySQL que je peux manipuler avec ma console 

USE entreprise;

START TRANSACTION; -- Démarre une transaction

SELECT * FROM employes; -- On vérifie nos données, tout est ok 

UPDATE employes SET salaire = +100; -- Je me trompe dans ma requête... Je mets tout le monde à 100 en salaire... :( 

SELECT * FROM employes; -- On vérifie nos données, tout est mauvais !

-- Heureusement je suis dans une transaction !!!
-- A partir de là je peux soit COMMIT pour valider tout
-- soit ROLLBACK pour annuler tout 

ROLLBACK; -- ROLLBACK me permet de tout annuler depuis le début de la transaction ATTENTION cela cloture la transaction en cours
COMMIT; -- COMMIT me permet de tout valider depuis le début de la transaction ATTENTION cela cloture la transaction en cours 

-- En langage back on utilisera les transactions avec des try/catch 
try {
    -- begin transaction
    -- test de code
    -- envoi de requete
    -- si tout est ok je commit
    -- commit : transaction réussie
} catch() {
    -- je tombe là s'il y a eu un probleme dans le try, donc un probleme avec mes requetes
    -- dans ce cas, je rollback!
    -- rollback : je préfère annuler car problème dans les requêtes de ma transaction
}

-- TRANSACTION AVANCEE & SAVEPOINT 

START TRANSACTION;

SELECT * FROM employes; -- Nos données d'origine 

SAVEPOINT point1; -- On crée un point de save nommé "point1"

UPDATE employes SET salaire = 1000;

SELECT * FROM employes; -- Tout le monde à 1000

SAVEPOINT point2; -- On crée un point de save nommé "point2"

UPDATE employes SET salaire = 2000;

SELECT * FROM employes; -- Tout le monde à 2000

SAVEPOINT point3; -- On crée un point de save nommé "point3"

ROLLBACK TO point2; -- Retour au point2
SELECT * FROM employes; -- Tout le monde retour à 1000

ROLLBACK TO point3; -- Pas possible, la creation du point3 a été ROLLBACK lorsque je suis revenu au point2

-- Pour des ROLLBACK TO savepoint spécifique, je reste toujours dans la transaction, en attente d'un COMMIT ou ROLLBACK total 

COMMIT; -- ferme la transaction
ROLLBACK; -- ferme la transaction 


-- ATTENTION, à l'intérieur d'une transaction, on peut tester uniquement des requêtes crud des 4 types (select, insert, update, delete) mais certaines autres instructions (les requêtes structure) passeront outre la transaction et seront bien appliquées (TRUNCATE, DROP ou autre)

START TRANSACTION; -- J'ouvre une transaction
DELETE FROM employes; -- Je supprime tout le contenu de la table au travers d'une requête action classique DELETE
SELECT * FROM employes; -- La table est vide
ROLLBACK; -- Je rollback

SELECT * FROM employes; -- La suppression a été annulée, je récupère tous mes employes ! 

START TRANSACTION; -- J'ouvre une transaction
TRUNCATE employes; -- Je supprime tout le contenu de la table au travers de TRUNCATE, c'est une requête de structure
SELECT * FROM employes; -- La table est vide
ROLLBACK; -- Je rollback


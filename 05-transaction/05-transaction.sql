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
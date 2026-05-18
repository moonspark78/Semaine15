CREATE DATABASE une_bdd;
CREATE DATABASE entreprise;

SHOW DATABASES;
SHOW TABLES;

USE une_bdd; -- Permet de sélectionner la base de données sur laquelle on va travailler
SELECT DATABASE(); -- Affiche la base de données actuellement utilisée
USE entreprise;

DROP DATABASE une_bdd; -- Supprime la base de données une_bdd
DROP DATABASE entreprise; -- Supprime la base de données entreprise

DROP TABLE -- Supprime une table
CREATE TABLE -- Crée une table
ALTER TABLE -- Modifie la structure d'une table
INSERT INTO -- Insère des données dans une table

DROP TABLE IF EXISTS nom_de_la_table; -- Supprime la table si elle existe
TROUNCATE TABLE nom_de_la_table; -- Supprime toutes les données d'une table sans supprimer la structure

DESC nom_de_la_table; -- Affiche la structure d'une table
DESCRIBE nom_de_la_table; -- Affiche la structure d'une table (synonyme

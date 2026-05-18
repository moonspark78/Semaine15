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

USE une_bdd; -- Pour se positionner avec la console sur une BDD pour intéragir dessus
SELECT DATABASE(); -- Pour vérifier quelle est la base sur laquelle on se trouve 
USE entreprise;

DROP DATABASE une_bdd; -- Pour supprimer une BDD 
DROP TABLE nom_de_la_table; -- Pour supprimer une table 

TRUNCATE nom_de_table; -- Pour vider la table (attention, c'est une requête de structure)
DELETE FROM nom_de_table; -- Pour vider la table (requête crud classique)

DESC nom_de_table; -- Pour avoir une description de la structure de la table 

-- Création d'une table employes dans la base entreprise
CREATE TABLE IF NOT EXISTS employes (
  id_employes int(3) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

-- Insertions dans la table employes 
INSERT INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES
(350, 'Jean-pierre', 'Laborde', 'm', 'direction', '2010-12-09', 5000),
(388, 'Clement', 'Gallet', 'm', 'commercial', '2010-12-15', 2300),
(415, 'Thomas', 'Winter', 'm', 'commercial', '2011-05-03', 3550),
(417, 'Chloe', 'Dubar', 'f', 'production', '2011-09-05', 1900),
(491, 'Elodie', 'Fellier', 'f', 'secretariat', '2011-11-22', 1600),
(509, 'Fabrice', 'Grand', 'm', 'comptabilite', '2011-12-30', 2900),
(547, 'Melanie', 'Collier', 'f', 'commercial', '2012-01-08', 3100),
(592, 'Laura', 'Blanchet', 'f', 'direction', '2012-05-09', 4500),
(627, 'Guillaume', 'Miller', 'm', 'commercial', '2012-07-02', 1900),
(655, 'Celine', 'Perrin', 'f', 'commercial', '2012-09-10', 2700),
(699, 'Julien', 'Cottet', 'm', 'secretariat', '2013-01-05', 1390),
(701, 'Mathieu', 'Vignal', 'm', 'informatique', '2013-04-03', 2500),
(739, 'Thierry', 'Desprez', 'm', 'secretariat', '2013-07-17', 1500),
(780, 'Amandine', 'Thoyer', 'f', 'communication', '2014-01-23', 2100),
(802, 'Damien', 'Durand', 'm', 'informatique', '2014-07-05', 2250),
(854, 'Daniel', 'Chevel', 'm', 'informatique', '2015-09-28', 3100),
(876, 'Nathalie', 'Martin', 'f', 'juridique', '2016-01-12', 3550),
(900, 'Benoit', 'Lagarde', 'm', 'production', '2016-06-03', 2550),
(933, 'Emilie', 'Sennard', 'f', 'commercial', '2017-01-11', 1800),
(990, 'Stephanie', 'Lafaye', 'f', 'assistant', '2017-03-01', 1775);

SELECT * FROM employes WHERE service = "informatique";

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------- REQUETES DE SELECTION -----------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Affichage complet des données d'une table 
SELECT * FROM employes;

-- Affichage d'uniquement certains champs 
SELECT nom, prenom, service FROM employes;

-- Exercice : Affichez la liste des différents services de la table employes 
SELECT service FROM employes;
-- Pour éviter les doublons et avoir une liste des différents services je rajoute DISTINCT
SELECT DISTINCT service FROM employes;
+---------------+
| service       |
+---------------+
| direction     |
| commercial    |
| production    |
| secretariat   |
| comptabilite  |
| informatique  |
| communication |
| juridique     |
| assistant     |
+---------------+

-- CONDITION WHERE
-- Affichage des employes du service informatique 
SELECT * FROM employes WHERE service = "informatique";
+-------------+---------+--------+------+--------------+---------------+---------+
| id_employes | prenom  | nom    | sexe | service      | date_embauche | salaire |
+-------------+---------+--------+------+--------------+---------------+---------+
|         701 | Mathieu | Vignal | m    | informatique | 2013-04-03    |    2500 |
|         802 | Damien  | Durand | m    | informatique | 2014-07-05    |    2250 |
|         854 | Daniel  | Chevel | m    | informatique | 2015-09-28    |    3100 |
+-------------+---------+--------+------+--------------+---------------+---------+

-- BETWEEN
-- Affichage des employés ayant été embauché entre 2015 et aujourd'hui
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND "2026-05-18";
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND NOW(); -- Fonction NOW() retourne la date et l'heure de maintenant
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND CURDATE(); -- CURDATE() retour la date d'aujourd'hui

+-------------+-----------+---------+------+--------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service      | date_embauche | salaire |
+-------------+-----------+---------+------+--------------+---------------+---------+
|         854 | Daniel    | Chevel  | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie  | Martin  | f    | juridique    | 2016-01-12    |    3550 |
|         900 | Benoit    | Lagarde | m    | production   | 2016-06-03    |    2550 |
|         933 | Emilie    | Sennard | f    | commercial   | 2017-01-11    |    1800 |
|         990 | Stephanie | Lafaye  | f    | assistant    | 2017-03-01    |    1775 |
+-------------+-----------+---------+------+--------------+---------------+---------+

-- LIKE la valeur approchante 
-- Like nous permet de lancer des recherches sur une information pas saisie complètement 
-- Affichage des prénoms commençant par la lettre "s" 

-- % signifiant peu importe ce qui est ici
SELECT prenom FROM employes WHERE prenom LIKE "s%";
+-----------+
| prenom    |
+-----------+
| Stephanie |
+-----------+

-- Affichage des prénoms finissant par "ie"
SELECT prenom FROM employes WHERE prenom LIKE "%ie";
+-----------+
| prenom    |
+-----------+
| Elodie    |
| Melanie   |
| Nathalie  |
| Emilie    |
| Stephanie |
+-----------+

-- Affichage des prénoms contenant "ie"
SELECT prenom FROM employes WHERE prenom LIKE "%ie%";
+-------------+
| prenom      |
+-------------+
| Jean-pierre |
| Elodie      |
| Melanie     |
| Julien      |
| Mathieu     |
| Thierry     |
| Damien      |
| Daniel      |
| Nathalie    |
| Emilie      |
| Stephanie   |
+-------------+


-- EXCLUSION 
-- Tous les employés sauf ceux d'un service particulier, par exemple sauf commercial
SELECT * FROM employes WHERE service != "commercial"; -- différent de commercial
+-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction     | 2010-12-09    |    5000 |
|         417 | Chloe       | Dubar    | f    | production    | 2011-09-05    |    1900 |
|         491 | Elodie      | Fellier  | f    | secretariat   | 2011-11-22    |    1600 |
|         509 | Fabrice     | Grand    | m    | comptabilite  | 2011-12-30    |    2900 |
|         592 | Laura       | Blanchet | f    | direction     | 2012-05-09    |    4500 |
|         699 | Julien      | Cottet   | m    | secretariat   | 2013-01-05    |    1390 |
|         701 | Mathieu     | Vignal   | m    | informatique  | 2013-04-03    |    2500 |
|         739 | Thierry     | Desprez  | m    | secretariat   | 2013-07-17    |    1500 |
|         780 | Amandine    | Thoyer   | f    | communication | 2014-01-23    |    2100 |
|         802 | Damien      | Durand   | m    | informatique  | 2014-07-05    |    2250 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique     | 2016-01-12    |    3550 |
|         900 | Benoit      | Lagarde  | m    | production    | 2016-06-03    |    2550 |
|         990 | Stephanie   | Lafaye   | f    | assistant     | 2017-03-01    |    1775 |
+-------------+-------------+----------+------+---------------+---------------+---------+

-- Les opérateurs de comparaison : 
-- =   est égal à 
-- !=  est différent de 
-- <   strictement inférieur
-- <=  inférieur ou égal
-- >   supérieur
-- >=  supérieur ou égal 

-- Les employés ayant un salaire supérieur à 3000
SELECT nom, prenom, service, salaire FROM employes WHERE salaire > 3000;
+----------+-------------+--------------+---------+
| nom      | prenom      | service      | salaire |
+----------+-------------+--------------+---------+
| Laborde  | Jean-pierre | direction    |    5000 |
| Winter   | Thomas      | commercial   |    3550 |
| Collier  | Melanie     | commercial   |    3100 |
| Blanchet | Laura       | direction    |    4500 |
| Chevel   | Daniel      | informatique |    3100 |
| Martin   | Nathalie    | juridique    |    3550 |
+----------+-------------+--------------+---------+

-- ORDER BY pour ordonner les résultats 
-- Affichage des employes dans l'ordre alphabétique 
SELECT * FROM employes ORDER BY nom;
SELECT * FROM employes ORDER BY nom ASC; -- ASC pour ascendant (cas par défaut)
SELECT * FROM employes ORDER BY nom DESC; -- DESC pour descendant (alphabétique inversé)

-- Il est possible d'ordonner par plusieurs champs. Si le premier forme "un bloc" / a des valeurs similaires, on peut classer par un autre champ ensuite
-- Classer par service puis par nom 
SELECT service, nom, prenom FROM employes ORDER BY service, nom;
+---------------+----------+-------------+
| service       | nom      | prenom      |
+---------------+----------+-------------+
| assistant     | Lafaye   | Stephanie   |
| commercial    | Collier  | Melanie     |
| commercial    | Gallet   | Clement     |
| commercial    | Miller   | Guillaume   |
| commercial    | Perrin   | Celine      |
| commercial    | Sennard  | Emilie      |
| commercial    | Winter   | Thomas      |
| communication | Thoyer   | Amandine    |
| comptabilite  | Grand    | Fabrice     |
| direction     | Blanchet | Laura       |
| direction     | Laborde  | Jean-pierre |
| informatique  | Chevel   | Daniel      |
| informatique  | Durand   | Damien      |
| informatique  | Vignal   | Mathieu     |
| juridique     | Martin   | Nathalie    |
| production    | Dubar    | Chloe       |
| production    | Lagarde  | Benoit      |
| secretariat   | Cottet   | Julien      |
| secretariat   | Desprez  | Thierry     |
| secretariat   | Fellier  | Elodie      |
+---------------+----------+-------------+



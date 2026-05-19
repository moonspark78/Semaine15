
CREATE DATABASE bibliotheque;
USE bibliotheque;

CREATE TABLE abonne (
  id_abonne INT(3) NOT NULL AUTO_INCREMENT,
  prenom VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_abonne)
) ENGINE=InnoDB ;

INSERT INTO abonne (id_abonne, prenom) VALUES
(1, 'Guillaume'),
(2, 'Benoit'),
(3, 'Chloe'),
(4, 'Laura');


CREATE TABLE livre (
  id_livre INT(3) NOT NULL AUTO_INCREMENT,
  auteur VARCHAR(25) NOT NULL,
  titre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_livre)
) ENGINE=InnoDB ;

INSERT INTO livre (id_livre, auteur, titre) VALUES
(100, 'GUY DE MAUPASSANT', 'Une vie'),
(101, 'GUY DE MAUPASSANT', 'Bel-Ami '),
(102, 'HONORE DE BALZAC', 'Le pere Goriot'),
(103, 'ALPHONSE DAUDET', 'Le Petit chose'),
(104, 'ALEXANDRE DUMAS', 'La Reine Margot'),
(105, 'ALEXANDRE DUMAS', 'Les Trois Mousquetaires');

CREATE TABLE emprunt (
  id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
  id_livre INT(3) DEFAULT NULL,
  id_abonne INT(3) DEFAULT NULL,
  date_sortie DATE NOT NULL,
  date_rendu DATE DEFAULT NULL,
  PRIMARY KEY  (id_emprunt)
) ENGINE=InnoDB ;

INSERT INTO emprunt (id_emprunt, id_livre, id_abonne, date_sortie, date_rendu) VALUES
(1, 100, 1, '2016-12-07', '2016-12-11'),
(2, 101, 2, '2016-12-07', '2016-12-18'),
(3, 100, 3, '2016-12-11', '2016-12-19'),
(4, 103, 4, '2016-12-12', '2016-12-22'),
(5, 104, 1, '2016-12-15', '2016-12-30'),
(6, 105, 2, '2017-01-02', '2017-01-15'),
(7, 105, 3, '2017-02-15', NULL),
(8, 100, 2, '2017-02-20', NULL);

-- Quels sont les id_livre des livres qui n'ont pas été rendu à la bibliotheque ? 
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;
-- ATTENTION la valeur NULL se test avec IS NULL ou IS NOT NULL
+----------+
| id_livre |
+----------+
|      105 |
|      100 |
+----------+

-- Pour avoir les titres des livres... Cette information se trouvant sur une autre table...
-- 2 possibilités ! 
-- Requêtes imbriquées (pas le choix préféré)
-- Requêtes en jointure (le choix préféré !)

--------------------------------------------------------------------------
--------------------------------------------------------------------------
---------- REQUETES IMBRIQUEES -------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Quels sont les titres des livres qui n'ont pas été rendu à la bibliothèque ? 
SELECT titre FROM livre WHERE id_livre IN (100, 105); -- Ici je mets en brut, les id que j'ai trouvé à la requête précédente
+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+

-- En fait, une requête imbriquée c'est le fait de pouvoir mettre une requête à l'intérieur d'une autre !
-- On a besoin du résultat de la "sous requete" pour mener à bien la première requête
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL); 
+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+

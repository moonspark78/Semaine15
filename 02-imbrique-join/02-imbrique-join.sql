
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

-- Une requête imbriquée m'enverra très régulièrement plusieurs résultats on utilisera toujours IN et non pas = 

-- EXERCICE 1: Quels sont les prénoms des abonnés n'ayant pas rendu un livre à la bibliotheque.
SELECT prenom
FROM abonne
WHERE id_abonne IN (
  SELECT id_abonne
  FROM emprunt
  WHERE date_rendu IS NULL
);
-- EXERCICE 2 : Nous aimerions connaitre le(s) n° des livres empruntés par Chloé
SELECT id_livre
FROM emprunt
WHERE id_abonne = (
  SELECT id_abonne
  FROM abonne
  WHERE prenom = 'Chloe'
);
-- EXERCICE 3: Affichez les prénoms des abonnés ayant emprunté un livre le 07/12/2016.
SELECT prenom
FROM abonne
WHERE id_abonne IN (
  SELECT id_abonne
  FROM emprunt
  WHERE date_sortie = '2016-12-07'
);
-- EXERCICE 4: combien de livre Guillaume a emprunté à la bibliotheque ?
SELECT COUNT(*) AS total_emprunts
FROM emprunt
WHERE id_abonne = (
  SELECT id_abonne
  FROM abonne
  WHERE prenom = 'Guillaume'
);
-- EXERCICE 5: Affichez la liste des abonnés ayant déjà emprunté un livre d'Alphonse Daudet
SELECT prenom
FROM abonne
WHERE id_abonne IN (
  SELECT id_abonne
  FROM emprunt
  WHERE id_livre IN (
    SELECT id_livre
    FROM livre
    WHERE auteur = 'ALPHONSE DAUDET'
  )
);
-- EXERCICE 6: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque.
SELECT titre
FROM livre
WHERE id_livre IN (
  SELECT id_livre
  FROM emprunt
  WHERE id_abonne = (
    SELECT id_abonne
    FROM abonne
    WHERE prenom = 'Chloe'
  )
);
-- EXERCICE 7: Nous aimerions connaitre les titres des livres que Chloe n'a pas emprunté à la bibliotheque.
SELECT titre
FROM livre
WHERE id_livre NOT IN (
  SELECT id_livre
  FROM emprunt
  WHERE id_abonne = (
    SELECT id_abonne
    FROM abonne
    WHERE prenom = 'Chloe'
  )
);
-- EXERCICE 8: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque ET qui n'ont pas été rendu.
SELECT titre
FROM livre
WHERE id_livre IN (
  SELECT id_livre
  FROM emprunt
  WHERE id_abonne = (
    SELECT id_abonne
    FROM abonne
    WHERE prenom = 'Chloe'
  )
  AND date_rendu IS NULL
);
-- EXERCICE 9 :  Qui a emprunté le plus de livre à la bibliotheque ?
SELECT a.prenom, COUNT(e.id_emprunt) AS total
FROM abonne a
JOIN emprunt e ON a.id_abonne = e.id_abonne
GROUP BY a.id_abonne
ORDER BY total DESC
LIMIT 1;
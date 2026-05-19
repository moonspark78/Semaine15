
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

--------------------------------------------------------------------------
--------------------------------------------------------------------------
---------- REQUETES EN JOINTURE ------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- Une jointure est toujours possible, même lorsqu'on souhaite afficher des champs de plusieurs tables différentes
-- Une imbriquée ne peut afficher que des informations d'une seule table 

-- Avec une imbriquée on parcourt les tables les unes après les autres en passant par le champ commun PK/FK, mais réellement on utilise rarement les imbriquées dans ces situations
-- On préfèrera les jointures car on peut mélanger les champs de sorties, les appels de tables, les conditions sans que cela pose problème 

-- Nous aimerions connaître les dates de sortie et les dates de rendu pour l'abonné Guillaume 
    -- En imbriquée pas possible ! Les infos des dates de rendu sont sur la table emprunt et l'info "Guillaume" vient de la table abonne 

-- En jointure c'est ok ! 

-- Première syntaxe, pas très conventionnelle mais pratique ! 
SELECT prenom, date_sortie, date_rendu          -- Ce que je veux afficher, de plusieurs tables différentes pas de soucis
FROM emprunt, abonne                            -- Toutes les tables dont j'ai besoin pour cette requête 
WHERE prenom = "Guillaume"                      -- Mes conditions (ici une seule)
AND abonne.id_abonne = emprunt.id_abonne;       -- La jointure ! C'est une condition qui indique quel champ correspond à quel autre sur l'autre table 

-- Lors d'une jointure il est toujours de spécifier les préfixes de tables pour tous les champs appelés
SELECT abonne.prenom, emprunt.date_sortie, emprunt.date_rendu          
FROM emprunt, abonne                            
WHERE abonne.prenom = "Guillaume"                     
AND abonne.id_abonne = emprunt.id_abonne;       

-- Les prefixes pouvant parfois alourdir nos requêtes, on peut donner des alias à nos tables 
SELECT a.prenom, e.date_sortie, e.date_rendu          
FROM emprunt e, abonne a                          -- Ici ma table emprunt s'appelle maintenant e et abonne a 
WHERE a.prenom = "Guillaume"                     
AND a.id_abonne = e.id_abonne;   

-- Autre syntaxe, plus conventionnelle 
-- En utilisant INNER JOIN ou simplement JOIN 
-- Avec cette méthode on joint les tables une par une 
SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
INNER JOIN abonne a ON e.id_abonne = a.id_abonne 
WHERE a.prenom = "Guillaume";

SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
INNER JOIN abonne a USING (id_abonne) -- On peut utiliser USING si par chance notre PK a exactement le meme nom que la FK (c'est assez rare en général)
WHERE a.prenom = "Guillaume";

-- S'il fallait utiliser une seule syntaxe, on préférera celle ci-dessous, avec JOIN tout court et le ON pour faire la jointure
SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
JOIN abonne a ON e.id_abonne = a.id_abonne 
WHERE a.prenom = "Guillaume";

-- EXERCICE 1 : Nous aimerions connaitre les dates de sortie et les dates de rendu pour les livres écrit par Alphonse Daudet 
-- EXERCICE 2 : Qui a emprunté le livre "une vie" sur l'année 2016 
-- EXERCICE 3 : Nous aimerions connaitre le nombre de livre emprunté par chaque abonné 
-- EXERCICE 4 : Nous aimerions connaitre le nombre de livre emprunté à rendre par chaque abonné 
-- EXERCICE 5 : Qui (prenom) a emprunté Quoi (titre) et Quand (date_sortie) ?
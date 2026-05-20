--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------- RELATIONS & CONTRAINTES D'INTEGRITE ----------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Lorsque l'on a une relation entre nos tables, pour faire des jointures ou autre (on définit ça pendant la modélisation), on a besoin de créer des clés étrangères
-- Pour valider la relation, en plus de catégoriser le champ prévu pour être une FK dans notre table, on va devoir rajouter une contrainte de clé étrangère 
-- Une contrainte de clé étrangère nous permet de maintenir l'intégrité des données en empêchant par exemple l'ajout de données fantomes dans nos tables (des données qui ne correspondent pas à de vrais éléments)
-- Par exemple dans la base bibliothèque, je ne peux pas insérer un emprunt avec un id_abonne qui n'existe pas et idem pour un livre qui n'existe pas 

-- On peut régler différents mode sur nos contraintes 

-- Les MODES de fonctionnement des contraintes 

    -- RESTRICT : Tant qu'un emprunt est rattaché à un abonné, on ne peut pas supprimer l'abonné ! Ici on fait bien la différence entre un enregistrement parent (abonné) et un enfant (emprunt)  parent > enfant   on considère un parent étant un élément qui "possède" d'autres données 
    -- SET NULL : Inscrira NULL dans le champs de la FK si on supprime l'abonné (il faut que le champ en question soit autorisé à être NULL)
    -- CASCADE : (=repercussion) Si on supprime l'abonné alors tous ses emprunts seront également supprimés ! ATTENTION AVEC CE MODE ! ATTENTION A NE PAS AVOIR D'ACTION AVEC REPLACE sinon la cascade va se déclencher !  

-- Pour ajouter un index et contraintes via PHPMyAdmin, se rendre sur la base, puis la table, puis l'onglet structure 
    -- Sur chaque ligne on a le bouton "Plus" qui nous permet de définir le champ comme étant un "index" (un index = un champ optimisé sur les requêtes de lecture)
        -- Après avoir définir le champ comme étant un index, on clique sur le bouton "Vue relationnelle" au dessus de la liste des champs pour ensuite définir quel index correspond à quel champ d'une autre table et ainsi pour définir ses modes de contraintes ON DELETE et ON UPDATE 

CREATE DATABASE taxi;

USE TAXI;

CREATE TABLE IF NOT EXISTS `association_vehicule_conducteur` (
  `id_association` int(3) NOT NULL AUTO_INCREMENT,
  `id_vehicule` int(3) DEFAULT NULL,
  `id_conducteur` int(3) DEFAULT NULL,
  PRIMARY KEY (`id_association`)
  
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


INSERT INTO `association_vehicule_conducteur` (`id_association`, `id_vehicule`, `id_conducteur`) VALUES
(1, 501, 1),
(2, 502, 2),
(3, 503, 3),
(4, 504, 4),
(5, 501, 3);


CREATE TABLE IF NOT EXISTS `conducteur` (
  `id_conducteur` int(3) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(30) NOT NULL,
  `nom` varchar(30) NOT NULL,
  PRIMARY KEY (`id_conducteur`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


INSERT INTO `conducteur` (`id_conducteur`, `prenom`, `nom`) VALUES
(1, 'Julien', 'Avigny'),
(2, 'Morgane', 'Alamia'),
(3, 'Philippe', 'Pandre'),
(4, 'Amelie', 'Blondelle'),
(5, 'Alex', 'Richy');


DROP TABLE IF EXISTS `vehicule`;
CREATE TABLE IF NOT EXISTS `vehicule` (
  `id_vehicule` int(3) NOT NULL AUTO_INCREMENT,
  `marque` varchar(30) NOT NULL,
  `modele` varchar(30) NOT NULL,
  `couleur` varchar(30) NOT NULL,
  `immatriculation` varchar(9) NOT NULL,
  PRIMARY KEY (`id_vehicule`)
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=latin1;

INSERT INTO `vehicule` (`id_vehicule`, `marque`, `modele`, `couleur`, `immatriculation`) VALUES
(501, 'Peugeot', '807', 'noir', 'AB-355-CA'),
(502, 'Citroen', 'C8', 'bleu', 'CE-122-AE'),
(503, 'Mercedes', 'Cls', 'vert', 'FG-953-HI'),
(504, 'Volkswagen', 'Touran', 'noir', 'SO-322-NV'),
(505, 'Skoda', 'Octavia', 'gris', 'PB-631-TK'),
(506, 'Volkswagen', 'Passat', 'gris', 'XN-973-MM');

  -- EXERCICES Contraintes - Foreign Key 


    -- Créer la base taxi et ses tables et insérer les données 
    
    -- 1 - Créer les clés étrangères et les relations pour empêcher l'insertion de fausses valeurs 

    -- 2 - Définir les modes de contraintes en fonction des souhaits de notre client ci-dessous :
        -- 1 - La société de taxis peut modifier leurs conducteurs via leur logiciel, lorsqu'un conducteur est modifié, la société aimerait que la modification soit répercutée dans la table d'association   
        -- 2 - La société de taxis peut supprimer des conducteurs via leur logiciel, ils aimeraient bloquer la possibilité de supprimer un conducteur tant que celui-ci conduit un véhicule.
        -- 3 - La société de taxis peut modifier un véhicule via leur logiciel. Lorsqu'un véhicule est modifié, on veut que la modification soit répercutée dans la table d'association
        -- 4 - Si un véhicule est supprimé alors qu'un ou plusieurs conducteurs le conduisaient, la société aimerait garder la trace de l'association dans la table d'association malgré tout.

-- EXERCICES Requetes

-- 01 - Qui conduit la voiture 503 ? 
SELECT c.prenom, c.nom
FROM conducteur c
JOIN association_vehicule_conducteur a ON c.id_conducteur = a.id_conducteur
WHERE a.id_vehicule = 503;

+----------+--------+
| prenom   | nom    |
+----------+--------+
| Philippe | Pandre |
+----------+--------+
1 row in set (0,00 sec)


-- 02 - Quelle(s) voiture(s) est conduite par le conducteur 3 ? 
SELECT v.marque, v.modele, v.immatriculation
FROM vehicule v
JOIN association_vehicule_conducteur a ON v.id_vehicule = a.id_vehicule
WHERE a.id_conducteur = 3;

+----------+--------+-----------------+
| marque   | modele | immatriculation |
+----------+--------+-----------------+
| Mercedes | Cls    | FG-953-HI       |
| Peugeot  | 807    | AB-355-CA       |
+----------+--------+-----------------+
2 rows in set (0,00 sec)


-- 03 - Qui conduit quoi ? (on veut les prenoms associés à un modele + marque)
SELECT c.prenom, c.nom, v.marque, v.modele
    FROM conducteur c
    JOIN association_vehicule_conducteur a ON c.id_conducteur = a.id_conducteur
    JOIN vehicule v ON a.id_vehicule = v.id_vehicule;
+----------+-----------+------------+--------+
| prenom   | nom       | marque     | modele |
+----------+-----------+------------+--------+
| Julien   | Avigny    | Peugeot    | 807    |
| Morgane  | Alamia    | Citroen    | C8     |
| Philippe | Pandre    | Mercedes   | Cls    |
| Amelie   | Blondelle | Volkswagen | Touran |
| Philippe | Pandre    | Peugeot    | 807    |
+----------+-----------+------------+--------+
5 rows in set (0,01 sec)


-- 04 - Ajoutez vous dans la liste des conducteurs.
INSERT INTO conducteur (prenom, nom) VALUES ('TonPrenom', 'TonNom');

        -- Afficher tous les conducteurs (meme ceux qui n'ont pas de correspondance avec les vehicules) puis les vehicules qu'ils conduisent si c'est le cas
        SELECT c.prenom, c.nom, v.marque, v.modele
        FROM conducteur c
        LEFT JOIN association_vehicule_conducteur a ON c.id_conducteur = a.id_conducteur
        LEFT JOIN vehicule v ON a.id_vehicule = v.id_vehicule;

        +-----------+-----------+------------+--------+
        | prenom    | nom       | marque     | modele |
        +-----------+-----------+------------+--------+
        | Julien    | Avigny    | Peugeot    | 807    |
        | Morgane   | Alamia    | Citroen    | C8     |
        | Philippe  | Pandre    | Peugeot    | 807    |
        | Philippe  | Pandre    | Mercedes   | Cls    |
        | Amelie    | Blondelle | Volkswagen | Touran |
        | Alex      | Richy     | NULL       | NULL   |
        | TonPrenom | TonNom    | NULL       | NULL   |
        +-----------+-----------+------------+--------+
        7 rows in set (0,00 sec)



-- 05 - Ajoutez un nouvel enregistrement dans la table des véhicules.
INSERT INTO vehicule (marque, modele, couleur, immatriculation) 
VALUES ('Renault', 'Espace', 'blanc', 'AA-123-BB');
        -- Afficher tous les véhicules (meme ceux qui n'ont pas de correspondance avec les conducteurs) puis les conducteurs si c'est le cas
        SELECT v.marque, v.modele, v.immatriculation, c.prenom, c.nom
        FROM vehicule v
        LEFT JOIN association_vehicule_conducteur a ON v.id_vehicule = a.id_vehicule
        LEFT JOIN conducteur c ON a.id_conducteur = c.id_conducteur;

        +------------+---------+-----------------+----------+-----------+
        | marque     | modele  | immatriculation | prenom   | nom       |
        +------------+---------+-----------------+----------+-----------+
        | Peugeot    | 807     | AB-355-CA       | Philippe | Pandre    |
        | Peugeot    | 807     | AB-355-CA       | Julien   | Avigny    |
        | Citroen    | C8      | CE-122-AE       | Morgane  | Alamia    |
        | Mercedes   | Cls     | FG-953-HI       | Philippe | Pandre    |
        | Volkswagen | Touran  | SO-322-NV       | Amelie   | Blondelle |
        | Skoda      | Octavia | PB-631-TK       | NULL     | NULL      |
        | Volkswagen | Passat  | XN-973-MM       | NULL     | NULL      |
        | Renault    | Espace  | AA-123-BB       | NULL     | NULL      |
        +------------+---------+-----------------+----------+-----------+
        8 rows in set (0,00 sec)
-- 06 - Afficher tous les conducteurs et tous les vehicules, peu importe les correspondances.
SELECT * FROM conducteur, vehicule;

ou 

SELECT c.prenom, c.nom, v.marque, v.modele
FROM conducteur c
CROSS JOIN vehicule v;

+-----------+-----------+------------+---------+
| prenom    | nom       | marque     | modele  |
+-----------+-----------+------------+---------+
| TonPrenom | TonNom    | Peugeot    | 807     |
| Alex      | Richy     | Peugeot    | 807     |
| Amelie    | Blondelle | Peugeot    | 807     |
| Philippe  | Pandre    | Peugeot    | 807     |
| Morgane   | Alamia    | Peugeot    | 807     |
| Julien    | Avigny    | Peugeot    | 807     |
| TonPrenom | TonNom    | Citroen    | C8      |
| Alex      | Richy     | Citroen    | C8      |
| Amelie    | Blondelle | Citroen    | C8      |
| Philippe  | Pandre    | Citroen    | C8      |
| Morgane   | Alamia    | Citroen    | C8      |
| Julien    | Avigny    | Citroen    | C8      |
| TonPrenom | TonNom    | Mercedes   | Cls     |
| Alex      | Richy     | Mercedes   | Cls     |
| Amelie    | Blondelle | Mercedes   | Cls     |
| Philippe  | Pandre    | Mercedes   | Cls     |
| Morgane   | Alamia    | Mercedes   | Cls     |
| Julien    | Avigny    | Mercedes   | Cls     |
| TonPrenom | TonNom    | Volkswagen | Touran  |
| Alex      | Richy     | Volkswagen | Touran  |
| Amelie    | Blondelle | Volkswagen | Touran  |
| Philippe  | Pandre    | Volkswagen | Touran  |
| Morgane   | Alamia    | Volkswagen | Touran  |
| Julien    | Avigny    | Volkswagen | Touran  |
| TonPrenom | TonNom    | Skoda      | Octavia |
| Alex      | Richy     | Skoda      | Octavia |
| Amelie    | Blondelle | Skoda      | Octavia |
| Philippe  | Pandre    | Skoda      | Octavia |
| Morgane   | Alamia    | Skoda      | Octavia |
| Julien    | Avigny    | Skoda      | Octavia |
| TonPrenom | TonNom    | Volkswagen | Passat  |
| Alex      | Richy     | Volkswagen | Passat  |
| Amelie    | Blondelle | Volkswagen | Passat  |
| Philippe  | Pandre    | Volkswagen | Passat  |
| Morgane   | Alamia    | Volkswagen | Passat  |
| Julien    | Avigny    | Volkswagen | Passat  |
| TonPrenom | TonNom    | Renault    | Espace  |
| Alex      | Richy     | Renault    | Espace  |
| Amelie    | Blondelle | Renault    | Espace  |
| Philippe  | Pandre    | Renault    | Espace  |
| Morgane   | Alamia    | Renault    | Espace  |
| Julien    | Avigny    | Renault    | Espace  |
+-----------+-----------+------------+---------+
42 rows in set (0,00 sec)

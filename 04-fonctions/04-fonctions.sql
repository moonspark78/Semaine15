--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------- FONCTIONS PREDEFINIES ------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------


-- Ici quelques exemples de fonctions prédéfinies 

USE bibliotheque;

SELECT DATABASE(); -- Fonction indiquant le nom de la bdd actuellement sélectionnée

SELECT LAST_INSERT_ID(); -- Le dernier id inséré dans la BDD (auto incrémenté) de la session actuelle
                            -- Les ORM récents dans les framework back utilisent cette fonction lorsque l'on fait une insertion dans une table mais que l'on continue de manipuler la donnée
                            -- Il sera toujours intéressant après une insertion de récupérer immédiatement l'id pour continuer à traiter l'élément justement au travers de son id 


-- Fonctions de manipulation de string
SELECT CONCAT("a","b","c"); -- Permet de concaténer pour mettre dans une seule colonne
SELECT CONCAT_WS(" - ", "a","b","c"); -- Concaténation avec un séparateur (toujours dans une seule colonne)

SELECT CONCAT_WS(" ", id_abonne, prenom) AS "liste" FROM abonne;

SELECT SUBSTRING("bonjour", 4); -- Permet de couper une chaine

SELECT REPLACE("www.coucou.com", "w", "W"); -- Remplace un string par un autre avec une chaine

SELECT UPPER("Salut"); -- Mets tout en maj 

-- Fonctions de manipulation de date 
SELECT CURDATE(); -- La date du jour
SELECT CURDATE() + 0; -- La date du jour

SELECT CURTIME(); -- L'heure de l'instant
SELECT NOW(); -- La date et l'heure
SELECT CURRENT_TIMESTAMP(); -- La date et l'heure

SELECT UNIX_TIMESTAMP(CURDATE()); -- Transforme une date en timestamp 

SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY); -- Pour ajouter un intervale de temps à une date (pourquoi pas une date limite d'emprunt sur la bibliotheque ?)
SELECT DATE_ADD(CURDATE(), INTERVAL 2 MONTH);
SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR);

SELECT DAYNAME(CURDATE()); -- Le nom du jour

SELECT CURDATE();
SELECT DATE_FORMAT(CURDATE(), "%d-%m-%Y");
-- DATE_FORMAT nous permet de formater un type DATE/DATETIME en MySQL, cela nous permet de l'afficher en jour / mois / année plutot que annee - mois - jour 
-- Cela fonctionne avec des tokens de remplacement, voir doc !  https://sql.sh/fonctions/date_format
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------- PROCEDURE STOCKEE ----------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Une procédure est très similaire à une fonction
-- En MySQL la différence réside dans le fait qu'une fonction retourne une simple valeur alors que la procédure retourne un jeu de résultat de requête 

-- Les avantages d'une procédure stockée 
    -- Moins de risque de se tromper : plus facile de lancer une procédure nommée par exemple selectAll(), plutôt qu'à chaque fois de réécrire une requête SELECT avec une grosse jointure
    -- Meilleure compréhension : plus facile de lire le nom de la procédure plutôt qu'une requête entière 
    -- Facilité d'utilisation : Si d'autres personnes manipulent la BDD, même sans connaissances avancées en SQL, ils pourront comprendre facilement l'exécution d'une procédure 
    -- Evolutivité : Si la requête est amenée à changer, elle ne sera modifiée qu'à un seul endroit, dans le SGBD et pas besoin de modifier tous les endroits du back qui l'appelle 
    -- Sécurité : On laisse le travail à une seule personne : "La personne qui gère la BDD"
    -- Optimisation : La procédure se lance plus rapidement qu'une requête à la main car l'analyse et l'interprétation de la requête sont déjà effectuées 


DELIMITER $  
----------------------------------
-- Création d'une procédure stockée qui affiche la date du jour en français 
CREATE PROCEDURE date_du_jour()
BEGIN 
    SELECT DATE_FORMAT(CURDATE(), "%d/%m/%Y") AS "today";
END $ 
CALL date_du_jour() $
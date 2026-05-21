--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------- REQUETE PREPAREES ----------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Une requête préparée c'est une requête qui ne se lance pas immédiatement ! 

-- Elle va passer par un cycle d'analyse, d'interprétation puis d'exécution 

-- A quoi ça sert ? On s'en sert pour la sécurité ! Une requête préparée va être de se construire, de filtrer les params qu'on lui envoie, avant de s'exécuter 


SELECT * FROM employes WHERE prenom = "Jean-Pierre";

-- Là je défini une variable supposée reçu d'un form, d'une saisie utilisateur
SET @prenom = "Jean-Pierre";


-- Ici elle est exécutée directement 
SELECT * FROM employes WHERE prenom = @prenom;

-- Pour éviter que l'utilisateur m'envoie une chaine de caractère malveillante, pour tenter par exemple une injection SQL, je préfère passer par une requête préparée
PREPARE req1 FROM "SELECT * FROM employes WHERE prenom=?"; -- le ? ici est un trou ! une info manquante que je vais lui donner plus tard 
EXECUTE req1 USING @prenom; -- Ici on execute la requête en transmettant le param manquant, des filtres s'appliquent par défaut, généralement gérés par le langage back (notre PHP)
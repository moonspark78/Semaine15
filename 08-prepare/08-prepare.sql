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
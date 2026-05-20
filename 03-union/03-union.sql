-- UNION permet de fusionner des résultats en un seul !
-- ATTENTION, le nombre de champs/colonnes attendus doit être le même dans les requêtes concernées
-- UNION applique un DISTINCT par défaut pour ne pas avoir de doublons 
SELECT prenom AS "personnes physiques" FROM abonne 
UNION 
SELECT auteur FROM livre;
+--------------------+
| persones physiques |
+--------------------+
| Guillaume          |
| Benoit             |
| Chloe              |
| Laura              |
| Pierra             |
| GUY DE MAUPASSANT  |
| HONORE DE BALZAC   |
| ALPHONSE DAUDET    |
| ALEXANDRE DUMAS    |
+--------------------+

-- Pour avoir les doublons : 
-- UNION ALL 
SELECT prenom AS "personnes physiques" FROM abonne 
UNION ALL
SELECT auteur FROM livre;
+---------------------+
| personnes physiques |
+---------------------+
| Guillaume           |
| Benoit              |
| Chloe               |
| Laura               |
| Pierra              |
| GUY DE MAUPASSANT   |
| GUY DE MAUPASSANT   |
| HONORE DE BALZAC    |
| ALPHONSE DAUDET     |
| ALEXANDRE DUMAS     |
| ALEXANDRE DUMAS     |
+---------------------+
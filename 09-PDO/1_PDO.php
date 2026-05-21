<?php


// -------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------
// --------- PDO : PHP DATA OBJECT -----------------------------------------------------
// -------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------

// PDO est une classe prédéfinie de PHP, elle représente une connexion à un serveur de BDD 
// On va la manipuler avec MySQL mais on peut aussi manipuler PDO avec d'autres SGBD 
// On peut considérer que PDO est une "porte" vers notre BDD 

echo "<h2>01 - Connexion à la BDD</h2>";
// Pour créer une connexion à la BDD nous avons besoin de plusieurs info (voir doc)

// - Le dsn c'est à dire le service, le host et le nom de la bdd
// - Le login de connexion à la bdd
// - Le password de connexion pour ce login 
// - Eventuellement un array contenant des options 

$dsn = "mysql:host=localhost;dbname=entreprise"; // service - host - bdd 
$login = "root"; // le login bdd
$password = "root";  // le password du login (rien sur wamp, attention sur mamp c'est "root" ou le password que vous avez défini sur vos stacks)
$options = array(
    PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING // On mets les Erreurs en warning pour pouvoir les afficher ! 
);

// Création de l'objet PDO : 

try {
    $pdo = new PDO($dsn, $login, $password, $options); // Instanciation d'un objet PDO
} catch (PDOException $e) {
    echo "Erreur de BDD";
    exit;
}


// Si l'instanciation de l'objet s'est bien passé, je récupère un objet PDO et donc la connexion à la BDD a fonctionné ! 
var_dump($pdo);


echo "<h2>02 - Requêtes de type action (INSERT / UPDATE / DELETE)</h2>";

// Enregistrement d'un nouvel employé dans la BDD 

// Dans le cadre du cours on va utiliser la méthode "query" elle nous permet de lancer une requête directement (comme la console)
// ATTENTION, query n'est pas une méthode sécurisée pour nous protéger des injections SQL, en condition réelle on utilisera toujours la méthode prepare() que l'on verra en fin de ce chapitre 

// $stmt = $pdo->query("INSERT INTO employes (prenom, nom, salaire, sexe, service, date_embauche) VALUES ('Pierra', 'Lacaze', 12000, 'm', 'formation', CURDATE())");

// var_dump($stmt);

// $stmt est un objet de type PDOStatement, il représente la réponse à une requête lancée sur PDO, c'est un objet différent 
// Sur une requête de type action, pas grand chose à traiter

// Quand même, il existe de nombreuses méthodes intéressantes dans PDOStatement, par exemple rowCount() qui nous permet de connaitre le nombre de lignes impactées par la requête 
// echo "Nombre de lignes impactées par ma requête : " . $stmt->rowCount() . "<hr>";

// On peut utiliser rowCount() dans un form d'inscription pour comprendre si le pseudo est déjà pris ! On lance une requête SELECT sur la table user avec en condition le pseudo saisi dans le form 
// Si le rowCount() m'envoie 0, le pseudo libre, sinon, il ne l'est pas ! 


echo "<h2>03 - Requêtes de sélection pour une seule ligne de résultat</h2>";

// On va récupérer les infos de l'employé 995 

$stmt = $pdo->query("SELECT * FROM employes WHERE id_employes = 995");

// Ci dessous le résultat dans la console MySQL
// +-------------+--------+--------+------+-----------+---------------+---------+
// | id_employes | prenom | nom    | sexe | service   | date_embauche | salaire |
// +-------------+--------+--------+------+-----------+---------------+---------+
// |         995 | Pierra | Lacaze | m    | formation | 2026-05-21    |   12000 |
// +-------------+--------+--------+------+-----------+---------------+---------+

var_dump($stmt);
// Actuellement, la réponse n'est pas exploitable dans l'état, en fait, j'ai à l'intérieur du PDOStatement, un "result set MySQL"
// Pour rendre ça exploitable par mon PHP il va falloir extraire le résultat et ça grâce à la méthode fetch() 

// Il existe plusieurs modes de fonctionnement de fetch()
// En fonction du mode, on va recevoir un élément de type/forme différent 

// FETCH_ASSOC : Pour récupérer un array associatif (Nom des colonnes du résultat comme keys du array)
$data = $stmt->fetch(PDO::FETCH_ASSOC);
var_dump($data);
// array (size=7)
//   'id_employes' => int 995
//   'prenom' => string 'Pierra' (length=6)
//   'nom' => string 'Lacaze' (length=6)
//   'sexe' => string 'm' (length=1)
//   'service' => string 'formation' (length=9)
//   'date_embauche' => string '2026-05-21' (length=10)
//   'salaire' => float 12000

$stmt = $pdo->query("SELECT * FROM employes WHERE id_employes = 995");
// FETCH_OBJ : Pour récupérer non pas un array mais un objet stdClass avec les noms des props étant les noms des colonnes du résultat
$data = $stmt->fetch(PDO::FETCH_OBJ);
var_dump($data);
// C:\wamp64\www\Poseidon\S15-MySQL\09-PDO\09-pdo.php:98:boolean false ???   Si je ne relance pas ma requête, le résultat étant consommé par le premier fetch, alors je récupère un false 
// object(stdClass)[2]
//   public 'id_employes' => int 995
//   public 'prenom' => string 'Pierra' (length=6)
//   public 'nom' => string 'Lacaze' (length=6)
//   public 'sexe' => string 'm' (length=1)
//   public 'service' => string 'formation' (length=9)
//   public 'date_embauche' => string '2026-05-21' (length=10)
//   public 'salaire' => float 12000


$stmt = $pdo->query("SELECT * FROM employes WHERE id_employes = 995");
// FETCH_NUM : Pour récupérer un array indexé numériquement
$data = $stmt->fetch(PDO::FETCH_NUM);
var_dump($data);

$stmt = $pdo->query("SELECT * FROM employes WHERE id_employes = 995");
// FETCH_BOTH : Pour récupérer un array indexé numériquement ET associativement
$data = $stmt->fetch(PDO::FETCH_BOTH);
var_dump($data);

// En fonction du type de fetch que j'utilise, la manière d'appeler l'élément sera différente
// echo $data["prenom"];
// echo $data["1"];
// echo $data->prenom;

// Une ligne traitée avec fetch, n'existe plus dans la réponse ! C'est pour ça que je dois refaire une requête à chaque fois ou en tout cas que je ne peux pas fetch deux fois la même ligne 

echo "<h2>04 - Requêtes de sélection pour plusieurs lignes de résultat</h2>";

$stmt = $pdo->query("SELECT * FROM employes");

echo "Nombre d'employés : " . $stmt->rowCount() . "<hr>";

// fetch() ne traite qu'une seule ligne à la fois !
// A chaque fois que je l'appelle il traite une ligne de plus et une autre et une autre et une autre ! Une par une ! 
// Donc, j'ai intérêt ici à faire une boucle 
// L'utilisation de while est judicieuse car elle tourne tant qu'il y a des résultat dans le stmt (fetch me renvoie false quand c'est terminé ! donc la boucle s'arrêtera)

// while ($data = $stmt->fetch(PDO::FETCH_ASSOC)) {
//     var_dump($data);
//     echo "<hr>";
// }

// Libre à nous de l'interprêter comme on le souhaite à l'affichage 
// Tableau, cards, list, vignette ou autre (voir les exercices GET/POST de PHP)

// Ici façon affichage produit page d'accueil, dans des divs 
echo '<div style="display:flex; flex-wrap: wrap; justify-content: space-between">';
while ($employe = $stmt->fetch(PDO::FETCH_ASSOC)) : ?>
    <div style="margin-top: 20px; padding: 1%; width: 20%; background-color: steelblue; color: white">
        ID : <?= $employe["id_employes"] ?> <br>
        Prenom : <?= $employe["prenom"] ?> <br>
        Nom : <?= $employe["nom"] ?> <br>
        Service : <?= $employe["service"] ?> <br>
        Salaire : <?= $employe["salaire"] ?> <br>
        Sexe : <?= $employe["sexe"] ?> <br>
        Date embauche : <?= $employe["date_embauche"] ?> <br>
    </div>
<?php endwhile;
echo '</div><br><br>';


$stmt = $pdo->query("SELECT * FROM employes");
// Ici, même données mais affichage dans un tableau, type dashboard gestion 
echo '<style>th, td { padding: 10px; } </style>';
echo '<table border="1" style="border-collapse : collapse; width:100%;">';

echo '<tr>';
echo '<th>Id employes </th>';
echo '<th>Prénom </th>';
echo '<th>Nom </th>';
echo '<th>Sexe </th>';
echo '<th>Service </th>';
echo '<th>Date embauche </th>';
echo '<th>Salaire </th>';
echo '</tr>';

while ($employe = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo "<tr>";
    foreach ($employe as $valeur) {
        echo "<td>$valeur</td>";
    }
    echo "</tr>";
}

echo "</table>";

// On peut dans une requête et via PDOStatement récupérer des informations sur le nombre de colonnes et quels sont les champs demandés dans la requête
// Grâce à ça, on peut eventuellement créer un tableau dynamique ! Il sera capable de changer de structure en fonction du nombre de champs dans la requête 

$stmt = $pdo->query("SELECT prenom, salaire FROM employes");
// Dans PDOStatement il existe une methode columnCount()
// Elle me permet de comprendre le nombre de colonnes dans la réponse 
// Il existe aussi une méthode getColumnMeta() qui prends en param un int (correspondant à un numéro de colonne dans le résultat, 0 étant la première)
// Cette méthode me renvoie des informations sur la colonne en question ! Notamment, son nom  :) 

echo "Nombre de colonnes dans le résultat : " . $stmt->columnCount();

var_dump($stmt->getColumnMeta(0));


echo '<table border="1" style="border-collapse : collapse; width:100%;">';

echo '<tr>'; // Ici la ligne d'entête qui va se générer d'elle même grâce à la boucle for et la combinaison des info de columCount() et getColumnMeta()
for ($i = 0; $i < $stmt->columnCount(); $i++) {
    $infoColonne = $stmt->getColumnMeta($i);
    echo "<th>" . $infoColonne["name"] . "</th>";
}
echo '</tr>';


while ($employe = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo "<tr>";
    foreach ($employe as $valeur) {
        echo "<td>$valeur</td>";
    }
    echo "</tr>";
}

echo "</table>";

echo "<h2>05 - Requêtes de sélection pour plusieurs lignes de résultat avec fetchAll()</h2>";

// fetch() permet de traiter une seule ligne à la fois 
// fetchAll() traite toutes les lignes en une seule fois et il me donne un élément de type : array multidimensionnel ! En tout cas, on a un premier niveau de array indexé numériquement et chaque clé contient un employé  ! (une ligne de résultat )

$stmt = $pdo->query("SELECT * FROM employes");

$data = $stmt->fetchAll(PDO::FETCH_ASSOC); // fetchAll possède exactement les mêmes modes que fetch(), ASSOC, OBJ, etc 

var_dump($data);

echo "Premier employé de la BDD : " . $data[0]["prenom"] . "<hr>";


// EXERCICE : Affichez les noms et prénoms des employés dans une liste ul li  
    // Le faire avec fetch 
    // Le faire avec fetchAll 
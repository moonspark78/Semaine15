

<!-- /** 

EXERCICE TP Tchat en ligne : 
-------------------------------

- Création d'un tchat en ligne 


-- ETAPES : 

- 01 - Création de la BDD : dialogue 
    - Table : commentaire 
    - Champs de la table commentaire : 
        - id_commentaire        INT PK AI
        - pseudo                VARCHAR
        - message               TEXT
        - date_enregistrement   DATETIME

- 02 - Créer une connexion à cette base avec PDO

- 03 - Création d'un formulaire html permettant de poster un message 
    - Champs du formulaire (bootstrap) : 
        - pseudo (input text)
        - message (text area)
        - bouton submit

- 04 - Récupération des saisies du form avec controle (pseudo et message pas vide, pseudo pas trop court pas trop long, message pas trop court pas trop long etc)

- 05 - Déclenchement d'une requête d'enregistrement pour enregistrer les saisies dans la BDD

- 06 - Requête de récupération des messages afin de les afficher dans cette page 

- 07 - Affichage des messages avec un peu de mise en forme 

** -->/



<?php

// -------------------------
// CONNEXION BDD
// -------------------------
$pdo = new PDO("mysql:host=localhost;dbname=dialogue", "root", "root");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);


// -------------------------
// VARIABLES
// -------------------------
$messageErreur = "";


// -------------------------
// TRAITEMENT FORMULAIRE
// -------------------------
if ($_POST) {

    $pseudo = $_POST["pseudo"] ?? "";
    $message = $_POST["message"] ?? "";

    if (empty($pseudo) || empty($message)) {
        $messageErreur = "Les champs sont obligatoires";
    } else {

        // VERSION SIMPLE (NON SECURISEE)
        $pdo->query("
            INSERT INTO commentaire (pseudo, message, date_enregistrement)
            VALUES ('$pseudo', '$message', NOW())
        ");
    }
}


// -------------------------
// RECUPERATION MESSAGES
// -------------------------
$messages = $pdo->query("
    SELECT * FROM commentaire
    ORDER BY date_enregistrement DESC
")->fetchAll();

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tchat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="background:#f4f4f4;">
<div class="container mt-5">
    <h1 class="text-center mb-4">Espace de dialogue</h1>

    <!-- FORMULAIRE -->
    <div class="row justify-content-center">
        <div class="col-md-6 bg-white p-4 shadow rounded">

            <?php if ($messageErreur): ?>
                <div class="alert alert-danger">
                    <?= $messageErreur ?>
                </div>
            <?php endif; ?>

            <form method="post">
                <input type="text" name="pseudo" class="form-control mb-2" placeholder="Pseudo">
                <textarea name="message" class="form-control mb-2" placeholder="Message"></textarea>
                <button class="btn btn-dark w-100">Envoyer</button>
            </form>

        </div>
    </div>

    <!-- MESSAGES -->
    <div class="mt-5">
        <p><?= count($messages) ?> messages</p>

        <?php foreach ($messages as $m): ?>
            <div class="card mb-2">
                <div class="card-header">
                    <?= $m["pseudo"] ?> - <?= $m["date_enregistrement"] ?>
                </div>
                <div class="card-body">
                    <?= $m["message"] ?>
                </div>
            </div>
        <?php endforeach; ?>

    </div>

</div>

</body>
</html>
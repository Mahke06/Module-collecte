
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forrage</title>
    <link href="/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/assets/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>
    <div class="row">
        <div class="col-2 col-lg-2 col-sm-2"></div>
        <div class="col-10 col-lg-10 col-sm-10">
            <div class="card text-bg-light w-75 mb-3 ">
                <div class="card-header text-center"><h2>Gestion de forrage</h2></div>
                <div class="card-body">
                    <div class="row">
                        <a href="/demandes/liste" class="btn btn-outline-secondary mt-4">Liste des demandes</a>
                    </div>
                    <div class="row">
                        <a href="/devis/liste" class="btn btn-outline-secondary mt-4">Liste des devis</a>
                    </div>
                    <div class="row">
                        <a href="/statut-demande/ajout" class="btn btn-outline-secondary mt-4">Ajouter un statut de demande</a>
                    </div>
                    <div class="row">
                        <a href="/statut-demande/modif" class="btn btn-outline-secondary mt-4">Modifier un statut de demande</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
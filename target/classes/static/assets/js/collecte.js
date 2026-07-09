function importerExcel() {
    const fichier = document.getElementById('fichier-excel').files[0];
    const messageDiv = document.getElementById('message-import');

    if (!fichier) {
        messageDiv.innerHTML = '<div class="alert alert-error"><span>Veuillez choisir un fichier Excel</span></div>';
        return;
    }
    if (!fichier.name.endsWith('.xlsx')) {
        messageDiv.innerHTML = '<div class="alert alert-error"><span>Le fichier doit être au format .xlsx</span></div>';
        return;
    }

    const formData = new FormData();
    formData.append('fichier', fichier);
    messageDiv.innerHTML = '<div class="alert alert-info"><span>Lecture du fichier en cours...</span></div>';

    // ✅ Utiliser CONTEXT_PATH au lieu de ${pageContext.request.contextPath}
    fetch(CONTEXT_PATH + '/collectes/lire-excel', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.erreur) {
            messageDiv.innerHTML = '<div class="alert alert-error"><span>' + data.erreur + '</span></div>';
        } else {
            document.getElementById('nom').value = data.nom;
            document.getElementById('prenom').value = data.prenom;
            document.getElementById('telephone').value = data.telephone;
            document.getElementById('quantite').value = data.quantite;
            document.getElementById('humidite').value = data.tauxHumidite;
            document.getElementById('prix-unitaire').value = data.prixUnitaire;
            messageDiv.innerHTML = '<div class="alert alert-success"><span>Fichier lu avec succès !</span></div>';
        }
    })
    .catch(error => {
        messageDiv.innerHTML = '<div class="alert alert-error"><span>Erreur réseau : ' + error.message + '</span></div>';
    });
}
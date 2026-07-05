<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Collecte - Achat de Paddy</title>
</head>
<body>
    <section>
        <h2>Collecte: Achat de Paddy</h2>
        
        <c:if test="${not empty erreur}">
            <div style="color: red;">
                <p>${erreur}</p>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/collectes/calculer" method="post">
            <div>
                <label for="date-heure">Date et heure :</label>
                <input type="datetime-local" id="date-heure" name="dateHeure" required>
            </div>

            <div>
                <label for="client-info">Client :</label>
                <div>
                <label for="nom">Nom :</label>
                <input type="text" id="nom" name="nom" required>
                </div>
                <div>
                    <label for="prenom">Prénom :</label>
                    <input type="text" id="prenom" name="prenom" required>
                </div>
                <div>
                    <label for="telephone">Téléphone :</label>
                    <input type="number" id="telephone" name="telephone" required>
                </div>
            </div>

            <div>
                <label for="quantite">Quantité de Paddy (kg) :</label>
                <input type="number" id="quantite" name="quantite" step="0.01" required>
            </div>

            <div>
                <label for="humidite">Taux d'humidité (%) :</label>
                <input type="number" id="humidite" name="tauxHumidite" step="0.1" required>
            </div>

            <div>
                <label for="prix-unitaire">Prix unitaire (Ar/kg) :</label>
                <input type="number" id="prix-unitaire" name="prixUnitaire" step="0.01" required>
            </div>

            <br>
            <button type="submit">Calculer et valider</button>
        </form>

        <div>
            <label for="fichier-excel">Importer depuis Excel :</label>
            <input type="file" id="fichier-excel" accept=".xlsx">
            <button type="button" onclick="importerExcel()">Remplir depuis Excel</button>
        </div>
        <div id="message-import" style="margin-top: 10px;"></div>
        
    </section>

    <script>
        // Auto-remplir date actuelle
        window.addEventListener('load', function() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            document.getElementById('date-heure').value = `${year}-${month}-${day}T${hours}:${minutes}`;
        });

        function importerExcel() {
            const fichier = document.getElementById('fichier-excel').files[0];
            const messageDiv = document.getElementById('message-import');

            if (!fichier) {
                messageDiv.innerHTML = '<p style="color: red;">Veuillez choisir un fichier Excel</p>';
                return;
            }

            if (!fichier.name.endsWith('.xlsx')) {
                messageDiv.innerHTML = '<p style="color: red;">Le fichier doit être au format .xlsx</p>';
                return;
            }

            // Créer FormData pour envoyer le fichier
            const formData = new FormData();
            formData.append('fichier', fichier);

            messageDiv.innerHTML = '<p style="color: blue;">Lecture du fichier en cours...</p>';

            // Envoyer au serveur via Ajax
            fetch('${pageContext.request.contextPath}/collectes/lire-excel', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.erreur) {
                    messageDiv.innerHTML = '<p style="color: red;">' + data.erreur + '</p>';
                } else {
                    document.getElementById('nom').value = data.nom;
                    document.getElementById('prenom').value = data.prenom;
                    document.getElementById('telephone').value = data.telephone;
                    document.getElementById('quantite').value = data.quantite;
                    document.getElementById('humidite').value = data.tauxHumidite;
                    document.getElementById('prix-unitaire').value = data.prixUnitaire;

                    messageDiv.innerHTML = '<p style="color: green;">✓ Fichier lu avec succès !</p>';
                }
            })
            .catch(error => {
                messageDiv.innerHTML = '<p style="color: red;">Erreur réseau : ' + error.message + '</p>';
            });
        }
    </script>
</body>
</html>
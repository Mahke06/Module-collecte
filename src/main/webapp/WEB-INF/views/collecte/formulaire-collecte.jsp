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
                <input type="datetime-local" id="date-heure" name="dateHeure">
            </div>

            <div>
                <label for="client-select">Client :</label>
                <select id="client-select" name="clientId" onchange="remplirClient()" required>
                    <option value="">-- Sélectionner un client --</option>
                    <c:forEach var="c" items="${clients}">
                        <option value="${c.idClient}" 
                                data-nom="${c.nom}" 
                                data-prenom="${c.prenom}" 
                                data-telephone="${c.telephone}">
                            ${c.reference} - ${c.nom} ${c.prenom}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <fieldset>
                <legend>Informations Client</legend>
                <div>
                    <label for="nom">Nom :</label>
                    <input type="text" id="nom" name="nom" readonly>
                </div>
                <div>
                    <label for="prenom">Prénom :</label>
                    <input type="text" id="prenom" name="prenom" readonly>
                </div>
                <div>
                    <label for="telephone">Numéro de téléphone :</label>
                    <input type="tel" id="telephone" name="telephone" readonly>
                </div>
            </fieldset>

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
    </section>

    <script>
        function remplirClient() {
            const select = document.getElementById('client-select');
            const option = select.options[select.selectedIndex];
            
            document.getElementById('nom').value = option.getAttribute('data-nom') || '';
            document.getElementById('prenom').value = option.getAttribute('data-prenom') || '';
            document.getElementById('telephone').value = option.getAttribute('data-telephone') || '';
        }

        // Remplir la date/heure actuelle
        window.addEventListener('load', function() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            
            document.getElementById('date-heure').value = `${year}-${month}-${day}T${hours}:${minutes}`;
        });
    </script>
</body>
</html>
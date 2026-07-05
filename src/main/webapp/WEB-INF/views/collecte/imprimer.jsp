<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Impression Facture - Collecte ${lot.idLotPaddy}</title>
</head>
<body>
    <section>
        <h2>Facture de Collecte</h2>
    </section>

    <section>
        <h3>Details du lot</h3>
    </section>

    <section>
        <ul>
            <li><strong>Date:</strong> ${lot.date}</li>
            <li><strong>Référence client:</strong> ${client.reference}</li>
            <li><strong>Nom:</strong> ${client.nom}</li>
            <li><strong>Prénom:</strong> ${client.prenom}</li>
            <li><strong>Numéro tel:</strong> ${client.telephone}</li>
            <li><strong>Quantité de Paddy:</strong> 
                <fmt:formatNumber value="${lot.quantite}" pattern="#,##0.##"/> kg
            </li>
            <li><strong>Taux d'humidité:</strong> 
                <fmt:formatNumber value="${lot.tauxHumidite}" pattern="#0.0"/> %
            </li>
            <li><strong>Prix/kg:</strong> 
                <fmt:formatNumber value="${lot.collecte.prixUnitaire}" pattern="#,##0"/> Ar
            </li>
            <li><strong>Montant total:</strong> 
                <fmt:formatNumber value="${lot.prixCollecte}" pattern="#,##0"/> Ar
            </li>
        </ul>
    </section>
    <div>
        <button type="button" onclick="window.print()">Imprimer la facture</button>
        <button type="button" onclick="window.history.back()">Retour</button>
    </div>
</body>
</html>
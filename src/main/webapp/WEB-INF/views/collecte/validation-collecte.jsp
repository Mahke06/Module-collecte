<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Validation Collecte - Facture</title>
</head>
<body>
    <section>
        <h2>Collecte: Facture/Détail lot de Paddy</h2>
        
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

        <c:if test="${lot.idLotPaddy == 0}">
            <form action="${pageContext.request.contextPath}/collectes/enregistrer" method="post" style="display:inline;">
                <input type="hidden" name="clientId" value="${client.idClient}">
                <input type="hidden" name="quantite" value="${lot.quantite}">
                <input type="hidden" name="prixUnitaire" value="${prixUnitaireOriginal}">
                <input type="hidden" name="tauxHumidite" value="${lot.tauxHumidite}">
                
                <button type="submit">Confirmer l'achat</button>
            </form>
            <button type="button" onclick="window.history.back()">Annuler</button>
        </c:if>

        <c:if test="${lot.idLotPaddy != 0}">
            <c:if test="${statutActuel != 'PAYE'}">
                <form action="${pageContext.request.contextPath}/collectes/payer-lot" method="post" style="display:inline;">
                    <input type="hidden" name="idLot" value="${lot.idLotPaddy}">
                    <button type="submit">Payer</button>
                </form>
            </c:if>

            <c:if test="${statutActuel == 'PAYE'}">
                <p style="color: green;"><strong>✓ Lot déjà payé</strong></p>
            </c:if>

            <form action="${pageContext.request.contextPath}/collectes/annuler" method="post" style="display:inline;">
                <input type="hidden" name="idLot" value="${lot.idLotPaddy}">
                <button type="submit" onclick="return confirm('Voulez-vous vraiment annuler cet achat ?')">
                    Annuler l'achat
                </button>
            </form>

            <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/collectes/liste'">
                Retour à la liste
            </button>
        </c:if>
    </section>
</body>
</html>
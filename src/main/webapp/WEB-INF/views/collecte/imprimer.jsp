<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facture collecte - VOLY VARY</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/collecte-3.css">
    <style>
       
    </style>
</head>
<body>
    <div class="page-heading no-print">
        <div>
            <h1>Facture de Collecte</h1>
            <p>Détail du lot de paddy</p>
        </div>
        <button type="button" class="btn btn-outline btn-sm" onclick="window.history.back()">
            Retour
        </button>
    </div>

    <div class="section-card">
        <div class="card recap-card">
            <div class="card-head">
                <h3>Lot ${lot.reference}</h3>
            </div>
            <div class="card-body">

                <!-- ... Toutes les lignes de la facture ... -->
                <div class="recap-row">
                    <span class="recap-label">Date</span>
                    <span class="recap-value">${lot.date}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Référence client</span>
                    <span class="recap-value">${client.reference}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Nom</span>
                    <span class="recap-value">${client.nom}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Prénom</span>
                    <span class="recap-value">${client.prenom}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Numéro tel</span>
                    <span class="recap-value">${client.telephone}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Quantité de Paddy</span>
                    <span class="recap-value">
                        <fmt:formatNumber value="${lot.quantite}" pattern="#,##0.##"/> kg
                    </span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Taux d'humidité</span>
                    <span class="recap-value">
                        <fmt:formatNumber value="${lot.tauxHumidite}" pattern="#0.0"/> %
                    </span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Prix/kg</span>
                    <span class="recap-value">
                        <fmt:formatNumber value="${lot.collecte.prixUnitaire}" pattern="#,##0"/> Ar
                    </span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Montant total</span>
                    <span class="recap-value">
                        <fmt:formatNumber value="${lot.prixCollecte}" pattern="#,##0"/> Ar
                    </span>
                </div>

                <div class="flow-actions no-print">
                    <button type="button" class="btn btn-primary" onclick="window.print()">
                        Imprimer la facture
                    </button>
                    <button type="button" class="btn btn-outline" onclick="window.history.back()">
                        Retour
                    </button>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
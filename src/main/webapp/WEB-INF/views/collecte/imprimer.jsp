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
</head>
<body>

<div class="app-shell">
    <jsp:include page="/WEB-INF/views/sidebar/sidebar.jsp" />
    <div class="main-content">
        <header class="topbar">
            <button class="icon-btn menu-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
            </button>
            <div class="topbar-search">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/></svg>
                <input type="text" placeholder="Rechercher...">
            </div>
            <div class="topbar-actions">
                <button class="icon-btn" aria-label="Notifications">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8a6 6 0 00-12 0c0 7-3 9-3 9h18s-3-2-3-9M13.73 21a2 2 0 01-3.46 0"/></svg>
                    <span class="dot"></span>
                </button>
                <div class="topbar-profile">
                    <div class="avatar">AD</div>
                </div>
            </div>
        </header>
        <main class="page-body">

    <div class="page-heading no-print">
        <div>
            <h1>Facture de Collecte</h1>
            <p>Detail du lot de paddy</p>
        </div>
        <button type="button" class="btn btn-outline btn-sm" onclick="window.history.back()">Retour</button>
    </div>

    <div class="section-card">
        <div class="card recap-card">
            <div class="card-head">
                <h3>Lot ${lot.reference}</h3>
            </div>
            <div class="card-body">

                <div class="recap-row">
                    <span class="recap-label">Date</span>
                    <span class="recap-value">${lot.date}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Reference client</span>
                    <span class="recap-value">${client.reference}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Nom</span>
                    <span class="recap-value">${client.nom}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Prenom</span>
                    <span class="recap-value">${client.prenom}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Numero tel</span>
                    <span class="recap-value">${client.telephone}</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Quantite de Paddy</span>
                    <span class="recap-value"><fmt:formatNumber value="${lot.quantite}" pattern="#,##0.##"/> kg</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Taux d'humidite</span>
                    <span class="recap-value"><fmt:formatNumber value="${lot.tauxHumidite}" pattern="#0.0"/> %</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Prix/kg</span>
                    <span class="recap-value"><fmt:formatNumber value="${lot.collecte.prixUnitaire}" pattern="#,##0"/> Ar</span>
                </div>
                <div class="recap-row">
                    <span class="recap-label">Montant total</span>
                    <span class="recap-value"><fmt:formatNumber value="${lot.prixCollecte}" pattern="#,##0"/> Ar</span>
                </div>

                <div class="flow-actions no-print">
                    <button type="button" class="btn btn-primary" onclick="window.print()">Imprimer la facture</button>
                    <button type="button" class="btn btn-outline" onclick="window.history.back()">Retour</button>
                </div>

            </div>
        </div>
    </div>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/toast.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/modal.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/store.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/sidebar.js"></script>
</body>
</html>
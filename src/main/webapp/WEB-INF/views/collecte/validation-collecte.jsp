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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/collecte-2.css">
</head>
<body>

<div class="app-shell">
    <aside class="sidebar">
        <div class="sidebar-brand">
            <svg class="logo-mark" viewBox="0 0 32 32" fill="none"><rect width="32" height="32" rx="8" fill="#2563EB"/><path d="M9 11l7 12 7-12" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
            <span class="logo-text">VOLY VARY</span>
        </div>
        <div class="sidebar-user">
            <div class="avatar">AD</div>
            <div class="who"><strong>Administrateur</strong><span>Administrateur</span></div>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="9" rx="1.5"/><rect x="14" y="3" width="7" height="5" rx="1.5"/><rect x="14" y="12" width="7" height="9" rx="1.5"/><rect x="3" y="16" width="7" height="5" rx="1.5"/></svg><span>Dashboard</span></a>
            <a href="${pageContext.request.contextPath}/collectes/valides" class="sidebar-link active"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/></svg><span>Collecte</span></a>
        </nav>
        <div class="sidebar-footer">
            <button class="sidebar-toggle">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:14px;height:14px"><path d="M15 18l-6-6 6-6"/></svg>
                <span>Reduire</span>
            </button>
        </div>
    </aside>
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

    <div class="page-heading">
        <div>
            <h1>Collecte : facture / detail lot de paddy</h1>
            <p>Verifiez les informations avant de valider le paiement</p>
        </div>
        <a href="${pageContext.request.contextPath}/collectes/valides" class="btn btn-outline btn-sm">Retour a la liste</a>
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

                <c:if test="${lot.idLotPaddy == 0}">
                    <div class="flow-actions">
                        <form action="${pageContext.request.contextPath}/collectes/enregistrer" method="post" style="display:inline;">
                            <input type="hidden" name="dateHeure" value="${dateHeure}">
                            <input type="hidden" name="clientId" value="${client.idClient}">
                            <input type="hidden" name="quantite" value="${lot.quantite}">
                            <input type="hidden" name="prixUnitaire" value="${prixUnitaireOriginal}">
                            <input type="hidden" name="tauxHumidite" value="${lot.tauxHumidite}">
                            <button type="submit" class="btn btn-primary">Confirmer l'achat</button>
                        </form>
                        <button type="button" class="btn btn-outline" onclick="window.history.back()">Annuler</button>
                    </div>
                </c:if>

                <c:if test="${lot.idLotPaddy != 0}">
                    <c:if test="${statutActuel != 'VALIDE'}">
                        <div class="flow-actions">
                            <form action="${pageContext.request.contextPath}/collectes/payer-lot" method="post" style="display:inline;">
                                <input type="hidden" name="idLot" value="${lot.idLotPaddy}">
                                <button type="submit" class="btn btn-primary">Payer</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/collectes/annuler" method="post" style="display:inline;">
                                <input type="hidden" name="idLot" value="${lot.idLotPaddy}">
                                <button type="submit" class="btn btn-outline" onclick="return confirm('Voulez-vous vraiment annuler cet achat ?')">Annuler l'achat</button>
                            </form>
                            <a href="${pageContext.request.contextPath}/collectes/imprimer/${lot.idLotPaddy}" class="btn btn-outline">Imprimer la facture</a>
                        </div>
                    </c:if>
                    <c:if test="${statutActuel == 'VALIDE'}">
                        <div class="recap-row">
                            <span class="recap-label">Statut</span>
                            <span class="recap-value" style="color:green;font-weight:700;">Lot deja paye</span>
                        </div>
                        <div class="flow-actions">
                            <a href="${pageContext.request.contextPath}/collectes/imprimer/${lot.idLotPaddy}" class="btn btn-outline">Imprimer la facture</a>
                        </div>
                    </c:if>
                </c:if>

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
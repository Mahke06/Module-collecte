<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle collecte - VOLY VARY</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/collecte-2.css">
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

    <div class="page-heading">
        <div>
            <h1>Collecte : achat de paddy</h1>
            <p>Enregistrer un nouveau lot achete aupres d'un producteur</p>
        </div>
        <a href="${pageContext.request.contextPath}/collectes/valides" class="btn btn-outline btn-sm">Retour a la liste</a>
    </div>

    <div class="section-card">
        <div class="card">
            <div class="card-body">

                <c:if test="${not empty erreur}">
                    <div class="alert alert-error">
                        <span>${erreur}</span>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/collectes/calculer" method="post" id="form-collecte">
                    <div class="form-grid">
                        <div class="form-field full">
                            <label>Date et heure</label>
                            <input type="datetime-local" id="date-heure" name="dateHeure" required>
                        </div>
                    </div>

                    <div class="client-box">
                        <div class="form-field">
                            <label for="reference">Reference client :</label>
                            <input type="text" id="reference" name="reference" required onblur="rechercherClient()">
                        </div>
                        <div class="form-field">
                            <label>Nom</label>
                            <input type="text" id="nom" name="nom" required>
                        </div>
                        <div class="form-field">
                            <label>Prenom</label>
                            <input type="text" id="prenom" name="prenom" required>
                        </div>
                        <div class="form-field">
                            <label>Numero telephone</label>
                            <input type="text" id="telephone" name="telephone" placeholder="032 00 000 00" required>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-field">
                            <label>Quantite de Paddy (kg)</label>
                            <input type="number" id="quantite" name="quantite" min="1" step="0.01" required>
                        </div>
                        <div class="form-field">
                            <label>Taux d'humidite (%)</label>
                            <input type="number" id="humidite" name="tauxHumidite" min="0" max="100" step="0.1" required>
                        </div>
                        <div class="form-field">
                            <label>Prix unitaire (Ar/kg)</label>
                            <input type="number" id="prix-unitaire" name="prixUnitaire" step="0.01" required>
                        </div>
                    </div>

                    <div class="flow-actions">
                        <button type="submit" class="btn btn-primary">Calculer et valider</button>
                    </div>
                </form>

                <div class="form-grid" style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid var(--color-gray-200);">
                    <div class="form-field full">
                        <label>Importer depuis Excel</label>
                        <div class="flow-actions">
                            <input type="file" id="fichier-excel" accept=".xlsx">
                            <button type="button" class="btn btn-outline" onclick="importerExcel()">Remplir depuis Excel</button>
                        </div>
                        <div id="message-import" style="margin-top: 0.75rem;"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        const CONTEXT_PATH = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/store.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/collecte.js"></script>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/toast.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/modal.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/sidebar.js"></script>
</body>
</html>
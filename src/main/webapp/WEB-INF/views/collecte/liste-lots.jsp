<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Collecte - VOLY VARY</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/collecte.css">
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
            <h1>Collecte : liste des lots de paddy</h1>
            <p>Suivi des collectes aupres des producteurs</p>
        </div>
        <a href="${pageContext.request.contextPath}/collectes/nouveau" class="btn btn-primary btn-sm">
            + Nouvelle collecte
        </a>
    </div>

    <div class="stat-grid">
        <div class="stat-card">
            <div class="stat-value"><fmt:formatNumber value="${quantiteTotale}" pattern="#,##0.##"/> kg</div>
            <div class="stat-label">Quantite totale collectee</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><fmt:formatNumber value="${recetteTotale}" pattern="#,##0"/> Ar</div>
            <div class="stat-label">Recette totale obtenue</div>
        </div>
    </div>

    <div class="section-card">
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/collectes/liste" method="get">
                    <input type="hidden" name="page" value="0">
                    <div class="filtre-grid">
                        <div class="form-field">
                            <label>Reference</label>
                            <input type="text" name="reference" value="${reference}" placeholder="Ex: LP001">
                        </div>
                        <div class="form-field">
                            <label>Date min</label>
                            <input type="date" name="dateMin" value="${dateMin}">
                        </div>
                        <div class="form-field">
                            <label>Date max</label>
                            <input type="date" name="dateMax" value="${dateMax}">
                        </div>
                        <div class="form-field">
                            <label>Quantite min (kg)</label>
                            <input type="number" name="quantiteMin" value="${quantiteMin}" step="0.01" placeholder="0">
                        </div>
                        <div class="form-field">
                            <label>Quantite max (kg)</label>
                            <input type="number" name="quantiteMax" value="${quantiteMax}" step="0.01" placeholder="99999">
                        </div>
                        <div class="form-field">
                            <label>Prix min (Ar)</label>
                            <input type="number" name="prixMin" value="${prixMin}" step="0.01" placeholder="0">
                        </div>
                        <div class="form-field">
                            <label>Prix max (Ar)</label>
                            <input type="number" name="prixMax" value="${prixMax}" step="0.01" placeholder="99999">
                        </div>
                        <div class="form-field">
                            <label>Total min (Ar)</label>
                            <input type="number" name="totalMin" value="${totalMin}" step="0.01" placeholder="0">
                        </div>
                        <div class="form-field">
                            <label>Total max (Ar)</label>
                            <input type="number" name="totalMax" value="${totalMax}" step="0.01" placeholder="99999999">
                        </div>
                        <div class="filtre-actions">
                            <button type="submit" class="btn btn-primary">Rechercher</button>
                            <a href="${pageContext.request.contextPath}/collectes/liste" class="btn btn-outline">Reinitialiser</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="section-card">
        <div class="card">
            <div class="table-wrapper">
                <table class="table-lots">
                    <thead>
                        <tr>
                            <th><a href="${pageContext.request.contextPath}/collectes/liste?page=0&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=reference&ordre=${triePar == 'reference' && ordre == 'asc' ? 'desc' : 'asc'}">Reference <c:if test="${triePar == 'reference'}">${ordre == 'asc' ? '▲' : '▼'}</c:if></a></th>
                            <th><a href="${pageContext.request.contextPath}/collectes/liste?page=0&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=date&ordre=${triePar == 'date' && ordre == 'asc' ? 'desc' : 'asc'}">Date <c:if test="${triePar == 'date'}">${ordre == 'asc' ? '▲' : '▼'}</c:if></a></th>
                            <th><a href="${pageContext.request.contextPath}/collectes/liste?page=0&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=quantite&ordre=${triePar == 'quantite' && ordre == 'asc' ? 'desc' : 'asc'}">Quantite (kg) <c:if test="${triePar == 'quantite'}">${ordre == 'asc' ? '▲' : '▼'}</c:if></a></th>
                            <th><a href="${pageContext.request.contextPath}/collectes/liste?page=0&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=prix&ordre=${triePar == 'prix' && ordre == 'asc' ? 'desc' : 'asc'}">Prix unitaire (Ar) <c:if test="${triePar == 'prix'}">${ordre == 'asc' ? '▲' : '▼'}</c:if></a></th>
                            <th><a href="${pageContext.request.contextPath}/collectes/liste?page=0&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=total&ordre=${triePar == 'total' && ordre == 'asc' ? 'desc' : 'asc'}">Total (Ar) <c:if test="${triePar == 'total'}">${ordre == 'asc' ? '▲' : '▼'}</c:if></a></th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="lot" items="${lots}">
                            <tr>
                                <td><strong>${lot.reference}</strong></td>
                                <td>${lot.date}</td>
                                <td><fmt:formatNumber value="${lot.quantite}" pattern="#,##0.##"/> kg</td>
                                <td><fmt:formatNumber value="${lot.collecte.prixUnitaire}" pattern="#,##0"/> Ar</td>
                                <td><fmt:formatNumber value="${lot.prixCollecte}" pattern="#,##0"/> Ar</td>
                                <td>
                                    <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/collectes/detail/${lot.idLotPaddy}">Voir</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty lots}">
                            <tr><td colspan="6" class="vide">Aucun lot enregistre</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="export-bar">
                <span class="export-label">Exporter la liste filtree :</span>
                <div class="export-btns">
                    <a href="${pageContext.request.contextPath}/collectes/export/csv?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}" class="btn btn-outline">CSV</a>
                    <a href="${pageContext.request.contextPath}/collectes/export/excel?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}" class="btn btn-outline">Excel</a>
                    <a href="${pageContext.request.contextPath}/collectes/export/pdf?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}" class="btn btn-outline">PDF</a>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${pageTotales > 1}">
        <div class="pagination">
            <c:if test="${pageCourante > 0}">
                <a href="${pageContext.request.contextPath}/collectes/liste?page=${pageCourante - 1}&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}">Precedent</a>
            </c:if>
            <c:forEach var="i" begin="0" end="${pageTotales - 1}">
                <c:choose>
                    <c:when test="${i == pageCourante}"><span class="active">${i + 1}</span></c:when>
                    <c:otherwise><a href="${pageContext.request.contextPath}/collectes/liste?page=${i}&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}">${i + 1}</a></c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageCourante < pageTotales - 1}">
                <a href="${pageContext.request.contextPath}/collectes/liste?page=${pageCourante + 1}&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}">Suivant</a>
            </c:if>
        </div>
    </c:if>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/toast.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/modal.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/store.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/sidebar.js"></script>
</body>
</html>
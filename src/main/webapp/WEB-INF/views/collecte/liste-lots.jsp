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
    <style>
        .filtre-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.6rem 1.2rem;
        }
        .filtre-grid .form-field {
            display: flex;
            flex-direction: column;
            gap: 0.2rem;
        }
        .filtre-grid label {
            font-size: 0.78rem;
            font-weight: 600;
            color: #555;
        }
        .filtre-grid input {
            padding: 0.35rem 0.6rem;
            font-size: 0.85rem;
            height: 2.1rem;
            border: 1px solid #ddd;
            border-radius: 6px;
        }
        .filtre-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.6rem;
            grid-column: span 3;
        }
        .filtre-actions .btn {
            padding: 0.45rem 1.3rem;
            font-size: 0.85rem;
        }
        .table-wrapper { width: 100%; overflow-x: auto; }
        .table-lots { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
        .table-lots thead tr { background-color: #f0f4f8; border-bottom: 2px solid #d0d7de; }
        .table-lots th {
            padding: 0.75rem 1rem;
            text-align: left;
            font-weight: 700;
            color: #333;
            white-space: nowrap;
        }
        .table-lots th a {
            text-decoration: none;
            color: inherit;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        .table-lots th a:hover { color: var(--primary, #2563eb); }
        .table-lots tbody tr { border-bottom: 1px solid #eee; transition: background 0.15s; }
        .table-lots tbody tr:hover { background-color: #f8fafc; }
        .table-lots td { padding: 0.65rem 1rem; color: #444; white-space: nowrap; }
        .table-lots td.vide { text-align: center; color: #999; padding: 2rem; font-style: italic; }

        .export-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            padding: 0.9rem 1rem;
            border-top: 1px solid #eee;
            background-color: #fafbfc;
        }
        .export-bar .export-label { font-size: 0.85rem; font-weight: 600; color: #555; }
        .export-bar .export-btns { display: flex; gap: 0.5rem; }
        .export-bar .btn { font-size: 0.82rem; padding: 0.4rem 1rem; }

        .stat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .stat-card { padding: 0.75rem 1rem; }
        .stat-value { font-size: 1.4rem; font-weight: 700; }
        .stat-label { font-size: 0.78rem; color: #666; }

        .pagination {
            display: flex;
            gap: 0.4rem;
            align-items: center;
            padding: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .pagination a, .pagination span {
            padding: 0.35rem 0.7rem;
            border-radius: 6px;
            font-size: 0.85rem;
            text-decoration: none;
            color: #333;
        }
        .pagination a { border: 1px solid #ddd; }
        .pagination a:hover { background: #f0f4f8; }
        .pagination span.active { background: var(--primary, #2563eb); color: white; }
    </style>
</head>
<body>

    <div class="page-heading">
        <div>
            <h1>Collecte : liste des lots de paddy</h1>
            <p>Suivi des collectes auprès des producteurs</p>
        </div>
        <a href="${pageContext.request.contextPath}/collectes/nouveau" class="btn btn-primary btn-sm">
            + Nouvelle collecte
        </a>
    </div>

    <!-- Stats -->
    <div class="stat-grid">
        <div class="stat-card">
            <div class="stat-value">
                <fmt:formatNumber value="${quantiteTotale}" pattern="#,##0.##"/> kg
            </div>
            <div class="stat-label">Quantité totale collectée</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">
                <fmt:formatNumber value="${recetteTotale}" pattern="#,##0"/> Ar
            </div>
            <div class="stat-label">Recette totale obtenue</div>
        </div>
    </div>

    <!-- Filtres -->
    <div class="section-card">
        <div class="card">
            <div class="card-body" style="padding: 0.75rem 1rem;">
                <form action="${pageContext.request.contextPath}/collectes/liste" method="get">
                    <div class="filtre-grid">
                        <div class="form-field">
                            <label>Référence</label>
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
                            <label>Quantité min (kg)</label>
                            <input type="number" name="quantiteMin" value="${quantiteMin}" step="0.01" placeholder="0">
                        </div>
                        <div class="form-field">
                            <label>Quantité max (kg)</label>
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
                            <button type="submit" class="btn btn-primary">🔍 Rechercher</button>
                            <a href="${pageContext.request.contextPath}/collectes/liste" class="btn btn-outline">✖ Réinitialiser</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Tableau + Export -->
    <div class="section-card">
        <div class="card">

            <div class="table-wrapper">
                <table class="table-lots">
                    <thead>
                        <tr>
                            <th>
                                <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=reference&ordre=${triePar == 'reference' && ordre == 'asc' ? 'desc' : 'asc'}">
                                    Référence
                                    <c:if test="${triePar == 'reference'}">${ordre == 'asc' ? '▲' : '▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=date&ordre=${triePar == 'date' && ordre == 'asc' ? 'desc' : 'asc'}">
                                    Date
                                    <c:if test="${triePar == 'date'}">${ordre == 'asc' ? '▲' : '▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=quantite&ordre=${triePar == 'quantite' && ordre == 'asc' ? 'desc' : 'asc'}">
                                    Quantité (kg)
                                    <c:if test="${triePar == 'quantite'}">${ordre == 'asc' ? '▲' : '▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=prix&ordre=${triePar == 'prix' && ordre == 'asc' ? 'desc' : 'asc'}">
                                    Prix unitaire (Ar)
                                    <c:if test="${triePar == 'prix'}">${ordre == 'asc' ? '▲' : '▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=total&ordre=${triePar == 'total' && ordre == 'asc' ? 'desc' : 'asc'}">
                                    Total (Ar)
                                    <c:if test="${triePar == 'total'}">${ordre == 'asc' ? '▲' : '▼'}</c:if>
                                </a>
                            </th>
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
                                    <a class="btn btn-outline btn-sm"
                                       href="${pageContext.request.contextPath}/collectes/detail/${lot.idLotPaddy}">
                                        👁 Voir
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty lots}">
                            <tr>
                                <td colspan="6" class="vide">Aucun lot enregistré</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- ✅ URLs CORRIGÉES : /export/csv, /export/excel, /export/pdf -->
            <div class="export-bar">
                <span class="export-label">📥 Exporter la liste filtrée :</span>
                <div class="export-btns">
                    <a href="${pageContext.request.contextPath}/collectes/export/csv?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}"
                       class="btn btn-outline">📄 CSV</a>
                    <a href="${pageContext.request.contextPath}/collectes/export/excel?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}"
                       class="btn btn-outline">📊 Excel</a>
                    <a href="${pageContext.request.contextPath}/collectes/export/pdf?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}"
                       class="btn btn-outline">📕 PDF</a>
                </div>
            </div>

        </div>
    </div>

    <c:if test="${pageTotales > 1}">
        <div class="pagination">
            <c:if test="${pageCourante > 0}">
                <a href="${pageContext.request.contextPath}/collectes/liste?page=${pageCourante - 1}&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}">← Précédent</a>
            </c:if>

            <c:forEach var="i" begin="0" end="${pageTotales - 1}">
                <c:choose>
                    <c:when test="${i == pageCourante}">
                        <span class="active">${i + 1}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/collectes/liste?page=${i}&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}">${i + 1}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${pageCourante < pageTotales - 1}">
                <a href="${pageContext.request.contextPath}/collectes/liste?page=${pageCourante + 1}&reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&triePar=${triePar}&ordre=${ordre}">Suivant →</a>
            </c:if>
        </div>
    </c:if>

</body>
</html>
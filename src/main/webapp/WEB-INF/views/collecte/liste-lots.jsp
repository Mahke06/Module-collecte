<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Lots de Paddy</title>
</head>
<body>
    <section>
        <h2>Collecte: liste des lots de paddy</h2>

        
        <form action="${pageContext.request.contextPath}/collectes/liste" method="get">
            <table>
                <tr>
                    <td><label>Référence :</label></td>
                    <td><input type="text" name="reference" value="${reference}" placeholder="Ex: LP001"></td>
                </tr>
                <tr>
                    <td><label>Date :</label></td>
                    <td>
                        Min : <input type="date" name="dateMin" value="${dateMin}">
                        Max : <input type="date" name="dateMax" value="${dateMax}">
                    </td>
                </tr>
                <tr>
                    <td><label>Quantité (kg) :</label></td>
                    <td>
                        Min : <input type="number" name="quantiteMin" value="${quantiteMin}" step="0.01" placeholder="0">
                        Max : <input type="number" name="quantiteMax" value="${quantiteMax}" step="0.01" placeholder="99999">
                    </td>
                </tr>
                <tr>
                    <td><label>Prix unitaire (Ar) :</label></td>
                    <td>
                        Min : <input type="number" name="prixMin" value="${prixMin}" step="0.01" placeholder="0">
                        Max : <input type="number" name="prixMax" value="${prixMax}" step="0.01" placeholder="99999">
                    </td>
                </tr>
                <tr>
                    <td><label>Total (Ar) :</label></td>
                    <td>
                        Min : <input type="number" name="totalMin" value="${totalMin}" step="0.01" placeholder="0">
                        Max : <input type="number" name="totalMax" value="${totalMax}" step="0.01" placeholder="99999999">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="submit">Rechercher</button>
                        <a href="${pageContext.request.contextPath}/collectes/liste">Réinitialiser</a>
                    </td>
                </tr>
            </table>
        </form>

        <br>


        
        
        <div>
            <div>
                <p><strong>Quantité totale collectée:</strong> 
                    <fmt:formatNumber value="${quantiteTotale}" pattern="#,##0.##"/> kg
                </p>
            </div>
            <div>
                <p><strong>Recette totale obtenue:</strong> 
                    <fmt:formatNumber value="${recetteTotale}" pattern="#,##0"/> Ar
                </p>
            </div>
        </div>

        <br>

        <table border="1">
            <thead>
                <tr>
                    <!-- ✅ En-têtes TRIABLES -->
                    <th class="sortable">
                        <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&sortBy=reference&sortOrder=${sortBy == 'reference' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Référence 
                            <c:if test="${sortBy == 'reference'}">
                                <span class="sort-indicator">${sortOrder == 'asc' ? '▲' : '▼'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th class="sortable">
                        <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&sortBy=date&sortOrder=${sortBy == 'date' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Date 
                            <c:if test="${sortBy == 'date'}">
                                <span class="sort-indicator">${sortOrder == 'asc' ? '▲' : '▼'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th class="sortable">
                        <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&sortBy=quantite&sortOrder=${sortBy == 'quantite' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Quantité (kg) 
                            <c:if test="${sortBy == 'quantite'}">
                                <span class="sort-indicator">${sortOrder == 'asc' ? '▲' : '▼'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th class="sortable">
                        <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&sortBy=prix&sortOrder=${sortBy == 'prix' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Prix unitaire (Ar) 
                            <c:if test="${sortBy == 'prix'}">
                                <span class="sort-indicator">${sortOrder == 'asc' ? '▲' : '▼'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th class="sortable">
                        <a href="${pageContext.request.contextPath}/collectes/liste?reference=${reference}&dateMin=${dateMin}&dateMax=${dateMax}&quantiteMin=${quantiteMin}&quantiteMax=${quantiteMax}&prixMin=${prixMin}&prixMax=${prixMax}&totalMin=${totalMin}&totalMax=${totalMax}&sortBy=total&sortOrder=${sortBy == 'total' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Total (Ar) 
                            <c:if test="${sortBy == 'total'}">
                                <span class="sort-indicator">${sortOrder == 'asc' ? '▲' : '▼'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="lot" items="${lots}">
                    <tr>
                        <td>${lot.reference}</td>
                        <td>${lot.date}</td>
                        <td><fmt:formatNumber value="${lot.quantite}" pattern="#,##0.##"/></td>
                        <td><fmt:formatNumber value="${lot.collecte.prixUnitaire}" pattern="#,##0"/></td>
                        <td><fmt:formatNumber value="${lot.prixCollecte}" pattern="#,##0"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/collectes/detail/${lot.idLotPaddy}">
                                Voir détail
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty lots}">
                    <tr>
                        <td colspan="6" style="text-align: center;">Aucun lot enregistré</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

                <%-- Pagination --%>
        <c:if test="${pageTotales > 1}">
            <div>
                <c:if test="${pageCourante > 0}">
                    <a href="${pageContext.request.contextPath}/collectes/liste?page=${pageCourante - 1}">Précédent</a>
                </c:if>
                <%-- Numeros de page --%>
                <c:forEach var="i" begin="0" end="${pageTotales - 1}">
                    <c:choose>
                        <c:when test="${i == pageCourante}">
                            <span>${i + 1}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/collectes/liste?page=${i}">${i + 1}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <span>Page ${pageCourante + 1} sur ${pageTotales}</span>
                <c:if test="${pageCourante < pageTotales - 1}">
                    <a href="${pageContext.request.contextPath}/collectes/liste?page=${pageCourante + 1}">Suivant</a>
                </c:if>
            </div>
        </c:if>

        <br>
        <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/collectes/nouveau'">
            Nouvelle collecte
        </button>
    </section>
</body>
</html>
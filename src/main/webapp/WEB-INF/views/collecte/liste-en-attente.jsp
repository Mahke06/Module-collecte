<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lots en attente</title>
</head>
<body>
    <section>
        <h2>Collecte: Lots en attente de paiement</h2>

        <div>
            <a href="${pageContext.request.contextPath}/collectes/valides">→ Voir les lots validés</a>
        </div>


        <form action="${pageContext.request.contextPath}/collectes/en-attente" method="get">
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



        <br>

        <div>
            <p><strong>Quantité totale :</strong>
                <fmt:formatNumber value="${quantiteTotale}" pattern="#,##0.##"/> kg
            </p>
            <p><strong>Recette totale :</strong>
                <fmt:formatNumber value="${recetteTotale}" pattern="#,##0"/> Ar
            </p>
        </div>

        <br>

        <table border="1">
            <thead>
                <tr>
                    <th>Référence</th>
                    <th>Date</th>
                    <th>Quantité (kg)</th>
                    <th>Prix unitaire (Ar)</th>
                    <th>Total (Ar)</th>
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
                        <td colspan="6" style="text-align: center;">Aucun lot en attente</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <br>
        <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/collectes/nouveau'">
            Nouvelle collecte
        </button>
    </section>
</body>
</html>
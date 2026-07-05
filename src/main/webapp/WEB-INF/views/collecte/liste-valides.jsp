<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lots validés</title>
</head>
<body>
    <section>
        <h2>Collecte: Lots validés et payés</h2>

        <div>
            <a href="${pageContext.request.contextPath}/collectes/en-attente">→ Voir les lots en attente</a>
        </div>

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
                        <td colspan="6" style="text-align: center;">Aucun lot validé</td>
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
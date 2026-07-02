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
                        <td colspan="6" style="text-align: center;">Aucun lot enregistré</td>
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
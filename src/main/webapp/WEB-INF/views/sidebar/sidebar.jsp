<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="sidebarUserName" value="${empty sidebarUserName ? 'Administrateur' : sidebarUserName}" />
<c:set var="sidebarUserRole" value="${empty sidebarUserRole ? 'Administrateur' : sidebarUserRole}" />
<c:set var="sidebarInitials" value="${empty sidebarInitials ? 'AD' : sidebarInitials}" />
<c:set var="requestUri" value="${pageContext.request.requestURI}" />
<c:set var="dashboardActive" value="${fn:contains(requestUri, '/dashboard')}" />
<c:set var="collecteActive" value="${fn:contains(requestUri, '/collectes')}" />

<aside class="sidebar">
	<div class="sidebar-brand">
		<svg class="logo-mark" viewBox="0 0 32 32" fill="none"><rect width="32" height="32" rx="8" fill="#2563EB"/><path d="M9 11l7 12 7-12" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
		<span class="logo-text">VOLY VARY</span>
	</div>
	<div class="sidebar-user"Local>
		<div class="avatar"><c:out value="${sidebarInitials}" /></div>
		<div class="who"><strong><c:out value="${sidebarUserName}" /></strong><span><c:out value="${sidebarUserRole}" /></span></div>
	</div>
	<nav class="sidebar-nav">
		<a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link ${dashboardActive ? 'active' : ''}">
			<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="9" rx="1.5"/><rect x="14" y="3" width="7" height="5" rx="1.5"/><rect x="14" y="12" width="7" height="9" rx="1.5"/><rect x="3" y="16" width="7" height="5" rx="1.5"/></svg>
			<span>Dashboard</span>
		</a>
		<a href="${pageContext.request.contextPath}/collectes/valides" class="sidebar-link ${collecteActive ? 'active' : ''}">
			<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/></svg>
			<span>Collecte</span>
		</a>
	</nav>
	<div class="sidebar-footer">
		<button class="sidebar-toggle" id="btn-collapse" type="button">
			<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:14px;height:14px"><path d="M15 18l-6-6 6-6"/></svg>
			<span id="collapse-label">Reduire</span>
		</button>
	</div>
</aside>

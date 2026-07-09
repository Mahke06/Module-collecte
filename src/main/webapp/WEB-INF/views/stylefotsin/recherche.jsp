<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

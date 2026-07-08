# VOLY VARY - Front-end

Front-end HTML5 / CSS3 / JS ES6 (sans framework), pret a etre connecte a Spring Boot + PostgreSQL.

## Lancer le projet

Ouvrir `pages/login/index.html` via un serveur local (Live Server, `python -m http.server`, etc.) ou directement `index.html` a la racine.
Aucune inscription requise pour tester : n'importe quel email/mot de passe + un role dans la liste suffisent (session simulee via `sessionStorage`).

## Architecture

```
assets/
  css/       variables.css (design tokens), base.css (reset+layout), components.css (sidebar, header, table, modale, toast...)
  js/        auth.js (roles + garde d'acces), sidebar.js (rendu menu dynamique), datatable.js (table generique),
             modal.js, toast.js, export.js (CSV/PDF cote client)
pages/
  login/            transaction/       collecte/         transformation/
  distribution/     statistiques/      dashboard/         profil/
  admin/fournitures  admin/livreurs   admin/utilisateurs  admin/configuration
```

Chaque page = `index.html` + `style.css` + `script.js`.

## Systeme de roles

`assets/js/auth.js` definit `ROLE_PAGES` : la liste des pages autorisees par role.
`guardPage(pageId)` est appele en tete de chaque `script.js` de page protegee (via `renderShell(pageId)`) :
- redirige vers le login si personne n'est connecte,
- redirige vers le dashboard si le role n'a pas acces a la page (empeche l'acces direct par URL).

Le menu lateral (`sidebar.js`) se reconstruit dynamiquement selon `ROLE_PAGES[user.role]`.

## Composant DataTable (pagination / recherche / tri / filtres)

Toutes les listes utilisent `assets/js/datatable.js` :
```js
new DataTable({
  container, columns, data, pageSize,
  searchKeys, filters, actions,
  onAdd, onExportExcel, onExportPdf, onImportExcel,
});
```
Recherche multicritere, tri par colonne (clic sur l'en-tete), filtres par select, pagination automatique.

## Connexion au backend Spring Boot

Points a brancher (marques par des commentaires `// a remplacer par ...`) :
- `auth.js` -> `login()` : remplacer par `POST /api/auth/login`
- chaque `script.js` de module -> remplacer le tableau `items`/`distributions`/etc. par un `fetch()` vers l'API correspondante (`GET /api/distributions`, `POST`, `PUT`, `DELETE`)
- `export.js` -> `exportToExcel`/`exportToPdf` fonctionnent cote client (CSV + impression) ; peuvent etre remplaces par des endpoints backend `/export/pdf` et `/export/excel` si un format natif est requis
- `onImportExcel` (module Fournitures) ouvre un `<input type="file">` : a connecter a un endpoint d'import

## Notes

- Palette et regles de style suivent strictement le cahier des charges (bleu #2563EB, vert #16A34A, rouge, jaune).
- Chart.js charge via CDN (cdnjs) pour les graphiques (Dashboard + Statistiques).
- Les livreurs n'ont pas de compte : CRUD Livreurs accessible uniquement par l'Administrateur, aucune page de connexion associee.
- Responsive : sidebar en tiroir sous 1024px, grilles en colonne unique sous 640px.

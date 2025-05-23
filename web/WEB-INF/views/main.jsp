<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Artículos</title>
    <link href="css/principal.css" rel="stylesheet"/>
</head>
<body>

    <!-- ? Header general -->
<header class="header-principal">
    <nav class="nav-principal">
        <ul>
            <li><a href="/AcmeNoticias/home">Menú</a></li>
            <li><a href="/AcmeNoticias/perfil">Perfil</a></li>
            <li><a href="/AcmeNoticias/logout">Cerrar sesión</a></li>
        </ul>
    </nav>
</header>

<!-- ? Filtro de categorías -->
<section class="filtro-categorias">
    <form action="/AcmeNoticias/filtrarArticulos" method="get">
        <label for="categoria">Categoría:</label>
        <select name="categoria" id="categoria">
            <option value="">Todas</option>
            <option value="Backend">Backend</option>
            <option value="Frontend">Frontend</option>
            <option value="Diseño">Diseño</option>
            <option value="DevOps">DevOps</option>
        </select>
        <button type="submit">Filtrar</button>
    </form>
</section>

    <!-- ? Contenedor de artículos -->
<div class="tarjetas-articulos-container">
    <c:choose>
        <c:when test="${not empty articles}">
            <c:forEach var="article" items="${articles}">
                <div class="tarjeta-articulo">
                    <div class="cabecera-articulo">
                        <h3 class="titulo-articulo">${article.titulo}</h3>
                        <div class="meta-articulo">
                            <span class="autor-articulo">Autor: ${article.autor.nickname}</span>
                            <span class="categoria-articulo"> | Categoría: ${article.categoria}</span>
                        </div>
                    </div>
                    <div class="cuerpo-articulo">
                        <p class="fragmento-articulo">
                            ${fn:substring(article.texto, 0, 300)}...
                        </p>
                        <a href="verArticulo/${article.id}" class="leer-mas">Leer más</a>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="sin-articulos">No hay artículos disponibles en este momento.</p>
        </c:otherwise>
    </c:choose>
</div>


</body>
</html>
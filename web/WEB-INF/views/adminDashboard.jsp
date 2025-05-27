<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Administrador</title>
    <link rel="stylesheet" type="text/css" href="./VistaArticuloStyle.css">
</head>
<jsp:include page="common/header.jsp"/>
<body>

<header class="header-principal">
    <nav class="nav-principal">
        <ul>
            <li><a href="/HeroKeeper/home">Men�</a></li>
            <li><a href="/HeroKeeper/perfil">Perfil</a></li>
            <li><a href="/HeroKeeper/logout">Cerrar sesi�n</a></li>
        </ul>
    </nav>
</header>

<!-- ? Estad�sticas generales -->
<section class="dashboard-estadisticas">
    <h2>Estad�sticas Generales</h2>
    <p><strong>Media de comentarios por art�culo:</strong> ${mediaComentarios}</p>
</section>

<!-- ? Top Art�culos -->
<section class="dashboard-top-articulos">
    <h2>Top 5 Art�culos con M�s Comentarios</h2>
    <div class="tarjetas-articulos-container">
        <c:forEach var="article" items="${topArticulos}">
            <div class="tarjeta-articulo">
                <div class="cabecera-articulo">
                    <h3 class="titulo-articulo">${article.titulo}</h3>
                    <div class="meta-articulo">
                        <span class="autor-articulo">Autor: ${article.autor.nickname}</span>
                        <span class="categoria-articulo"> | Comentarios: ${article.numeroComentarios}</span>
                    </div>
                </div>
                <div class="cuerpo-articulo">
                    <p class="fragmento-articulo">
                        ${fn:substring(article.texto, 0, 300)}...
                    </p>
                    <a href="verArticulo/${article.id}" class="leer-mas">Leer m�s</a>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

</body>
</html>
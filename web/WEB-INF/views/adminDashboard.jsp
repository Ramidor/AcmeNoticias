<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Administrador</title>
    <link href="${pageContext.request.contextPath}/css/principal.css" rel="stylesheet"/>
</head>

<body>

<jsp:include page="common/header.jsp"/>

<!-- ? Estadísticas generales -->
<section class="dashboard-estadisticas">
    <h2>Estadísticas Generales</h2>
    <p><strong>Media de comentarios por artículo:</strong> ${mediaComentarios}</p>
</section>

<!-- ? Top Artículos -->
<section class="dashboard-top-articulos">
    <h2>Top 5 Artículos con Más Comentarios</h2>
    <div class="tarjetas-articulos-container">
        <c:forEach var="articulo" items="${topArticulos}">
            <div class="tarjeta-articulo">
                <div class="cabecera-articulo">
                    <h3 class="titulo-articulo">${articulo.titulo}</h3>
                    <div class="meta-articulo">
                        <span class="autor-articulo">Autor: ${articulo.autor.nombre}</span>
                        <span class="categoria-articulo"> | Categoria: ${articulo.categoria.tipoCategoria}</span>
                    </div>
                </div>
                <div class="cuerpo-articulo">
                    <p class="fragmento-articulo">
                        ${fn:substring(articulo.cuerpo, 0, 300)}...
                    </p>
                    <a href="verArticulo/${articulo.id}" class="leer-mas">Leer más</a>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

</body>
</html>
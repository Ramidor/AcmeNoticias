<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mis articulos</title>
    <link href="${pageContext.request.contextPath}/css/principal.css" rel="stylesheet"/>
</head>
<body>

<%@include file="common/header.jsp" %>

<div class="tarjetas-articulos-container">
    <c:choose>
        <c:when test="${not empty articulos}">
            <c:forEach var="articulo" items="${articulos}">
                <div class="tarjeta-articulo">
                    <div class="cabecera-articulo">
                        <h3 class="titulo-articulo">${articulo.titulo}</h3>
                        <div class="meta-articulo">
                            <span class="autor-articulo">Autor: ${articulo.autor.nombre}</span>
                            <span class="categoria-articulo"> | Categoría: ${articulo.categoria.tipoCategoria}</span>
                        </div>
                    </div>

                    <div class="contenido-articulo" style="display: flex; justify-content: space-between; align-items: center;">
                        <div class="cuerpo-articulo" style="flex: 1;">
                            <p class="fragmento-articulo">
                                ${fn:substring(articulo.cuerpo, 0, 300)}...
                            </p>
                            <a href="${pageContext.request.contextPath}/verArticulo/${articulo.id}" class="leer-mas">Leer más</a>
                        </div>

                        <div class="acciones-articulo" style="text-align: right; margin-left: 20px;">
                            <a href="${pageContext.request.contextPath}/editarArticulo/${articulo.id}" class="btn-editar">Editar</a>

                            <form action="${pageContext.request.contextPath}/eliminarArticulo" method="post" style="display:inline;">
                                <input type="hidden" name="articuloId" value="${articulo.id}" />
                                <button type="submit" class="btn-eliminar" onclick="return confirm('¿Estás seguro de que deseas eliminar este artículo?');">Eliminar</button>
                            </form>
                        </div>
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
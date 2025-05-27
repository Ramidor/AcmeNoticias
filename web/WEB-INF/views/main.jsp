<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Art�culos</title>
    <link href="css/principal.css" rel="stylesheet"/>
</head>
<body>

<!-- ? Header general -->
<%@include file="common/header.jsp" %>

<!-- ? Filtro de categor�as -->
<section class="filtro-categorias">
    <form action="/AcmeNoticias/filtrarArticulos" method="get">
        <label for="categoria">Categor�a:</label>
        <select id="categoria" name="categoria" required>
                    <option value="">-- Selecciona una categor�a --</option>
                    <%
                        List<String> categorias = (List<String>) request.getAttribute("Categorias");
                        if (categorias != null) {
                            for (String categoria : categorias) {
                    %>
                    <option value="<%= categoria%>"><%= categoria%></option>
                    <%
                            }
                        }
                    %>
        </select>
        <button type="submit">Filtrar</button>
    </form>
</section>

    <!-- ? Contenedor de art�culos -->
<div class="tarjetas-articulos-container">
    <c:choose>
        <c:when test="${not empty articulos}">
            <c:forEach var="articulo" items="${articulos}">
                <div class="tarjeta-articulo">
                    <div class="cabecera-articulo">
                        <h3 class="titulo-articulo">${articulo.titulo}</h3>
                        <div class="meta-articulo">
                            <span class="autor-articulo">Autor: ${articulo.autor.nombre}</span>
                            <span class="categoria-articulo"> | Categor�a: ${articulo.categoria.tipoCategoria}</span>
                        </div>
                    </div>
                    <div class="cuerpo-articulo">
                        <p class="fragmento-articulo">
                            ${fn:substring(articulo.cuerpo, 0, 300)}...
                        </p>
                        <a href="verArticulo/${articulo.id}" class="leer-mas">Leer m�s</a>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="sin-articulos">No hay art�culos disponibles en este momento.</p>
        </c:otherwise>
    </c:choose>
</div>


</body>
</html>
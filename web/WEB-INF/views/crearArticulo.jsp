<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title><c:out value="${articulo != null ? 'Editar Art�culo' : 'Crear Art�culo'}"/></title>
        <link href="${pageContext.request.contextPath}/css/principal.css" rel="stylesheet"/>
    </head>
    <body>

        <%@include file="common/header.jsp" %>

        <div class="crear-articulo-container">
            <h1><c:out value="${articulo != null ? 'Editar Art�culo' : 'Crear nuevo art�culo'}"/></h1>

            <form class="form-crear-articulo"
                  action="<c:out value='${pageContext.request.contextPath}${articulo != null ? "/editarArticulo/save" : "/crearArticulo/save"}'/>"
                  method="post">

                <c:if test="${articulo != null}">
                    <input type="hidden" name="articuloId" value="${articulo.id}" />
                </c:if>

                <label for="titulo">T�tulo del art�culo:</label>
                <input type="text" id="titulo" name="titulo" required value="<c:out value='${articulo != null ? articulo.titulo : ""}'/>" />

                <label for="categoria">Categor�a:</label>
                <select id="categoria" name="categoria" required>
                    <option value="">-- Selecciona una categor�a --</option>
                    <c:forEach var="cat" items="${Categorias}">
                        <option value="${cat.tipoCategoria}"
                                <c:if test="${articulo != null && articulo.categoria.tipoCategoria == cat.tipoCategoria}">selected</c:if>>
                            ${cat.tipoCategoria}
                        </option>
                    </c:forEach>
                </select>

                <label for="texto">Texto del art�culo:</label>
                <textarea id="texto" name="texto" rows="10" required><c:out value="${articulo != null ? articulo.cuerpo : ''}"/></textarea>
                <label>
                    <input type="checkbox" name="comentariosHabilitados" ${articulo.comentariosHabilitados ? "checked" : ""} />
                    Habilitar comentarios
                </label>

                <button type="submit"><c:out value="${articulo != null ? 'Guardar Cambios' : 'Publicar art�culo'}"/></button>
            </form>
        </div>

    </body>
</html>

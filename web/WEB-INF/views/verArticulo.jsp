<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <title>${articulo.titulo}</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/principal.css" />
    </head>
    <body>
        <%@include file="common/header.jsp" %>
        <div class="detalle-articulo-container">
            <h1 class="titulo-articulo">${articulo.titulo}</h1>

            <div class="meta-articulo">
                <span>Autor: ${articulo.autor.nombre}</span>
                <span>Categoría: ${articulo.categoria.tipoCategoria}</span>
            </div>

            <div class="texto-articulo">
                <p>${articulo.cuerpo}</p>
            </div>

            <a href="AcmeNoticias/inicio" class="volver-enlace">↩ Volver a artículos</a>
        </div>

        <div class="comentarios-articulo">
            <h2>Comentarios</h2>

            <c:choose>
                <c:when test="${not empty articulo.comentario}">
                    <c:forEach var="comentario" items="${articulo.comentario}">
                        <div class="comentario">
                            <p class="comentario-autor">${comentario.autor}</p>
                            <p class="comentario-texto">${comentario.texto}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No hay comentarios aún.</p>
                </c:otherwise>
            </c:choose>

            <!-- Formulario para añadir comentario -->
            <form class="formulario-comentario" action="${pageContext.request.contextPath}/agregarComentario" method="post">
                <input type="hidden" name="articuloId" value="${articulo.id}" />
                <label for="comentario">Añadir comentario:</label>
                <textarea id="comentario" name="comentarioTexto" rows="4" placeholder="Escribe tu comentario aquí..." required></textarea>
                <button type="submit">Publicar</button>
            </form>
        </div>
    </body>
</html>

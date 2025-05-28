<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <title>${articulo.titulo}</title>
        <link href="${pageContext.request.contextPath}/css/principal.css" rel="stylesheet"/>
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
                ${articulo.cuerpo}
            </div>

            <div class="acciones-articulo" style="margin-bottom: 30px;">
                <a href="/AcmeNoticias/inicio" class="volver-enlace">Volver a artículos</a>

                <c:if test="${sessionScope.email != null && sessionScope.rol == 'ADMIN'}">
                    <form action="/AcmeNoticias/editarArticulo" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="${articulo.id}" />
                        <button type="submit" class="btn-editar">Editar</button>
                    </form>

                    <form action="/AcmeNoticias/eliminarArticulo" method="post" style="display:inline;" onsubmit="return confirm('¿Seguro que quieres eliminar este artículo?');">
                        <input type="hidden" name="id" value="${articulo.id}" />
                        <button type="submit" class="btn-eliminar">Eliminar</button>
                    </form>
                </c:if>
            </div>
        </div>
        <c:if test="${articulo.comentariosHabilitados}">
            <div class="comentarios-articulo">
                <h2>Comentarios</h2>
                <c:choose>
                    <c:when test="${not empty articulo.comentario}">
                        <c:forEach var="comentario" items="${articulo.comentario}">
                            <div class="comentario">
                                <p class="comentario-autor">${comentario.autor}</p>
                                <p class="comentario-texto">${comentario.texto}</p>
                            </div>

                            <c:if test="${sessionScope.email != null && (sessionScope.rol == 'ADMIN' || sessionScope.id == articulo.autor.id)}">
                                <form action="/AcmeNoticias/editarComentario" method="get" style="display:inline;">
                                    <input type="hidden" name="comentarioId" value="${comentario.id}" />
                                    <button type="submit" class="btn-editar">Editar</button>
                                </form>

                                <form action="/AcmeNoticias/eliminarComentario" method="post" style="display:inline;" onsubmit="return confirm('¿Seguro que quieres eliminar este comentario?');">
                                    <input type="hidden" name="comentarioId" value="${comentario.id}" />
                                    <button type="submit" class="btn-eliminar">Eliminar</button>
                                </form>
                            </c:if>
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
            </c:if>

            <c:if test="${!articulo.comentariosHabilitados}">
                <p class="comentarios-desactivados">Los comentarios están desactivados para este artículo.</p>
            </c:if>
        </div>


    </body>
</html>
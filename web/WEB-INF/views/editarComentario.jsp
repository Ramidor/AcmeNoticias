<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Comentario</title>
    <link href="${pageContext.request.contextPath}/css/principal.css" rel="stylesheet"/>
</head>
<body class="editar-comentario-page">
<%@include file="common/header.jsp" %>


<div class="editar-comentario-container">
    <h1>Editar Comentario</h1>

    <form action="/AcmeNoticias/editarComentario" method="post" class="form-editar-comentario">
        <input type="hidden" name="comentarioId" value="${comentario.id}" />

        <label for="contenido">Contenido:</label>
        <textarea id="contenido" name="contenido" rows="5" required>${comentario.texto}</textarea>

        <div class="acciones-form">
            <button type="submit" class="btn-guardar">Guardar cambios</button>
            <a href="/AcmeNoticias/verArticulo/${comentario.articulo.id}" class="btn-volver">Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
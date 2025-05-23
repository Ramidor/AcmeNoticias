<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Crear Artículo</title>
        <link rel="stylesheet" href="css/principal.css" />
    </head>
    <body>

        <%@include file="common/header.jsp" %>

        <div class="crear-articulo-container">
            <h1>Crear nuevo artículo</h1>

            <form class="form-crear-articulo" action="/AcmeNoticias/crearArticulo" method="post">
                <label for="titulo">Título del artículo:</label>
                <input type="text" id="titulo" name="titulo" required />

                <label for="categoria">Categoría:</label>
                <select id="categoria" name="categoria" required>
                    <option value="">-- Selecciona una categoría --</option>
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
                <label for="texto">Texto del artículo:</label>
                <textarea id="texto" name="texto" rows="10" required></textarea>

                <button type="submit">Publicar artículo</button>
            </form>
        </div>

    </body>
</html>
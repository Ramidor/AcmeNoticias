<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Crear Art�culo</title>
        <link rel="stylesheet" href="css/principal.css" />
    </head>
    <body>

        <%@include file="common/header.jsp" %>

        <div class="crear-articulo-container">
            <h1>Crear nuevo art�culo</h1>

            <form class="form-crear-articulo" action="/AcmeNoticias/crearArticulo" method="post">
                <label for="titulo">T�tulo del art�culo:</label>
                <input type="text" id="titulo" name="titulo" required />

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
                <label for="texto">Texto del art�culo:</label>
                <textarea id="texto" name="texto" rows="10" required></textarea>

                <button type="submit">Publicar art�culo</button>
            </form>
        </div>

    </body>
</html>
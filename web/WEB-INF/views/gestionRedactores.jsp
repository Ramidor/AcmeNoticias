<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <title>Gestión de Usuarios</title>
        <link href="${pageContext.request.contextPath}/css/principal.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="common/header.jsp" %>
        <div class="crud-usuarios-container">
            <h2>Gestión de Usuarios</h2>
                <table class="tabla-usuarios">
                    <thead>
                        <tr>
                            <th>Nombre de usuario</th>
                            <th>Correo</th>
                            <th>Redactor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="usuario" items="${usuarios}">
                            <tr>
                                <td>${usuario.nombre}</td>
                                <td>${usuario.email}</td>
                                <td>
                                    <form action="/AcmeNoticias/eliminarRedactor" method="post" style="display:inline;" onsubmit="return confirm('¿Seguro que quieres eliminar este usuario?');">
                                        <input type="hidden" name="id" value="${usuario.id}" />
                                        <button type="submit" class="btn-eliminar">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
        </div>

    </body>
</html>
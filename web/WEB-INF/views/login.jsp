<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="common/header2.jsp" %>
        <c:if test="${!empty requestScope.msg}">
            <div class="alert alert-warning text-center" role="alert">
                ${requestScope.msg}
            </div>
        </c:if>
        <div class="container mt-5">
            <h1 class="text-center">Bienvenido</h1>
            <p class="text-center text-muted">Por favor, inicie sesión para continuar.</p>
        </div>

        <div class="container d-flex justify-content-center align-items-center" style="min-height: 60vh;">
            <div class="card p-4 shadow-lg" style="width: 400px;">
                <h2 class="text-center mb-4">Iniciar Sesión</h2>

                <form action="/GameStore/login/check" method="POST">
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electrónico</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="usuario@ejemplo.com" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Ingrese su contraseña" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                    </div>
                </form>
            </div>
        </div>

        <%@include file="common/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

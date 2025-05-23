<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <img src="img/logo.png" alt="Logo Noticias Acme" width="60" height="45" class="me-3">
        <a class="navbar-brand mb-0 h1" href="inicio">Noticias Acme</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- Usuario no autenticado -->
                <c:if test="${empty sessionScope.usuario}">
                    <li class="nav-item">
                        <a class="nav-link" href="login">Iniciar Sesión</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="register">Registrarse</a>
                    </li>
                </c:if>

                <!-- Admin -->
                <c:if test="${sessionScope.usuario != null && sessionScope.usuario.rol == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="vistaAdmin.jsp">Panel Admin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="vistaCategorias.jsp">Categorías</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Cerrar sesión</a>
                    </li>
                </c:if>

                <!-- Redactor -->
                <c:if test="${sessionScope.usuario != null && sessionScope.usuario.rol == 'REDACTOR'}">
                    <li class="nav-item">
                        <a class="nav-link" href="crearArticulo.jsp">Nuevo Artículo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="misArticulos.jsp">Mis Artículos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Cerrar sesión</a>
                    </li>
                </c:if>

                <!-- Lector -->
                <c:if test="${sessionScope.usuario != null && sessionScope.usuario.rol == 'LECTOR'}">
                    <li class="nav-item">
                        <a class="nav-link disabled" href="#">${sessionScope.usuario.nombre}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Cerrar sesión</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

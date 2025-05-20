<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <img src="/GameStore/img/logo.png" alt="Logo de GameStore" width="70" height="50" class="me-3">
        <a class="navbar-brand mb-0 h1" href="inicio">Tienda de Videojuegos</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <c:if test="${empty sessionScope.email}">
                    <li class="nav-item">
                        <a class="nav-link" href="login">Iniciar Sesión</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="register">Registrarse</a>
                    </li> 
                </c:if>
                <c:if test="${sessionScope.email != null && sessionScope.rol == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="addVideojuego">Añadir producto</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="deleteVideojuego">Eliminar Producto</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login/logout">Cerrar sesión</a>
                    </li> 
                </c:if>
                <c:if test="${sessionScope.email != null && sessionScope.rol == 'BASIC'}">
                    <li class="nav-item">
                        <a class="nav-link" href="biblioteca">Ver Biblioteca</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="carrito">Ver Carrito</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login/logout">Cerrar sesión</a>
                    </li> 
                </c:if>
            </ul>
        </div>
    </div>
</nav>
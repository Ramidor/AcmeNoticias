<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header class="header-principal">
    <nav class="nav-principal">
        <ul>
            <c:if test="${empty sessionScope.email}">
                    <li class="nav-item">
                        <a class="nav-link" href="login">Iniciar Sesi�n</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="register">Registrarse</a>
                    </li>
                </c:if>

                <!-- Admin -->
                <c:if test="${sessionScope.email != null && sessionScope.rol == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="vistaAdmin.jsp">Panel Admin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="vistaCategorias.jsp">Categor�as</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Cerrar sesi�n</a>
                    </li>
                </c:if>

                <!-- Redactor -->
                <c:if test="${sessionScope.email != null && sessionScope.rol == 'REDACTOR'}">
                    <li class="nav-item">
                        <a class="nav-link" href="crearArticulo.jsp">Nuevo Art�culo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="misArticulos.jsp">Mis Art�culos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Cerrar sesi�n</a>
                    </li>
                </c:if>
        </ul>
    </nav>
</header>
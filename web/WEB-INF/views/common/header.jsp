<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header class="header-principal">
    <nav class="nav-principal">
        <ul>
            <c:if test="${empty sessionScope.email}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">Iniciar Sesi�n</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">Registrarse</a>
                    </li>
                </c:if>

                <!-- Admin -->
                <c:if test="${sessionScope.email != null && sessionScope.rol == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/gestionRedactores">Gesti�n Redactores</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/gestionCategorias">Gesti�n Categor�as</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/gestionArticulos">Gesti�n Articulos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashBoard">DashBoard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login/logout">Cerrar sesi�n</a>
                    </li>
                </c:if>

                <!-- Redactor -->
                <c:if test="${sessionScope.email != null && sessionScope.rol == 'REDACTOR'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/crearArticulo">Nuevo Art�culo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/verMisArticulos">Mis Art�culos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login/logout">Cerrar sesi�n</a>
                    </li>
                </c:if>
        </ul>
    </nav>
</header>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gesti�n de Categor�as</title>
    <link href="${pageContext.request.contextPath}/css/principal.css" rel="stylesheet"/>
    <script>
        function confirmarEliminacion(nombre) {
            return confirm("�Est�s seguro de que quieres eliminar la categor�a '" + nombre + "'?");
        }

        function mostrarFormularioEdicion(id, nombre) {
            document.getElementById("form-editar-id").value = id;
            document.getElementById("form-editar-nombre").value = nombre;
            document.getElementById("editar-modal").style.display = "flex";
        }

        function cerrarModal() {
            document.getElementById("editar-modal").style.display = "none";
        }
    </script>
</head>
<body>
<%@include file="common/header.jsp" %>
<div class="crud-categorias-container">
    <h2>Gesti�n de Categor�as</h2>

    <table class="tabla-categorias">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="categoria" items="${categorias}">
                <tr>
                    <td>${categoria.tipoCategoria}</td>
                    <td>
                        <button class="btn-editar" type="button"
                                onclick="mostrarFormularioEdicion('${categoria.id}', '${categoria.tipoCategoria}')">
                            Editar
                        </button>
                        <form action="/AcmeNoticias/eliminarCategoria" method="post" style="display:inline;"
                              onsubmit="return confirmarEliminacion('${categoria.tipoCategoria}')">
                            <input type="hidden" name="id" value="${categoria.id}" />
                            <button type="submit" class="btn-eliminar">Eliminar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="agregar-categoria">
        <form action="/AcmeNoticias/crearCategoria" method="post">
            <input type="text" name="nombre" placeholder="Nueva categor�a" required />
            <button type="submit" class="btn-agregar">A�adir categor�a</button>
        </form>
    </div>
</div>

<!-- Modal de edici�n -->
<div id="editar-modal">
    <div class="modal-content">
        <h3>Editar Categor�a</h3>
        <form action="/AcmeNoticias/editarCategoria" method="post">
            <input type="hidden" id="form-editar-id" name="id" />
            <input type="text" id="form-editar-nombre" name="nombre" required />
            <div class="modal-buttons">
                <button type="submit" class="btn-editar">Guardar</button>
                <button type="button" class="btn-eliminar" onclick="cerrarModal()">Cancelar</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
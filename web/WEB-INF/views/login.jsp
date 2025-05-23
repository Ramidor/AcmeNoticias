<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <title>Iniciar Sesión</title>
        <style>
            /* Usamos la misma paleta de colores */
            :root {
                --color-fondo: #F5F5F5;
                --color-principal-claro: #48CFCB;
                --color-principal-oscuro: #229799;
                --color-texto: #424242;
                --color-tarjeta: #ffffff;
                --color-titulo: #229799;
                --color-enlace: #48CFCB;
                --color-enlace-hover: #229799;
            }

            body {
                background-color: var(--color-fondo);
                color: var(--color-texto);
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .login-container {
                background-color: var(--color-tarjeta);
                padding: 30px 40px;
                border-radius: 10px;
                box-shadow: 0 6px 15px rgba(0,0,0,0.1);
                width: 350px;
                text-align: center;
            }

            .login-container h2 {
                color: var(--color-titulo);
                margin-bottom: 25px;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            label {
                font-weight: 600;
                text-align: left;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="password"] {
                padding: 10px 12px;
                border: 1.5px solid var(--color-principal-claro);
                border-radius: 6px;
                font-size: 1em;
                color: var(--color-texto);
                transition: border-color 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                border-color: var(--color-principal-oscuro);
                outline: none;
            }

            button {
                background-color: var(--color-principal-claro);
                color: white;
                font-weight: 700;
                padding: 12px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 1.1em;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: var(--color-principal-oscuro);
            }

            .error-message {
                color: #d9534f;
                margin-top: 10px;
                font-weight: 600;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Iniciar Sesión</h2>
            <form action="/AcmeNoticias/login/check" method="post">
                <label for="email">Correo electrónico</label>
                <input type="email" id="email" name="email" required autofocus />

                <label for="password">Contraseña</label>
                <input type="password" id="password" name="password" required />

                <button type="submit">Entrar</button>


                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
            </form>
        </div>

    </body>
</html>
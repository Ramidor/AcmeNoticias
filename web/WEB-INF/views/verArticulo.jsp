<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>${article.titulo}</title>
    <link href="css/principal.css" rel="stylesheet"/>
</head>
<body>

    <header class="header-principal">
        <nav class="nav-principal">
            <ul>
                <li><a href="/AcmeNoticias/inicio">Menú</a></li>
                <li><a href="/AcmeNoticias/perfil">Perfil</a></li>
                <li><a href="/AcmeNoticias/logout">Cerrar sesión</a></li>
            </ul>
        </nav>
    </header>

    <div class="detalle-articulo-container">
        <h1 class="titulo-articulo">El legado de los guardianes del bosque</h1>

        <div class="meta-articulo">
            <span>Autor: Clara Mendoza</span>
            <span>Categoría: Naturaleza</span>
        </div>

        <div class="texto-articulo">
            Durante siglos, los Guardianes del Bosque han protegido los senderos ocultos entre los árboles milenarios del Valle Sombrío. 
            Su conocimiento ancestral, transmitido de generación en generación, ha servido como guía para mantener el equilibrio entre el 
            ser humano y la naturaleza.

            En este artículo exploraremos sus orígenes, rituales sagrados, y cómo su legado ha influido en la preservación de uno de los 
            ecosistemas más antiguos del continente.

            Con entrevistas a descendientes directos y registros recuperados de antiguos manuscritos, desvelamos los secretos detrás de sus 
            máscaras de corteza y su profundo respeto por todo lo vivo.

            Prepárate para adentrarte en un mundo donde el susurro del viento entre las hojas aún guarda historias por contar.
        </div>

        <a href="/HeroKeeper/articulos" class="volver-enlace">? Volver a artículos</a>
    </div>

    <div class="comentarios-articulo">
    <h2>Comentarios</h2>

    <div class="comentario">
        <p class="comentario-autor">Lucía Ríos</p>
        <p class="comentario-texto">Qué interesante historia, me encantaría visitar ese bosque algún día.</p>
    </div>

    <div class="comentario">
        <p class="comentario-autor">Marco Sánchez</p>
        <p class="comentario-texto">Los guardianes siempre me parecieron un mito. Gracias por la información tan detallada.</p>
    </div>

    <form class="formulario-comentario" action="#" method="post">
        <label for="comentario">Añadir comentario:</label>
        <textarea id="comentario" name="comentario" rows="4" placeholder="Escribe tu comentario aquí..."></textarea>
        <button type="submit">Publicar</button>
    </form>
</div>


</body>
</html>
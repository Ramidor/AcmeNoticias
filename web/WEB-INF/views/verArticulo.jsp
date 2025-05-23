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
                <li><a href="/AcmeNoticias/inicio">Men�</a></li>
                <li><a href="/AcmeNoticias/perfil">Perfil</a></li>
                <li><a href="/AcmeNoticias/logout">Cerrar sesi�n</a></li>
            </ul>
        </nav>
    </header>

    <div class="detalle-articulo-container">
        <h1 class="titulo-articulo">El legado de los guardianes del bosque</h1>

        <div class="meta-articulo">
            <span>Autor: Clara Mendoza</span>
            <span>Categor�a: Naturaleza</span>
        </div>

        <div class="texto-articulo">
            Durante siglos, los Guardianes del Bosque han protegido los senderos ocultos entre los �rboles milenarios del Valle Sombr�o. 
            Su conocimiento ancestral, transmitido de generaci�n en generaci�n, ha servido como gu�a para mantener el equilibrio entre el 
            ser humano y la naturaleza.

            En este art�culo exploraremos sus or�genes, rituales sagrados, y c�mo su legado ha influido en la preservaci�n de uno de los 
            ecosistemas m�s antiguos del continente.

            Con entrevistas a descendientes directos y registros recuperados de antiguos manuscritos, desvelamos los secretos detr�s de sus 
            m�scaras de corteza y su profundo respeto por todo lo vivo.

            Prep�rate para adentrarte en un mundo donde el susurro del viento entre las hojas a�n guarda historias por contar.
        </div>

        <a href="/HeroKeeper/articulos" class="volver-enlace">? Volver a art�culos</a>
    </div>

    <div class="comentarios-articulo">
    <h2>Comentarios</h2>

    <div class="comentario">
        <p class="comentario-autor">Luc�a R�os</p>
        <p class="comentario-texto">Qu� interesante historia, me encantar�a visitar ese bosque alg�n d�a.</p>
    </div>

    <div class="comentario">
        <p class="comentario-autor">Marco S�nchez</p>
        <p class="comentario-texto">Los guardianes siempre me parecieron un mito. Gracias por la informaci�n tan detallada.</p>
    </div>

    <form class="formulario-comentario" action="#" method="post">
        <label for="comentario">A�adir comentario:</label>
        <textarea id="comentario" name="comentario" rows="4" placeholder="Escribe tu comentario aqu�..."></textarea>
        <button type="submit">Publicar</button>
    </form>
</div>


</body>
</html>
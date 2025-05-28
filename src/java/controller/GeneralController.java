/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.UserTransaction;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Articulo;
import model.Categoria;
import model.Comentario;
import model.Usuario;

/**
 *
 * @author raulp
 */
@WebServlet(name = "GeneralController", urlPatterns = {"/verArticulo/*", "/verMisArticulos", "/crearArticulo/*",
    "/inicio", "/filtrarArticulos", "/agregarComentario", "/editarArticulo/*", "/eliminarArticulo"})
public class GeneralController extends HttpServlet {

    @PersistenceContext(unitName = "AcmeNoticiasPU")
    private EntityManager em;

    @Resource
    private UserTransaction utx;
    private static final Logger Log = Logger.getLogger(LoginController.class.getName());

    private String localhost = "localhost:8080";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vista = "";

        String accion = request.getServletPath();
        String info = request.getPathInfo();
        HttpSession session = request.getSession();
        List<Categoria> categorias;
        List<Articulo> articulos;
        switch (accion) {
            case "/inicio":

                TypedQuery<Articulo> queryArticulo = em.createNamedQuery("Articulo.findAll", Articulo.class);
                articulos = queryArticulo.getResultList();
                request.setAttribute("articulos", articulos);
                TypedQuery<Categoria> queryCategoria = em.createNamedQuery("Categoria.findTipo", Categoria.class);
                categorias = queryCategoria.getResultList();
                request.setAttribute("Categorias", categorias);
                vista = "main";
                break;
            case "/filtrarArticulos":
                String categoriaSeleccionada = request.getParameter("categoria");

                if (categoriaSeleccionada == null || categoriaSeleccionada.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/inicio");
                    return;
                }
                queryCategoria = em.createNamedQuery("Categoria.findTipo", Categoria.class);
                categorias = queryCategoria.getResultList();
                request.setAttribute("Categorias", categorias);

                queryArticulo = em.createNamedQuery("Articulo.findByCategoria", Articulo.class);
                queryArticulo.setParameter("categoria", categoriaSeleccionada);
                articulos = queryArticulo.getResultList();
                request.setAttribute("articulos", articulos);

                vista = "main";
                break;
            case "/verMisArticulos":
                if (session.getAttribute("rol").equals("REDACTOR")) {
                    String email = (String) session.getAttribute("email");
                    TypedQuery<Usuario> queryUsuario = em.createNamedQuery("Usuario.findByEmail", Usuario.class);
                    queryUsuario.setParameter("email", email);

                    queryArticulo = em.createNamedQuery("Articulo.findByAutor", Articulo.class);
                    queryArticulo.setParameter("email", email);
                    articulos = queryArticulo.getResultList();
                    request.setAttribute("articulos", articulos);
                    vista = "misArticulos";
                } else {
                    vista = "error";
                }
                break;
            case "/verArticulo":
                if (info == null || info.equals("/")) {
                    response.sendRedirect(request.getContextPath() + "/inicio");
                    return;
                }
                try {
                    Long id = Long.parseLong(info.substring(1)); // Quita la barra
                    Articulo articulo = em.find(Articulo.class, id);

                    if (articulo == null) {
                        request.setAttribute("error", "Artículo no encontrado");
                        request.getRequestDispatcher("/WEB-INF/vistas/error.jsp").forward(request, response);
                        return;
                    }
                    // Cargar lazy data si aplica (opcional según configuración JPA)
                    articulo.getComentario().size(); // fuerza carga si es lazy

                    request.setAttribute("articulo", articulo);
                    vista = "verArticulo"; // verArticulo.jsp
                } catch (NumberFormatException e) {
                    Log.severe("ID de artículo no válido: " + info);
                    response.sendRedirect(request.getContextPath() + "/inicio");
                }
                break;
            case "/crearArticulo":
                queryCategoria = em.createNamedQuery("Categoria.findAll", Categoria.class);
                categorias = queryCategoria.getResultList();
                request.setAttribute("Categorias", categorias);
                vista = "crearArticulo";
                break;
            case "/editarArticulo":
                if (info == null || info.equals("/")) {
                    response.sendRedirect(request.getContextPath() + "/verMisArticulos");
                    return;
                }
                try {
                    Long id = Long.parseLong(info.substring(1));
                    Articulo articulo = em.find(Articulo.class, id);
                    if (articulo == null) {
                        response.sendRedirect(request.getContextPath() + "/error.jsp");
                        return;
                    }
                    // Solo el autor puede editar
                    HttpSession sesion = request.getSession();
                    String email = (String) sesion.getAttribute("email");
                    String rol = (String) sesion.getAttribute("rol");
                    if (!articulo.getAutor().getEmail().equals(email) && !rol.equals("ADMIN")) {
                        utx.rollback();
                        response.sendRedirect(request.getContextPath() + "/error.jsp");
                        return;
                    }
                    categorias = em.createNamedQuery("Categoria.findAll", Categoria.class).getResultList();
                    request.setAttribute("Categorias", categorias);
                    request.setAttribute("articulo", articulo);
                    vista = "crearArticulo"; // reutiliza la vista
                } catch (Exception e) {
                    Log.severe("Error al cargar artículo para edición: " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/error");
                }
                break;

            default:
                vista = "error";
                break;
        }
        if (!vista.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vista = "";

        String accion = request.getServletPath();
        String info = request.getPathInfo();
        HttpSession session;

        switch (accion) {
            case "/agregarComentario":
                agregarComentario(request, response);
                break;
            case "/crearArticulo":
                if (info.equals("/save")) {
                    String titulo = request.getParameter("titulo");
                    String categoria = request.getParameter("categoria");
                    String texto = request.getParameter("texto");
                    boolean comentariosHabilitados = request.getParameter("comentariosHabilitados") != null;
                    try {
                        utx.begin();

                        Categoria cat;
                        TypedQuery<Categoria> query = em.createNamedQuery("Categoria.findNombre", Categoria.class);
                        query.setParameter("tipo", categoria);
                        cat = query.getSingleResult();

                        LocalDate fechaActual = LocalDate.now();
                        String email = (String) request.getSession().getAttribute("email");

                        Usuario u;
                        TypedQuery<Usuario> query2 = em.createNamedQuery("Usuario.findByEmail", Usuario.class);
                        query2.setParameter("email", email);
                        u = query2.getSingleResult();
                        Articulo a = new Articulo(titulo, texto, cat, fechaActual.toString(), u, comentariosHabilitados);

                        em.persist(a);

                        u.getArticulo().add(a);
                        em.merge(u);

                        cat.getArticulo().add(a);
                        em.merge(cat);

                        utx.commit();
                        response.sendRedirect("http://" + localhost + "/AcmeNoticias/inicio");
                    } catch (Exception e) {
                        try {
                            // Si hay un error, hacer rollback de la transacción
                            if (utx != null) {
                                utx.rollback();
                            }
                        } catch (Exception rollbackException) {
                            e.printStackTrace();
                        }
                        response.getWriter().write("error: Hubo un problema al crear la partida: " + e.getMessage());
                    } finally {
                        response.getWriter().close();
                    }
                } else {
                    vista = "error";
                }

                break;
            case "/editarArticulo":
                if (info != null && info.equals("/save")) {
                    try {
                        Long id = Long.parseLong(request.getParameter("articuloId"));
                        String titulo = request.getParameter("titulo");
                        String cuerpo = request.getParameter("texto");
                        String categoriaNombre = request.getParameter("categoria");

                        utx.begin();
                        Articulo articulo = em.find(Articulo.class, id);

                        // Verifica permisos
                        String email = (String) request.getSession().getAttribute("email");
                        String rol = (String) request.getSession().getAttribute("rol");
                        if (!articulo.getAutor().getEmail().equals(email) && !rol.equals("ADMIN")) {
                            utx.rollback();
                            response.sendRedirect(request.getContextPath() + "/error.jsp");
                            return;
                        }

                        // Buscar la nueva categoría si cambió
                        Categoria nuevaCategoria = em.createNamedQuery("Categoria.findNombre", Categoria.class)
                                .setParameter("tipo", categoriaNombre)
                                .getSingleResult();

                        articulo.setTitulo(titulo);
                        articulo.setCuerpo(cuerpo);
                        articulo.setCategoria(nuevaCategoria);

                        em.merge(articulo);
                        utx.commit();
                        if (rol.equals("ADMIN")) {
                            response.sendRedirect(request.getContextPath() + "/gestionArticulos");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/verMisArticulos");
                        }
                    } catch (Exception e) {
                        Log.severe("Error al editar artículo: " + e.getMessage());
                        try {
                            utx.rollback();
                        } catch (Exception ex) {
                            Log.severe("Rollback fallido: " + ex.getMessage());
                        }
                        response.sendRedirect(request.getContextPath() + "/error.jsp");
                    }
                }
                break;

            case "/eliminarArticulo":
                try {
                    Long id = Long.parseLong(request.getParameter("articuloId"));
                    utx.begin();
                    Articulo articulo = em.find(Articulo.class, id);

                    // Seguridad: solo el autor puede eliminar
                    String email = (String) request.getSession().getAttribute("email");
                    String rol = (String) request.getSession().getAttribute("rol");
                    if (!articulo.getAutor().getEmail().equals(email) && !rol.equals("ADMIN")) {
                        utx.rollback();
                        response.sendRedirect(request.getContextPath() + "/error.jsp");
                        return;
                    }

                    em.remove(em.merge(articulo));
                    utx.commit();
                    if (rol.equals("ADMIN")) {
                        response.sendRedirect(request.getContextPath() + "/gestionArticulos");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/verMisArticulos");
                    }
                } catch (Exception e) {
                    Log.severe("Error al eliminar artículo: " + e.getMessage());
                    try {
                        utx.rollback();
                    } catch (Exception ex) {
                        Log.severe("Rollback fallido: " + ex.getMessage());
                    }
                    response.sendRedirect(request.getContextPath() + "/error.jsp");
                }
                break;

            default:
                response.sendRedirect("error.jsp");
        }
        if (!vista.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
            rd.forward(request, response);
        }
    }

    private void agregarComentario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long articuloId = Long.parseLong(request.getParameter("articuloId"));
            String texto = request.getParameter("comentarioTexto");

            if (texto == null || texto.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/verArticulo/" + articuloId);
                return;
            }

            Articulo articulo = em.find(Articulo.class, articuloId);
            if (articulo == null) {
                response.sendRedirect(request.getContextPath() + "/inicio");
                return;
            }

            Comentario comentario = new Comentario();
            comentario.setTexto(texto.trim());
            comentario.setFechaPublicacion(java.time.LocalDate.now().toString());
            comentario.setArticulo(articulo);
            String nombre = (String) request.getSession().getAttribute("nombre");
            if (nombre == null) {
                comentario.setAutor("Anónimo"); // O puedes extraerlo del usuario logueado en la sesión
            } else {
                comentario.setAutor(nombre);
            }
            articulo.getComentario().add(comentario);
            utx.begin();
            em.merge(articulo);
            em.persist(comentario);
            utx.commit();

            // Redirigir al mismo artículo luego de comentar
            response.sendRedirect(request.getContextPath() + "/verArticulo/" + articuloId);
        } catch (Exception e) {
            Log.severe("Error al guardar comentario: " + e.getMessage());
            try {
                utx.rollback();
            } catch (Exception rollbackEx) {
                Log.severe("Rollback fallido: " + rollbackEx.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/inicio");
        }
    }
}

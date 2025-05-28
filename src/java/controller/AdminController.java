package controller;

import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.UserTransaction;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import model.Categoria;
import model.Articulo;
import model.Comentario;
import model.Usuario;

@WebServlet(name = "AdminController", urlPatterns = {"/gestionCategorias", "/gestionArticulos",
    "/gestionRedactores", "/editarComentario/*","/eliminarComentario"})
public class AdminController extends HttpServlet {

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
        switch (accion) {
            case "/gestionCategorias":
                TypedQuery<Categoria> queryCategoria = em.createNamedQuery("Categoria.findAll", Categoria.class);
                List<Categoria> categorias = queryCategoria.getResultList();
                request.setAttribute("categorias", categorias);
                vista = "gestionCategorias";
                break;
            case "/gestionArticulos":
                TypedQuery<Articulo> queryArticulo = em.createNamedQuery("Articulo.findAll", Articulo.class);
                List<Articulo> articulos = queryArticulo.getResultList();
                request.setAttribute("articulos", articulos);
                vista = "misArticulos";
                break;
            case "/gestionRedactores":
                TypedQuery<Usuario> queryUsuario = em.createNamedQuery("Usuario.findAll", Usuario.class);
                List<Usuario> usuarios = queryUsuario.getResultList();
                request.setAttribute("usuarios", usuarios);
                vista = "gestionRedactores";
                break;
            case "/editarComentario":
                Long id = Long.parseLong(request.getParameter("comentarioId"));
                Comentario comentario = em.find(Comentario.class, id);
                request.setAttribute("comentario", comentario);
                vista = "editarComentario";
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
        HttpSession session = request.getSession();
        switch (accion) {
            case "/editarComentario":
                try {
                    utx.begin();
                    Long id = Long.parseLong(request.getParameter("comentarioId"));
                    Comentario comentario = em.find(Comentario.class, id);
                    Articulo a = comentario.getArticulo();
                    a.getComentario().remove(comentario);
                    
                    String texto = request.getParameter("contenido");
                    comentario.setTexto(texto);
                    
                    
                    em.persist(comentario);
                    
                    a.getComentario().add(comentario);
                    em.merge(a);
                    utx.commit();
                    response.sendRedirect("http://" + localhost + "/AcmeNoticias/verArticulo/"+a.getId());
                } catch (Exception e) {
                    try {
                        // Si hay un error, hacer rollback de la transacción
                        if (utx != null) {
                            utx.rollback();
                        }
                    } catch (Exception rollbackException) {
                        e.printStackTrace();
                    }
                    response.getWriter().write("error: Hubo un problema al editar Comentario: " + e.getMessage());
                } finally {
                    response.getWriter().close();
                }
                break;
            case "/eliminarComentario":
                try {
                    utx.begin();
                    Long id = Long.parseLong(request.getParameter("comentarioId"));
                    Comentario comentario = em.find(Comentario.class, id);
                    Articulo a = comentario.getArticulo();
                    a.getComentario().remove(comentario);

                    // Seguridad: solo el autor puede eliminar
                    String email = (String) request.getSession().getAttribute("email");
                    String rol = (String) request.getSession().getAttribute("rol");
                    if (!a.getAutor().getEmail().equals(email) && !rol.equals("ADMIN")) {
                        utx.rollback();
                        response.sendRedirect(request.getContextPath() + "/error.jsp");
                        return;
                    }

                    em.remove(em.merge(comentario));
                    utx.commit();
                    response.sendRedirect("http://" + localhost + "/AcmeNoticias/verArticulo/"+a.getId());
                } catch (Exception e) {
                    Log.severe("Error al eliminar comentario: " + e.getMessage());
                    try {
                        utx.rollback();
                    } catch (Exception ex) {
                        Log.severe("Rollback fallido: " + ex.getMessage());
                    }
                    response.sendRedirect(request.getContextPath() + "/error");
                }
                break;

        }

        if (!vista.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
            rd.forward(request, response);
        }
    }
}

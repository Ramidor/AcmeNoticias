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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import model.Articulo;
import model.Categoria;
import model.Comentario;
import model.Usuario;

/**
 *
 * @author raulp
 */
@WebServlet(name = "GeneralController", urlPatterns = {"/verArticulo", "/misArticulos", "/crearArticulo"})
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
        HttpSession session;

        switch (accion) {
            case "/verMisArticulos":
                vista = "misArticulos";
                break;
            case "/verArticulo":
                vista = "verArticulo";
                break;
            case "/crearArticulo":
                List<Categoria> categorias;
                TypedQuery<Categoria> query = em.createNamedQuery("Categoria.findTipo", Categoria.class);
                categorias = query.getResultList();
                request.setAttribute("Categorias", categorias);
                vista = "crearArticulo";
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

        String accion = request.getParameter("accion");

        switch (accion) {
            case "publicarComentario":
                //publicarComentario(request, response);
                break;
            case "crearArticulo":
                //crearArticulo(request, response);
                break;
            case "editarArticulo":
                //editarArticulo(request, response);
                break;
            case "eliminarArticulo":
                //eliminarArticulo(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
        }
    }
/*
    private void verMisArticulos(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        if (usuario == null || !usuario.getRol().equals("redactor")) {
            response.sendRedirect("login.jsp");
            return;
        }

        //TypedQuery<Articulo> query = em.createNamedQuery("Articulo.findByAutor", Articulo.class);
        //request.setAttribute("autor", autor);
        request.getRequestDispatcher("/jsp/mis_articulos.jsp").forward(request, response);
    }

    private void publicarComentario(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String texto = request.getParameter("texto");
        int idArticulo = Integer.parseInt(request.getParameter("idArticulo"));

        Comentario comentario = new Comentario();
        comentario.setAutor(usuario.getNombre());
        comentario.setTexto(texto);
        //comentario.setFechaPublicacion(new Date());
        //comentario.setIdArticulo(idArticulo);

        //ComentarioDAO.insertar(comentario);

        response.sendRedirect("general?accion=verArticulo&id=" + idArticulo);
    }

    private void verArticulo(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        //Articulo articulo = ArticuloDAO.obtenerPorId(id);
        //List<Comentario> comentarios = ComentarioDAO.obtenerPorArticulo(id);

        //request.setAttribute("articulo", articulo);
        //request.setAttribute("comentarios", comentarios);

        request.getRequestDispatcher("/jsp/ver_articulo.jsp").forward(request, response);
    }
*/
    // Métodos editarArticulo, crearArticulo, eliminarArticulo serían similares
}


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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Articulo;
import model.Categoria;
import model.Usuario;
import others.MD5Utils;

/**
 *
 * @author raulp
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login/*", "/register/*"})
public class LoginController extends HttpServlet {

    @PersistenceContext(unitName = "AcmeNoticiasPU")
    private EntityManager em;

    @Resource
    private UserTransaction utx;
    private static final Logger Log = Logger.getLogger(LoginController.class.getName());
    
    private String localhost = "localhost:8080";

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista = "";

        String accion = request.getServletPath();
        String info = request.getPathInfo();
        HttpSession session;
        
        switch (accion) {
            case "/login":
                if (info!=null && info.equals("/logout")) {
                    session = request.getSession();
                    session.invalidate();

                    response.sendRedirect("http://" + localhost + "/AcmeNoticias/inicio");
                } else {
                    vista = "login";
                }
                break;
            case "/register":
                vista = "register";
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista = "";
        String accion = request.getServletPath();
        String info = request.getPathInfo();
        HttpSession session;

        switch (accion) {
            case "/login":
                if (info.equals("/check")) {
                    String email = request.getParameter("email");
                    String password = MD5Utils.encriptar(request.getParameter("password"));
                    try {
                        if (email.isEmpty() || password.isEmpty()) {
                            request.setAttribute("msg", "Error: debe rellenar todos los campos");
                        }
                        Usuario user = comprobarUsuario(email, password);
                        if (user != null) {
                            session = request.getSession();
                            session.setAttribute("email", user.getEmail());
                            session.setAttribute("nombre", user.getNombre());
                            session.setAttribute("rol", user.getRol());
                            session.setAttribute("id", user.getId());

                            response.sendRedirect("http://" + localhost + "/AcmeNoticias/inicio");
                        } else {
                            request.setAttribute("msg", "Error: email o contraseña erroneos");
                            vista = "login";
                        }
                    } catch (NullPointerException e) {
                        Log.log(Level.SEVERE, "exception caught", e.getMessage());
                        vista = "error";
                    }
                }

                break;
            case "/register":
                if (info.equals("/save")) {
                    String nombre = request.getParameter("name");
                    String email = request.getParameter("email");
                    String password = MD5Utils.encriptar(request.getParameter("password"));
                    try {
                        if (nombre.isEmpty() || email.isEmpty() || password.isEmpty()) {
                            request.setAttribute("msg", "Error: debe rellenar todos los campos");
                        }

                        Usuario u = new Usuario(nombre, email, password, "REDACTOR");
                        if (save(u)) {
                            response.sendRedirect("http://" + localhost + "/AcmeNoticias/login");
                        } else {
                            request.setAttribute("msg", "Warning: email ya registrado");
                            vista = "register";
                        }
                    } catch (IOException | NullPointerException e) {
                        Log.log(Level.SEVERE, "exception caught", e.getMessage());
                        vista = "error";
                    }
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

    private Usuario comprobarUsuario(String email, String password) {
        Usuario user = null;
        try {
            TypedQuery<Usuario> query = em.createNamedQuery("Usuario.findByEmailPassword", Usuario.class);
            query.setParameter("email", email);
            query.setParameter("password", password);
            List<Usuario> lista = query.getResultList();

            if (!lista.isEmpty()) {
                user = lista.get(0);
            } else {
                Log.log(Level.INFO, "Usuario error en el inicio de sesion");
            }
        } catch (Exception e) {
            Log.log(Level.SEVERE, "exception caught", e);
            throw new RuntimeException(e);
        }
        return user;
    }

    private boolean save(Usuario u) {
        boolean ok = false;
        try {
            utx.begin();
            TypedQuery<Usuario> query = em.createNamedQuery("Usuario.findByEmail", Usuario.class);
            query.setParameter("email", u.getEmail());

            if (query.getResultList().isEmpty()) {
                em.persist(u);
                Log.log(Level.INFO, "New user saved");
                utx.commit();
                ok = true;
            } else {
                utx.rollback();
                Log.log(Level.INFO, "Intento de registro con email existente");
            }
        } catch (Exception e) {
            Log.log(Level.SEVERE, "exception caught", e);
            throw new RuntimeException(e);
        }
        return ok;
    }
}

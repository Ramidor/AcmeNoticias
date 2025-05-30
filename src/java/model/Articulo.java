/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;

/**
 *
 * @author raulp
 */
@Entity
@Table(name = "articulos")
@NamedQueries({
    @NamedQuery(name = "Articulo.findAll", query = "SELECT a FROM Articulo a"),
    @NamedQuery(name = "Articulo.findByAutor", query = "SELECT a FROM Articulo a WHERE a.autor.email = :email"),
    @NamedQuery(name = "Articulo.findByCategoria", query = "SELECT a FROM Articulo a WHERE a.categoria.tipoCategoria = :categoria")

})
public class Articulo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    private String titulo;
    private String cuerpo;
    private String fechaPublicacion;
    private boolean comentariosHabilitados = true;

    @ManyToOne
    @JoinColumn(name = "categoria_id", nullable = false)
    private Categoria categoria;

    @ManyToOne
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario autor;

    @OneToMany(mappedBy = "articulo", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<Comentario> comentario;

    public Articulo() {
    }

    public Articulo(String titulo, String cuerpo, Categoria categoria, String fechaPublicacion, Usuario autor, boolean comentariosHabilitados) {
        this.titulo = titulo;
        this.cuerpo = cuerpo;
        this.categoria = categoria;
        this.fechaPublicacion = fechaPublicacion;
        this.autor = autor;
        this.comentariosHabilitados = comentariosHabilitados;
    }

    public boolean isComentariosHabilitados() {
        return comentariosHabilitados;
    }

    public void setComentariosHabilitados(boolean comentariosHabilitados) {
        this.comentariosHabilitados = comentariosHabilitados;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Articulo)) {
            return false;
        }
        Articulo other = (Articulo) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Articulo[ id=" + id + " ]";
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getCuerpo() {
        return cuerpo;
    }

    public void setCuerpo(String cuerpo) {
        this.cuerpo = cuerpo;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public String getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(String fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public Usuario getAutor() {
        return autor;
    }

    public void setAutor(Usuario autor) {
        this.autor = autor;
    }

    public List<Comentario> getComentario() {
        return comentario;
    }

    public void setComentario(List<Comentario> comentario) {
        this.comentario = comentario;
    }

}

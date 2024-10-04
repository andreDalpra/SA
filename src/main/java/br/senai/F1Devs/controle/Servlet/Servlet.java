package br.senai.F1Devs.controle.Servlet;

import java.io.IOException;

import br.senai.F1Devs.entidade.Usuario.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Servlet") // Define o servlet para ser acessado em /Servlet
public class Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor padrão do Servlet
    public Servlet() {
        super();
    }

    // Método que instancia o objeto Usuario
    private Usuario instanciarUsuario(HttpServletRequest request) {
        Usuario usu = new Usuario();
        usu.setUsername(request.getParameter("username"));
        usu.setPassword(request.getParameter("password"));
        return usu;
    }

    // Método para tratar requisições POST
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            Usuario usuario = instanciarUsuario(request);

            switch (action) {
                case "logar":
                    if (usuario.autenticarUsuario()) {
                        // Login bem-sucedido, redireciona para a página home
                        response.sendRedirect("home.jsp");
                    } else {
                        // Login falhou, redireciona de volta para a página de login com erro
                        response.sendRedirect("index.jsp?error=true");
                    }
                    break;

                case "registrar":
                    // Lógica de registro (a ser implementada)
                    break;

                case "desbloquear":
                    // Lógica de desbloqueio (a ser implementada)
                    break;

                default:
                    // Caso ação não seja reconhecida, redireciona para uma página de erro
                    response.sendRedirect("error.jsp");
                    break;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("index.jsp?error=exception");
        }
    }

    // Método para tratar requisições GET
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // Redireciona para o doPost
    }
}
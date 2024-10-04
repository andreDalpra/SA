package br.senai.F1Devs.controle.Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.senai.F1Devs.entidade.Usuario.Usuario;

@WebServlet("/")
public class Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Método que instancia o objeto Usuario
    private Usuario instanciarUsuario(HttpServletRequest request) {
        Usuario usu = new Usuario();
        usu.setUsername(request.getParameter("username"));
        usu.setPassword(request.getParameter("password"));
        return usu;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            Usuario usuario = instanciarUsuario(request);

            switch (action) {
                case "logar":
                    if (usuario.autenticarUsuario()) {
                        // Login bem-sucedido
                        response.sendRedirect("home.jsp");
                    } else {
                        // Falha no login
                        response.sendRedirect("index.jsp?error=true");
                    }
                    break;

                case "registrar":
                    // Implemente a lógica para registro de usuário aqui
                    break;

                case "desbloquear":
                    // Implemente a lógica para desbloquear usuário aqui
                    break;

                default:
                    // Caso ação não seja reconhecida, redirecionar para uma página de erro
                    response.sendRedirect("error.jsp");
                    break;
            }

        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // Redireciona para o doPost
    }
}

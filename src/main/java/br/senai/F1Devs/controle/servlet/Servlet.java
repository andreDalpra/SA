package br.senai.F1Devs.controle.servlet;

import java.io.IOException;

import br.senai.F1Devs.entidade.usuario.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/servlet") // Define o servlet para ser acessado em /servlet
public class Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Método que instancia o objeto Usuario
    private Usuario instanciarUsuario(HttpServletRequest request) {
        Usuario usu = new Usuario();
        usu.setUsername(request.getParameter("username"));
        usu.setPassword(request.getParameter("password"));
        usu.setEmail(request.getParameter("email"));
        String cargo = request.getParameter("cargo"); // Pega o valor do campo "cargo"

        if (cargo == null) {
            System.out.println("Cargo não foi especificado. Definindo como 'desconhecido'.");
            cargo = "desconhecido"; // Valor padrão, se necessário
        }

        int nivel = 10; // Nível padrão, caso o cargo não seja reconhecido
        switch (cargo) {
            case "adm":
                nivel = 0;
                break;
            case "dev":
                nivel = 1;
                break;
            case "analista":
                nivel = 2;
                break;
            default:
                System.out.println("Cargo não reconhecido: " + cargo);
                break;
        }
        usu.setnivel(nivel);
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
                    if (usuario.getNivel() == 0) {
                        response.sendRedirect("home.jsp");
                    } else if (usuario.getNivel() == 1) {
                        response.sendRedirect(request.getContextPath() + "/paginas/desenvolvedor/homeDev.jsp");
                    } else if (usuario.getNivel() == 2) {
                        response.sendRedirect(request.getContextPath() + "/paginas/usuario/homeAnalista.jsp");
                    }
                } else {
                    // Login falhou, redireciona de volta para a página de login com erro
                    response.sendRedirect(request.getContextPath() + "/index.jsp?error=true");
                }
                break;

            case "registrar":
                if (usuario.incluirUsuario()) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/cadastro.jsp?error=true");
                }
                break;

            case "desbloquear":
                String novaSenha = request.getParameter("novaSenha");

                if (usuario.desbloquearUsuario(usuario.getUsername(), novaSenha)) {
                    response.sendRedirect(request.getContextPath() + "/desbloqueado.html");
                }

                break;

            default:
                // Caso ação não seja reconhecida, redireciona para uma página de erro
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                break;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp?error");
        }
    }

    // Método para tratar requisições GET
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // Redireciona para o doPost
    }
}

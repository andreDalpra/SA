package br.senai.SoftLeve.controle.servlet;

import java.io.IOException;

import br.senai.SoftLeve.entidade.usuario.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/servlet") // Define o servlet para ser acessado em /servlet
public class Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Método que instancia o objeto Usuario
    private Usuario instanciarUsuario(HttpServletRequest request) {
        Usuario usu = new Usuario();
        
        String vUser = request.getParameter("username");
        String vPass = request.getParameter("password");
        String vEmail = request.getParameter("email");
        
        usu.setUsername(vUser);
        usu.setPassword(vPass);
        usu.setEmail(vEmail);
        
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Redireciona para o doGet
    }

    // Método para tratar requisições GET
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            Usuario usuario = instanciarUsuario(request);

            switch (action) {
                case "logar":
                    logar(request, response);
                    break;

                case "registrar":
                    registrar(request, response);
                    break;

                case "desbloquear":
                    desbloquear(request, response);

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

    // Método para realizar o login
 // Método para realizar o login
    private void logar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Usuario usuario = instanciarUsuario(request);
            if (usuario.autenticarUsuario()) {
                // Obtém a sessão (cria uma nova se não existir)
                HttpSession session = request.getSession();
                
                // Armazena o objeto usuario na sessão
                session.setAttribute("usuarioLogado", usuario);
                
                // Verifica o nível de acesso e redireciona para a página correspondente
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
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Loga a exceção para debug
            response.sendRedirect(request.getContextPath() + "/error.jsp"); // Redireciona para uma página de erro
        }
    }

    
    private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	Usuario usuario = instanciarUsuario(request);
    	
    	try {
			if (usuario.incluirUsuario()) {
			    response.sendRedirect(request.getContextPath() + "/index.jsp");
			} else {
			    response.sendRedirect(request.getContextPath() + "/cadastro.jsp?error=true");
			}
		} catch (ClassNotFoundException e) {
            e.printStackTrace(); // Loga a exceção para debug
            response.sendRedirect(request.getContextPath() + "/error.jsp"); // Redireciona para uma página de erro
        }
    }
    
    private void desbloquear(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	Usuario usuario = instanciarUsuario(request);
    	String novaSenha = request.getParameter("novaSenha");

        try {
			if (usuario.desbloquearUsuario(usuario.getUsername(), novaSenha)) {
			    response.sendRedirect(request.getContextPath() + "/desbloqueado.html");
			}
		} catch (ClassNotFoundException e) {
            e.printStackTrace(); // Loga a exceção para debug
            response.sendRedirect(request.getContextPath() + "/error.jsp"); // Redireciona para uma página de erro
        }
    }
}































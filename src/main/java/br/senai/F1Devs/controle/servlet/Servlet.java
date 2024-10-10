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
		String cargo = request.getParameter("cargo");
		int nivel = 10;
		switch (cargo) {

		case "adm":
			nivel = 0;
			break;

		case "dev":
			nivel = 1;
			break;

		case "analista":
			nivel = 2;
			;
			break;
		default:
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
						response.sendRedirect("homeDev.jsp");
					} else if (usuario.getNivel() == 2) {
						response.sendRedirect("homeAnalista.jsp");
					}
				} else {
					// Login falhou, redireciona de volta para a página de login com erro
					response.sendRedirect("index.jsp?error=true");
				}
				break;

			case "registrar":
				if (usuario.incluirUsuario()) {
					response.sendRedirect("index.jsp");
				} else {
					response.sendRedirect("cadastro.jsp?error=true");
				}
				break;

			case "desbloquear":
				String novaSenha = (request.getParameter("novaSenha"));

				if (usuario.desbloquearUsuario(usuario.getUsername(), novaSenha)) {
					response.sendRedirect("desbloqueado.html");
				}

				break;

			default:
				// Caso ação não seja reconhecida, redireciona para uma página de erro
				response.sendRedirect("error.jsp");
				break;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("index.jsp?error");
		}
	}

	// Método para tratar requisições GET
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response); // Redireciona para o doPost
	}
}

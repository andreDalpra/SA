package br.senai.SoftLeve.controle.servlet;

import java.io.IOException;
import java.sql.Date;

import br.senai.SoftLeve.entidade.desenvolvedor.Desenvolvedor;
import br.senai.SoftLeve.entidade.tarefa.Tarefa;
import br.senai.SoftLeve.entidade.tipotarefa.TipoTarefa;
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

    private Usuario instanciarUsuario(HttpServletRequest request) {
        Usuario usu = new Usuario();
        String vUser = request.getParameter("username");
        String vPass = request.getParameter("password");
        String vEmail = request.getParameter("email");

        usu.setUsername(vUser);
        usu.setPassword(vPass);
        usu.setEmail(vEmail);

        String cargo = request.getParameter("cargo");
        if (cargo == null) {
            System.out.println("Cargo não foi especificado. Definindo como 'desconhecido'.");
            cargo = "desconhecido";
        }

        int nivel = 10; // Nível padrão
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

    private Desenvolvedor instanciarDev(HttpServletRequest request) {
        Desenvolvedor dev = new Desenvolvedor();
             
        String vNome = request.getParameter("nomeDev");
        String vUsuarioEmail = request.getParameter("usuarioEmail");
        int vUsuarioId = Integer.parseInt(request.getParameter("usuarioId")); // Certifique-se de que o ID é passado

        dev.setNome(vNome);
        dev.setUsuario_email(vUsuarioEmail);
        dev.setUsuario_id(vUsuarioId);

        return dev;
    }
    
    private Tarefa instanciarTarefa(HttpServletRequest request) {
        Tarefa tarefa = new Tarefa();
        
        String vDescricao = request.getParameter("descricao");
        String vStatus = request.getParameter("status");
        Date vPrazo = Date.valueOf(request.getParameter("prazo")); // Certifique-se de que o formato da data está correto
        int vDesenvolvedorId = Integer.parseInt(request.getParameter("desenvolvedorId"));
        int vTipoTarefaId = Integer.parseInt(request.getParameter("tipoTarefaId"));
        
        tarefa.setDescricao(vDescricao);
        tarefa.setStatus(Tarefa.Status.valueOf(vStatus.toUpperCase())); // Converte a string para o enum
        tarefa.setPrazo(vPrazo);
        tarefa.setDesenvolvedor_id(vDesenvolvedorId);
        tarefa.setTipotarefa_id(vTipoTarefaId);

        return tarefa;
    }
    
    private TipoTarefa instanciarTipoTarefa(HttpServletRequest request) {
        TipoTarefa tipoTarefa = new TipoTarefa();
        
        String vNome = request.getParameter("nomeTipoTarefa");
        int vId = Integer.parseInt(request.getParameter("tipoTarefaId")); // ID do tipo de tarefa

        tipoTarefa.setId(vId);
        tipoTarefa.setNome(vNome);

        return tipoTarefa;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
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
                case "cadastrar-dev":
                    cadastrarDev(request, response);
                    break;
                case "excluir-dev":
                    excluirDev(request, response);
                    break;
                case "atualizar-dev":    
					atualizarDev(request, response);
					break;
                default:
                    response.sendRedirect(request.getContextPath() + "/error.jsp");
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp?error");
        }
    }

    private void logar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Usuario usuario = instanciarUsuario(request);
            if (usuario.autenticarUsuario()) {
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogado", usuario);

                if (usuario.getNivel() == 0) {
                    response.sendRedirect("home.jsp");
                } else if (usuario.getNivel() == 1) {
                    response.sendRedirect(request.getContextPath() + "/paginas/desenvolvedor/homeDev.jsp");
                } else if (usuario.getNivel() == 2) {
                    response.sendRedirect(request.getContextPath() + "/paginas/usuario/homeAnalista.jsp");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=true");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Usuario usuario = instanciarUsuario(request);
        try {
            if (usuario.incluirUsuario()) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/cadastro.jsp?error=true");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void desbloquear(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Usuario usuario = instanciarUsuario(request);
        String novaSenha = request.getParameter("novaSenha");

        try {
            if (usuario.desbloquearUsuario(usuario.getUsername(), novaSenha)) {
                response.sendRedirect(request.getContextPath() + "/desbloqueado.html");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void cadastrarDev(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Desenvolvedor dev = instanciarDev(request);

        try {
            if (dev.incluirDev()) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroDev.jsp?error");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroDev.jsp?error");
        }
    }

    private void excluirDev(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtenha o ID diretamente do request
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Desenvolvedor dev = new Desenvolvedor();
            dev.setId(id); // Defina o ID do desenvolvedor a ser excluído

            if (dev.excluirDev()) { // Chamada correta para o método
                response.sendRedirect(request.getContextPath() + "/paginas/adm/listaDev.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/adm/listaDev.jsp?error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/adm/listaDev.jsp?error");
        }
    }
    
    private void atualizarDev(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Desenvolvedor dev = instanciarDev(request);
        dev.setId(id); // Defina o ID do desenvolvedor a ser atualizado

        try {
            if (dev.alterarDev()) { // Chamada correta para o método
                response.sendRedirect(request.getContextPath() + "/paginas/adm/listaDev.jsp?message=Atualização realizada com sucesso!");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/adm/editarDev.jsp?id=" + id + "&message=Falha na atualização!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/adm/editarDev.jsp?id=" + id + "&message=Erro ao atualizar: " + e.getMessage());
        }
    }

    private void cadastrarTarefa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Desenvolvedor dev = instanciarDev(request);

        try {
            if (dev.incluirDev()) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroDev.jsp?error");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroDev.jsp?error");
        }
    }
}

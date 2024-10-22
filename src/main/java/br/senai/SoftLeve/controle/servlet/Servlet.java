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
        
        // Tratamento da data
        String prazoTarefaStr = request.getParameter("prazo");
        Date prazoTarefa = null;
        if (prazoTarefaStr != null && !prazoTarefaStr.isEmpty()) {
            try {
                prazoTarefa = Date.valueOf(prazoTarefaStr); // Converte para java.sql.Date
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                // Aqui você pode lidar com a exceção, como redirecionar ou enviar uma mensagem de erro
            }
        }

        int vDesenvolvedorId = Integer.parseInt(request.getParameter("desenvolvedor_id"));
        int vTipoTarefaId = Integer.parseInt(request.getParameter("tipoTarefa_id"));
        
        tarefa.setDescricao(vDescricao);
        
        try {
            tarefa.setStatus(Tarefa.Status.fromString(vStatus)); // Converte a string para o enum usando fromString()
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            // Trate o erro de status inválido, por exemplo, definindo um valor padrão ou redirecionando com uma mensagem de erro
        }

        tarefa.setPrazo(prazoTarefa); // Define a data tratada
        tarefa.setDesenvolvedor_id(vDesenvolvedorId);
        tarefa.setTipotarefa_id(vTipoTarefaId);

        return tarefa;
    }

    
    private TipoTarefa instanciarTipoTarefa(HttpServletRequest request) {
        TipoTarefa tipoTarefa = new TipoTarefa();
        
        String vDescricao = request.getParameter("descricaoTipoTarefa"); // Nome do parâmetro
        tipoTarefa.setDescricao(vDescricao);

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
                case "cadastrar-tipo-tarefa":    
					cadastrarTipoTarefa(request, response);
					break;
                case "excluir-tipo-tarefa":    
					excluirTipoTarefa(request, response);
					break;
                case "atualizar-tipo-tarefa":    
					atualizarTipoTarefa(request, response);
					break;	
                case "cadastrar-tarefa":    
					cadastrarTarefa(request, response);
					break;
                case "excluir-tarefa":    
					excluirTarefa(request, response);
					break;
                case "atualizar-tarefa":    
					atualizarTarefa(request, response);
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

    private void cadastrarTipoTarefa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TipoTarefa tt = instanciarTipoTarefa(request);

        try {
            if (tt.incluirTipoTarefa()) {
                response.sendRedirect(request.getContextPath() + "/home.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroTipoTarefa.jsp?error");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroTipoTarefa.jsp?error");
        }
    }
   
    private void excluirTipoTarefa(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {
        // Obtenha o ID diretamente do request
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            TipoTarefa tt = new TipoTarefa();
            tt.setId(id); 

            if (tt.excluirTipoTarefa()) { // Chamada correta para o método
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTipoTarefa.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTipoTarefa.jsp?error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTipoTarefa.jsp?error");
        }
    }
    
    private void atualizarTipoTarefa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        TipoTarefa tt = instanciarTipoTarefa(request);
        tt.setId(id); // Defina o ID do desenvolvedor a ser atualizado

        try {
            if (tt.alterarTipoTarefa()) { // Chamada correta para o método
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTipoTarefa.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTipoTarefa.jsp?error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTipoTarefa.jsp?error" + e.getMessage());
        }
    }
    
    private void cadastrarTarefa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Tarefa t = instanciarTarefa(request);

        try {
            if (t.incluirTarefa()) {
                response.sendRedirect(request.getContextPath() + "/home.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroTarefa.jsp?error");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/adm/cadastroTarefa.jsp?error");
        }
    }
    
    private void excluirTarefa(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {
        // Obtenha o ID diretamente do request
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Tarefa t = new Tarefa();
            t.setId(id); 

            if (t.excluirTarefa()) { // Chamada correta para o método
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTarefa.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTarefa.jsp?error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTarefa.jsp?error");
        }
    }
    
    private void atualizarTarefa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tarefa t = instanciarTarefa(request);
        t.setId(id); // Defina o ID do desenvolvedor a ser atualizado

        try {
            if (t.alterarTarefa()) { // Chamada correta para o método
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTarefa.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTarefa.jsp?error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paginas/tarefa/listaTarefa.jsp?error" + e.getMessage());
        }
    }
}

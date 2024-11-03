<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="br.senai.SoftLeve.entidade.usuario.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>
    <div class="container">
        <h1>Bem-vindo</h1>

        <% 
            // Recuperando o usuário da sessão
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

            if (usuarioLogado != null) {
                out.println("<p>Olá, " + usuarioLogado.getUsername() +".</p>");
            } else {
                // Se o usuárnão estiver logado, redireciona para a página de login
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=notLogged");
                return; // Certifica-se de que o redirecionamento aconteça e o restante da página não seja executado
            }
        %>

        <a href="usuariosAtivos.jsp"><button class="btn">Usuários Ativos</button></a>
        <a href="usuariosBloqueados.jsp"><button class="btn">Usuários Bloqueados</button></a>
        <a href="${pageContext.request.contextPath}/index.jsp"><button class="btn">Voltar</button></a>
        <a href="${pageContext.request.contextPath}/paginas/adm/desenvolvedores.jsp"><button class="btn">Desenvolvedores</button></a>
        <a href="${pageContext.request.contextPath}/paginas/tarefa/tarefa.jsp"><button class="btn">Tarefas</button></a>

    </div>
</body>
</html>

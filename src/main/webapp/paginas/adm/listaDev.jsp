<%@ page import="java.util.List"%>
<%@ page import="br.senai.SoftLeve.entidade.desenvolvedor.Desenvolvedor"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Desenvolvedores</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tabelas.css">
</head>
<body>
<div class="container">
    <h1 class="my-4">Lista de Desenvolvedores</h1>

    <%-- Mensagem de erro, se houver --%>
    <%
    String error = request.getParameter("error");
    if (error != null) {
    %>
        <div class="alert alert-danger" role="alert">
            Ocorreu um erro ao excluir o desenvolvedor. Tente novamente.
        </div>
    <%
    }
    %>

    <!-- Tabela para listar os desenvolvedores -->
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>ID Usuário</th>
                <th>Email</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
        <%
        // Recuperando a lista de desenvolvedores
        Desenvolvedor dev = new Desenvolvedor();
        List<Desenvolvedor> listarDev = dev.listarDev();
        if (listarDev != null && !listarDev.isEmpty()) {
            for (Desenvolvedor d : listarDev) {
        %>
            <tr>
                <td><%= d.getId() %></td>
                <td><%= d.getNome() %></td>
                <td><%= d.getUsuario_id() %></td>
                <td><%= d.getUsuario_email() %></td>
                <td>
                    <!-- Botão para editar -->
                    <form action="editarDev.jsp" method="GET" style="display: inline;">
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit" class="btn btn-warning">Editar</button>
                    </form>
                    <!-- Botão para excluir -->
                    <form action="${pageContext.request.contextPath}/servlet" method="POST" style="display: inline;">
                        <input type="hidden" name="action" value="excluir-dev">
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Deseja realmente excluir este desenvolvedor?');">Excluir</button>
                    </form>
                </td>
            </tr>
        <%
            }
        } else {
        %>
            <tr>
                <td colspan="5" class="text-center">Nenhum desenvolvedor encontrado.</td>
            </tr>
        <%
        }
        %>
        </tbody>
    </table>

    <!-- Botão para voltar -->
    <div class="text-center">
        <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-primary">Voltar</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>

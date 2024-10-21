<%@ page import="java.util.List" %>
<%@ page import="br.senai.SoftLeve.entidade.tarefa.Tarefa" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Tarefas</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tabelas.css">
</head>
<body>
<div class="container">
    <h1 class="my-4">Lista de Tarefas</h1>

    <%-- Mensagem de erro, se houver --%>
    <%
    String error = request.getParameter("error");
    if (error != null) {
    %>
        <div class="alert alert-danger" role="alert">
            Ocorreu um erro ao excluir a tarefa. Tente novamente.
        </div>
    <%
    }
    %>

    <!-- Tabela para listar as tarefas -->
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Descrição</th>
                <th>Status</th>
                <th>Prazo</th>
                <th>ID Desenvolvedor</th>
                <th>ID Tipo Tarefa</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
        <%
        // Recuperando a lista de tarefas
        Tarefa tarefa = new Tarefa();
        List<Tarefa> listarTarefas = tarefa.listarTarefas();
        if (listarTarefas != null && !listarTarefas.isEmpty()) {
            for (Tarefa t : listarTarefas) {
        %>
            <tr>
                <td><%= t.getId() %></td>
                <td><%= t.getDescricao() %></td>
                <td><%= t.getStatus().name() %></td>
                <td><%= t.getPrazo() %></td>
                <td><%= t.getDesenvolvedor_id() %></td>
                <td><%= t.getTipotarefa_id() %></td>
                <td>
                    <!-- Botão para editar -->
                    <form action="editarTarefa.jsp" method="GET" style="display: inline;">
                        <input type="hidden" name="id" value="<%= t.getId() %>">
                        <button type="submit" class="btn btn-warning">Editar</button>
                    </form>
                    <!-- Botão para excluir -->
                    <form action="${pageContext.request.contextPath}/servlet" method="POST" style="display: inline;">
                        <input type="hidden" name="action" value="excluir-tarefa">
                        <input type="hidden" name="id" value="<%= t.getId() %>">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Deseja realmente excluir esta tarefa?');">Excluir</button>
                    </form>
                </td>
            </tr>
        <%
            }
        } else {
        %>
            <tr>
                <td colspan="7" class="text-center">Nenhuma tarefa encontrada.</td>
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

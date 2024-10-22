<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="br.senai.SoftLeve.banco.conexao.Conexao" %>

<%
    String id = request.getParameter("id");
    String nomeTipoTarefa = "";

    if (id == null || id.isEmpty()) {
        out.println("<div class='alert alert-danger'>ID do tipo de tarefa não foi fornecido!</div>");
    } else {
        try (Connection conn = Conexao.conectar(); 
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TipoTarefa WHERE id = ?")) {
            
            stmt.setInt(1, Integer.parseInt(id));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    nomeTipoTarefa = rs.getString("nome");
                } else {
                    out.println("<div class='alert alert-danger'>Tipo de tarefa não encontrado!</div>");
                }
            }
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>Erro ao carregar os dados do tipo de tarefa: " + e.getMessage() + "</div>");
        } catch (ClassNotFoundException e) {
            out.println("<div class='alert alert-danger'>Erro ao carregar o driver do banco de dados: " + e.getMessage() + "</div>");
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Tipo de Tarefa</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container text-center">
        <h1>Editar Tipo de Tarefa</h1>
        <form action="${pageContext.request.contextPath}/servlet" method="POST">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="action" value="atualizar-tipo-tarefa">
            <div class="form-group">
                <label for="nomeTipoTarefa">Nome do Tipo de Tarefa:</label>
                <input type="text" id="nomeTipoTarefa" name="nomeTipoTarefa" class="form-control" value="<%= nomeTipoTarefa %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Salvar Alterações</button>
            <a href="listaTipoTarefa.jsp" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>

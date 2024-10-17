<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="br.senai.SoftLeve.banco.conexao.Conexao" %>

<%
    String id = request.getParameter("id");
    String nome = "";
    String usuarioEmail = "";
    int usuarioId = 0;

    if (id == null || id.isEmpty()) {
        out.println("<div class='alert alert-danger'>ID do desenvolvedor não foi fornecido!</div>");
    } else {
        try (Connection conn = Conexao.conectar(); 
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM desenvolvedor WHERE id = ?")) {
            
            stmt.setInt(1, Integer.parseInt(id));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    nome = rs.getString("nome");
                    usuarioEmail = rs.getString("usuario_email");
                    usuarioId = rs.getInt("usuario_id");
                } else {
                    out.println("<div class='alert alert-danger'>Desenvolvedor não encontrado!</div>");
                }
            }
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>Erro ao carregar os dados do desenvolvedor: " + e.getMessage() + "</div>");
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Desenvolvedor</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container text-center">
        <h1>Editar Desenvolvedor</h1>
        <form action="${pageContext.request.contextPath}/servlet" method="POST">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="action" value="atualizar-dev">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nomeDev" name="nomeDev" class="form-control" value="<%= nome %>" required>
            </div>
            <div class="form-group">
                <label for="usuarioEmail">Email:</label>
                <input type="email" id="usuarioEmail" name="usuario_email" class="form-control" value="<%= usuarioEmail %>" required> <!-- Corrigido para usuario_email -->
            </div>
            <button type="submit" class="btn btn-primary">Salvar Alterações</button>
            <a href="listaDev.jsp" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="br.senai.SoftLeve.banco.conexao.Conexao" %>
<%@ page import="br.senai.SoftLeve.entidade.tarefa.Tarefa.Status" %>

<%
    String id = request.getParameter("id");
    String descricao = "";
    String status = "";
    String prazo = "";
    int desenvolvedorId = 0;
    int tipoTarefaId = 0;

    if (id == null || id.isEmpty()) {
        out.println("<div class='alert alert-danger'>ID da tarefa não foi fornecido!</div>");
    } else {
        try (Connection conn = Conexao.conectar(); 
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM tarefa WHERE id = ?")) {
            
            stmt.setInt(1, Integer.parseInt(id));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    descricao = rs.getString("descricao");
                    status = rs.getString("status");
                    prazo = rs.getString("prazo");
                    desenvolvedorId = rs.getInt("desenvolvedor_id");
                    tipoTarefaId = rs.getInt("tipo_tarefa_id");
                } else {
                    out.println("<div class='alert alert-danger'>Tarefa não encontrada!</div>");
                }
            }
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>Erro ao carregar os dados da tarefa: " + e.getMessage() + "</div>");
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
    <title>Editar Tarefa</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container text-center">
        <h1>Editar Tarefa</h1>
        <form action="${pageContext.request.contextPath}/servlet" method="POST">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="action" value="atualizar-tarefa">
            <div class="form-group">
                <label for="descricao">Descrição:</label>
                <input type="text" id="descricao" name="descricao" class="form-control" value="<%= descricao %>" required>
            </div>
            <div class="form-group">
                <label for="status">Status:</label>
                <select id="status" name="status" class="form-control" required>
                    <%
                        for (Status s : Status.values()) {
                            String selected = s.name().equals(status) ? "selected" : "";
                    %>
                        <option value="<%= s.name() %>" <%= selected %>><%= s.name() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="prazo">Prazo:</label>
                <input type="date" id="prazo" name="prazo" class="form-control" value="<%= prazo %>" required>
            </div>
            <div class="form-group">
                <label for="desenvolvedor_Id">ID do Desenvolvedor:</label>
                <input type="number" id="desenvolvedor_Id" name="desenvolvedor_Id" class="form-control" value="<%= desenvolvedorId %>" required>
            </div>
            <div class="form-group">
                <label for="tipoTarefa_Id">ID do Tipo de Tarefa:</label>
                <input type="number" id="tipoTarefa_Id" name="tipoTarefa_Id" class="form-control" value="<%= tipoTarefaId %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Salvar Alterações</button>
            <a href="listaTarefa.jsp" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>

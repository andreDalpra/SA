<%@page import="java.util.List"%>
<%@ page import="br.senai.SoftLeve.entidade.desenvolvedor.Desenvolvedor" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listar Departamento</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f9f9f9; /* Cor de fundo da página */
            }

            .container {
                max-width: 800px; /* Largura máxima do container */
                margin: 40px auto; /* Margem superior e inferior */
                padding: 20px; /* Preenchimento do container */
                background-color: #fff; /* Cor de fundo do container */
                border: 1px solid #ddd; /* Borda do container */
                border-radius: 10px; /* Arredondamento do container */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Sombra do container */
            }

            .table {
                border-collapse: separate; /* Separação das bordas da tabela */
                border-spacing: 0; /* Espaçamento entre as bordas da tabela */
                border-radius: 10px; /* Arredondamento da tabela */
            }

            .table th, .table td {
                border: none; /* Remove a borda das células da tabela */
                padding: 15px; /* Preenchimento das células da tabela */
            }

            .btn {
                border-radius: 10px; /* Arredondamento dos botões */
                padding: 10px 20px; /* Preenchimento dos botões */
            }
        </style>

    </head>
    <body>


        <div class="container">
            <h1 class="my-4">Desenvolvedor</h1>

            <!-- Tabela para listar os funcionarios -->
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>ID Usuario</th>
                        <th>Email</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%
                        // JSP para listar os departamentos
                        Desenvolvedor dev = new Desenvolvedor();
                        List<Desenvolvedor> listarDev = dev.listarDev();
                        for (Desenvolvedor d : listarDev ) {
                    %>
                    <tr>

                        <td><%= d.getId()%></td>
                        <td><%= d.getNome()%></td>
                        <td><%= d.getUsuario_id()%></td>
                        <td><%= d.getUsuario_email() %></td>

                        <td>
                            <!-- Botão para editar -->
                            <form action="editarFuncionario.jsp" method="GET" style="display:inline;">
                                <input type="hidden" name="idFunc" value="<%= d.getId()%>">
                                <button type="submit"class="btn btn-warning">Editar</button>
                            </form>

                            <!-- Botão para excluir -->
                            <form action="excluirFuncionario.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="idFunc" value="<%= d.getId()%>">
                                <button type="submit" class="btn btn-danger" onclick="return confirm('Deseja realmente excluir este funcionário?');">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- Botão para voltar  -->
            <div class="text-center">
                <a href="Funcionarios.html" class="btn btn-primary">Voltar</a>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>

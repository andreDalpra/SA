<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Portfolio</title>
    <style><%@ include file="../css/styles.css" %></style>
</head>
<body>
    <form action="${pageContext.request.contextPath}/Servlet" method="post">
        <input type="hidden" name="action" value="logar"> <!-- Define a a��o como 'logar' -->
        <h2 class="card-title text-center">Login</h2>
        <div class="form-group">
            <b><label for="username">User :</label></b> 
            <input type="text" id="username" name="username" placeholder="Digite seu username" required>
        </div>
        <div class="form-group">
            <b><label for="password">Senha:</label></b> 
            <input type="password" id="password" name="password" placeholder="Digite sua senha" required>
        </div>
        <button type="submit" class="btn-login">Login</button>
        <a href="cadastro.html" class="btn-register">Cadastrar-se</a> 
        <a href="resetarSenha.html" class="btn-senha">Esqueceu sua senha?</a>
    </form>

    <!-- Mensagem de erro opcional -->
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <div class="error-message">
        <p>Login ou senha incorretos, ou conta bloqueada.</p>
    </div>
    <%
        }
    %>
</body>
</html>

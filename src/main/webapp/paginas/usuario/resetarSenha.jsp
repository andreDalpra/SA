<%--  Pagina que reseta a senha do usuario --%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resetar Senha</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/main.js"></script> <!-- Incluindo o main.js -->
</head>
<body>
    <form action="${pageContext.request.contextPath}/servlet" method="post" onsubmit="return validarSenhas()">
    <input type="hidden" name="action" value="desbloquear"> 
        <h2 class="card-title text-center">Resetar Senha</h2>
        
        <!-- Campo para o nome do usuário -->
        <div class="form-group">
            <b><label for="username">Usuário:</label></b>
            <input type="text" id="username" name="username" placeholder="Digite seu username" required>
        </div>
        
        <!-- Campo para nova senha -->
        <div class="form-group">
            <b><label for="novaSenha">Nova Senha:</label></b>
            <input type="password" id="novaSenha" name="novaSenha" placeholder="Digite sua nova senha" required>
        </div>
        
        <!-- Campo para confirmação de senha -->
        <div class="form-group">
            <b><label for="senhaRepetida">Repita a Senha:</label></b>
            <input type="password" id="senhaRepetida" name="senhaRepetida" placeholder="Repita sua nova senha" required>
        </div>
        
        <button type="submit" class="btn-login">Mudar Senha</button>
        <a href="index.html" class="btn-register">Voltar</a>
    </form>
</body>
</html>

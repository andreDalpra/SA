<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro Desenvolvedor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <form action="${pageContext.request.contextPath}/servlet" method="post">
        <input type="hidden" name="action" value="cadastrar-dev">
        <h2 class="card-title text-center">Cadastro</h2>
        <div class="form-group">
            <b><label for="nomeDev">Nome</label></b> 
            <input type="text" id="nomeDev" name="nomeDev" placeholder="Insira o nome do desenvolvedor" required>
        </div>
        <div class="form-group">
            <b><label for="emailDev">Email :</label></b> 
            <input type="email" id="usuarioEmail" name="usuarioEmail" placeholder="Coloque o email do desenvolvedor" required>
        </div>
        <div class="form-group">
            <b><label for="usuarioId">ID do Usuário:</label></b> 
            <input type="number" id="usuarioId" name="usuarioId" placeholder="ID do usuário" required>
        </div>
        <button type="submit" class="btn-login">Cadastrar</button>
        <a href="${pageContext.request.contextPath}/home.jsp" class="btn-register">Voltar</a>
    </form>
</body>
</html>

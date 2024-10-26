<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Portfolio</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <div class="main-container">
        <div class="left-login">
            <img src="sua-imagem-da-empresa.jpg" alt="Imagem da Empresa" class="empresa-imagem">
        </div>
        <div class="right-login">
            <form action="${pageContext.request.contextPath}/servlet" method="post">
                <input type="hidden" name="action" value="logar"> <!-- Define a a��o como 'logar' -->
                <h1 class="titulo-center">Login</h1>
                <div class="form-group">
                    <b><label for="username">User   :</label></b>
                    <div style="position: relative;">
                        <input type="text" id="username" name="username" placeholder="Digite seu username" required>
                        <img width="25" height="27" src="https://img.icons8.com/puffy-filled/32/user.png" alt="user" class=""/>
                    </div>
                </div>
                <div class="form-group">
                    <b><label for="password">Senha:</label></b>
                    <div style="position: relative;">
                        <input type="password" id="password" name="password" placeholder="Digite sua senha" required>
                        <img width="25" height="25" src="https://img.icons8.com/material-rounded/24/lock--v1.png" alt="lock--v1" />
                    </div>
                </div>
                <button type="submit" class="btn-login">Login</button>
                <a href="${pageContext.request.contextPath}/paginas/usuario/cadastro.jsp" class="btn-register">Cadastrar-se</a>
                <a href="${pageContext.request.contextPath}/paginas/usuario/resetarSenha.jsp" class="btn-senha">Esqueceu sua senha?</a>
            </form>
        </div>
    </div>
</body>

</html>
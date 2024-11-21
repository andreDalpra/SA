<%--  Cadastro do tipo de tarefa --%>
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
        <input type="hidden" name="action" value="cadastrar-tipo-tarefa">
        <h2 class="card-title text-center">Cadastro Tipo tarefa</h2>      
        <div class="form-group">
            <b><label for="descricaoTipoTarefa">Nome</label></b> 
            <input type="text" id="descricaoTipoTarefa" name="descricaoTipoTarefa" placeholder="Insira o nome do tipo de tarefa" required>
        </div>             
        <button type="submit" class="btn-login">Cadastrar</button>
        <a href="${pageContext.request.contextPath}/paginas/adm/homeAdm.jsp" class="btn-register">Voltar</a>
    </form>
</body>
</html>

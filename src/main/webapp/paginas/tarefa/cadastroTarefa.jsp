<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Tarefa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <form action="${pageContext.request.contextPath}/servlet" method="post">
        <input type="hidden" name="action" value="cadastrar-tarefa">
        <h2 class="card-title text-center">Cadastro de Tarefa</h2>

        <div class="form-group">
            <b><label for="descricaoTarefa">Descrição</label></b> 
            <input type="text" id="descricaoTarefa" name="descricaoTarefa" placeholder="Insira a descrição da tarefa" required>
        </div>

        <div class="form-group">
            <b><label for="statusTarefa">Status</label></b> 
            <select id="statusTarefa" name="statusTarefa" required>
                <option value="">Selecione o status</option>
                <option value="PENDENTE">Pendente</option>
                <option value="EM_ANDAMENTO">Em Andamento</option>
                <option value="CONCLUIDO">Concluído</option>
                <option value="ATRASADO">Atrasado</option>
            </select>
        </div>

        <div class="form-group">
            <b><label for="prazoTarefa">Prazo</label></b> 
            <input type="date" id="prazoTarefa" name="prazoTarefa" required>
        </div>

        <div class="form-group">
            <b><label for="desenvolvedorId">Desenvolvedor ID</label></b> 
            <input type="number" id="desenvolvedorId" name="desenvolvedorId" placeholder="Insira o ID do desenvolvedor" required>
        </div>

        <div class="form-group">
            <b><label for="tipoTarefaId">Tipo de Tarefa ID</label></b> 
            <input type="number" id="tipoTarefaId" name="tipoTarefaId" placeholder="Insira o ID do tipo de tarefa" required>
        </div>

        <button type="submit" class="btn-login">Cadastrar</button>
        <a href="${pageContext.request.contextPath}/home.jsp" class="btn-register">Voltar</a>
    </form>
</body>
</html>

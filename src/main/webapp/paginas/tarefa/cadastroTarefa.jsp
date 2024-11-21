<%--  Pagina de cadastro de tarefa --%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cadastro de Tarefa</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<form action="${pageContext.request.contextPath}/servlet" method="post">
		<input type="hidden" name="action" value="cadastrar-tarefa">
		<h2 class="card-title text-center">Cadastro de Tarefa</h2>

		<div class="form-group">
			<b><label for="descricao">Descrição</label></b> <input type="text"
				id="descricao" name="descricao"
				placeholder="Insira a descrição da tarefa" required>
		</div>

		<div class="form-group">
			<b><label for="status">Status</label></b> <select id="status"
				name="status" required>
				<option value="PENDENTE">Pendente</option>
				<option value="EM_ANDAMENTO">Em andamento</option>
				<option value="CONCLUIDA">Concluída</option>
				<option value="ATRASADA">Atrasada</option>


			</select>
		</div>



		<div class="form-group">
			<b><label for="prazo">Prazo</label></b> <input type="date" id="prazo"
				name="prazo" required>
		</div>

		<div class="form-group">
			<b><label for="desenvolvedor_id">Desenvolvedor ID</label></b> <input
				type="number" id="desenvolvedor_id" name="desenvolvedor_id"
				placeholder="Insira o ID do desenvolvedor" required>
		</div>

		<div class="form-group">
			<b><label for="tipo_tarefa_id">Tipo de Tarefa ID</label></b> <input
				type="number" id="tipo_tarefa_id" name="tipo_tarefa_id"
				placeholder="Insira o ID do tipo de tarefa" required>
		</div>

		<button type="submit" class="btn-login">Cadastrar</button>
		<a href="${pageContext.request.contextPath}/home.jsp"
			class="btn-register">Voltar</a>
	</form>
</body>
</html>

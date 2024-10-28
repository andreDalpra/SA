<%@ page import="java.util.List"%>
<%@ page import="br.senai.SoftLeve.entidade.tarefa.Tarefa"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cadastro de Tarefa</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/listaTarefa.css">
<!-- Link para o CSS corrigido -->
</head>
<body>
	<div class="container">
		<h1 class="my-4">Lista de Tarefas</h1>

		<!-- Botão para adicionar nova tarefa -->
		<button class="btn" onclick="openModal()">Adicionar Tarefa</button>

		<div id="error-message" class="alert alert-danger"
			style="display: none;"></div>

		<!-- Bloco com borda em volta da tabela -->
		<div class="table-container">
			<!-- Tabela para listar as tarefas -->
			<table class="table table-bordered table-hover" id="task-table">
				<thead>
					<tr>
						<th>ID</th>
						<th>Descrição</th>
						<th>Status</th>
						<th>Prazo</th>
						<th>Desenvolvedor ID</th>
						<th>Tipo de Tarefa ID</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody id="task-list">
					<%
					// Recuperando a lista de tarefas
					Tarefa tarefa = new Tarefa();
					List<Tarefa> listarTarefas = tarefa.listarTarefas(); // Chama o método para listar as tarefas
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

					if (listarTarefas != null && !listarTarefas.isEmpty()) {
						for (Tarefa t : listarTarefas) {
							String prazoFormatado = "";
							if (t.getPrazo() != null) {
						prazoFormatado = sdf.format(t.getPrazo());
							}
					%>
					<tr>
						<td><%=t.getId()%></td>
						<td><%=t.getDescricao()%></td>
						<td><%=t.getStatus()%></td>
						<td><%=prazoFormatado%></td>
						<td><%=t.getDesenvolvedor_id()%></td>
						<td><%=t.getTipotarefa_id()%></td>
						<td>
							<!-- Botão para editar -->
							<form action="editarTarefa.jsp" method="GET"
								style="display: inline;">
								<input type="hidden" name="id" value="<%=t.getId()%>">
								<button type="submit" class="btn btn-warning">Editar</button>
							</form> <!-- Botão para excluir -->
							<form action="${pageContext.request.contextPath}/servlet"
								method="POST" style="display: inline;">
								<input type="hidden" name="action" value="excluir-tarefa">
								<input type="hidden" name="id" value="<%=t.getId()%>">
								<button type="submit" class="btn btn-danger"
									onclick="return confirm('Deseja realmente excluir esta tarefa?');">Excluir</button>
							</form>
						</td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="7" class="text-center">Nenhuma tarefa
							encontrada.</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

		<!-- Modal para adicionar/editar tarefa -->
		<div id="modal-container" class="modal-container">
			<div class="modal">
				<button class="fechar" id="fechar" onclick="closeModal()">X</button>
				<h1 id="modal-title">Cadastro de Tarefa</h1>
				<form action="${pageContext.request.contextPath}/servlet"
					method="post" id="task-form">
					<input type="hidden" name="action" value="cadastrar-tarefa">
					<input type="hidden" id="id" name="id">

					<div class="form-group">
						<b><label for="descricao">Descrição</label></b> <input type="text"
							id="descricao" name="descricao"
							placeholder="Insira a descrição da tarefa" required>
					</div>

					<div class="form-group">
						<b><label for="status">Status</label></b> <select id="status"
							name="status" required>
							<option value="">Selecione o status</option>
							<option value="PENDENTE">Pendente</option>
							<option value="EM_ANDAMENTO">Em Andamento</option>
							<option value="CONCLUIDO">Concluído</option>
							<option value="ATRASADO">Atrasado</option>
						</select>
					</div>

					<div class="form-group">
						<b><label for="prazo">Prazo</label></b> <input type="date"
							id="prazo" name="prazo" required>
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

					<button type="submit" id="submit-button">Cadastrar</button>
				</form>



			</div>
		</div>

		<div class="text-center">
			<a href="home.jsp" class="btn btn-secondary">Voltar</a>
		</div>
	</div>

	<script src="${pageContext.request.contextPath}/js/tabela.js"></script>
	<!-- Link para o JavaScript corrigido -->
</body>
</html>
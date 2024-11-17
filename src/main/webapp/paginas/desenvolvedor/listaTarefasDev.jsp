<%@ page import="java.util.List"%>
<%@ page import="br.senai.SoftLeve.entidade.tarefa.Tarefa"%>
<%@ page import="br.senai.SoftLeve.entidade.tipotarefa.TipoTarefa"%>
<%@ page import="br.senai.SoftLeve.entidade.desenvolvedor.Desenvolvedor"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tarefas Adm</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/listaTarefa.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

	<div class="container">
		<div class="header">
			<h1>Tarefas</h1>
			<button class="btn btn-tela" onclick="openModal('create')">
				<i class="fa-solid fa-plus"></i> Adicionar Tarefa
			</button>
		</div>

		<div id="error-message" class="alert alert-danger"
			style="display: none;"></div>

		<div class="table-container">
			<table class="table" id="task-table">
				<thead>
					<tr>

						<th>Descrição</th>
						<th>Status</th>
						<th>Prazo</th>
						<th>Desenvolvedor Responsável</th>
						<th>Tipo de Tarefa</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody id="task-list">
					<%
					Tarefa tarefa = new Tarefa();
					List<Tarefa> listarTarefas = tarefa.listarTarefas();
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

					if (listarTarefas != null && !listarTarefas.isEmpty()) {
						for (Tarefa t : listarTarefas) {
							String prazoFormatado = (t.getPrazo() != null) ? sdf.format(t.getPrazo()) : "Sem prazo";
							String descTipoTarefa = null;
							try{
								descTipoTarefa = Tarefa.buscarTipoTarefaPorId(t.getTipotarefa_id());
								
							} catch (ClassNotFoundException e){
								e.printStackTrace();
							}
							
							String nomeDesenvolvedor = null;
							try {
						nomeDesenvolvedor = Tarefa.buscarNomePorDevId(t.getDesenvolvedor_id()); // Chama o método para buscar o nome do desenvolvedor
							} catch (ClassNotFoundException e) {
						e.printStackTrace();
							}
					%>
					<tr>
						<td><%=t.getDescricao()%></td>
						<td><%=t.getStatus()%></td>
						<td><%=prazoFormatado%></td>
						<td><%=nomeDesenvolvedor != null ? nomeDesenvolvedor : "Desenvolvedor não encontrado"%></td>
						<!-- Exibe o nome do desenvolvedor -->
						<td><%=descTipoTarefa != null ? descTipoTarefa :"Tipo Tarefa não encontrados"%></td>
						<td>
							<button type="button" class="btn btn-editar"
								onclick="openModal('edit', {
                id: '<%=t.getId()%>',
                descricao: '<%=t.getDescricao()%>',
                status: '<%=t.getStatus()%>',
                prazo: '<%=t.getPrazo()%>',
                desenvolvedor_id: '<%=t.getDesenvolvedor_id()%>',
                tipotarefa_id: '<%=t.getTipotarefa_id()%>'
            })">
								<i class="fa-regular fa-pen-to-square"></i> Editar
							</button>
							<button type="button" class="btn btn-danger"
								onclick="confirmDelete(<%=t.getId()%>)">
								<i class="fa-solid fa-trash-can"></i> Excluir
							</button>
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


		<!-- Modal para edição -->
		<div id="edit-modal-container" class="modal-container">
			<div class="modal">
				<span class="fechar" onclick="closeEditModal()">X</span>
				<h1 id="edit-modal-title">Editar Tarefa</h1>
				<form action="${pageContext.request.contextPath}/servlet"
					method="post" id="edit-task-form">
					<input type="hidden" name="action" id="edit-form-action"
						value="atualizar-tarefa"> <input type="hidden"
						id="edit-id" name="id">

					<div class="form-group">
						<label for="edit-descricao">Descrição</label> <input type="text"
							id="edit-descricao" name="descricao" required>
					</div>

					<div class="form-group">
						<label for="edit-status">Status</label> <select id="edit-status"
							name="status" required>
							<option value="">Selecionar status</option>
							<option value="PENDENTE">Pendente</option>
							<option value="EM_ANDAMENTO">Em Andamento</option>
							<option value="CONCLUIDA">Concluída</option>
							<option value="ATRASADA">Atrasada</option>
						</select>
					</div>

					<div class="form-group">
						<label for="edit-prazo">Prazo</label> <input type="date"
							id="edit-prazo" name="prazo" required>
					</div>

					<div class="form-group">
						<label for="edit-desenvolvedor_id">Desenvolvedor ID</label> <select
							id="edit-desenvolvedor_id" name="desenvolvedor_id" required>
							<option value="" disabled selected>Selecione o ID do
								desenvolvedor</option>
							<%
							Desenvolvedor dev = new Desenvolvedor();
							List<Desenvolvedor> listarDev = dev.listarDev();	
							if (listarDev != null && !listarDev.isEmpty()) {
								for (Desenvolvedor d : listarDev) {
							%>

							<option value="<%=d.getId()%>"><%=d.getId()%> -
								<%=d.getNome()%></option>
							<%
							}
							} else {
							out.println("<option value=''>Nenhum dev encontrado</option>");
							}
							%>
						</select>
					</div>

					<div class="form-group">
						<label for="edit-tipo_tarefa_id">Tipo de Tarefa ID</label> <select
							id="edit-tipo_tarefa_id" name="tipo_tarefa_id" required>
							<option value="" disabled selected>Selecione o ID do
								tipo da tarefa</option>
							<%
							TipoTarefa tt = new TipoTarefa();
							List<TipoTarefa> listarTipoTarefas = tt.listarTiposTarefa();
							if (listarTipoTarefas != null && !listarTipoTarefas.isEmpty()) {
								for (TipoTarefa t : listarTipoTarefas) {
							%>
							<option value="<%=t.getId()%>"><%=t.getId()%> -
								<%=t.getDescricao()%></option>
							<%
							}
							} else {
							out.println("<option value=''>Nenhum tipo de tarefa encontrado</option>");
							}
							%>
						</select>
					</div>

					<button type="submit" id="edit-submit-button">Salvar
						Alterações</button>
				</form>
			</div>
		</div>

		<!-- Modal de confirmação de exclusão -->
		<div id="delete-modal" class="modal-container" style="display: none;">
			<div class="modal">
				<span class="fechar" onclick="closeDeleteModal()">X</span>
				<h2>Confirmação de Exclusão</h2>

				<form action="${pageContext.request.contextPath}/servlet"
					method="POST">
					<input type="hidden" name="action" value="excluir-tarefa">
					<input type="hidden" id="delete-task-id" name="id">
					<div class="modal-buttons">
						<button type="submit" class="btn btn-danger">Excluir</button>
						<button type="button" class="btn btn-secondary"
							onclick="closeDeleteModal()">Cancelar</button>
					</div>
				</form>
			</div>
		</div>

		<div class="text-center">
			<a href="${pageContext.request.contextPath}/paginas/adm/homeAdm.jsp"
				class="btn">Voltar</a>
		</div>

		<script src="${pageContext.request.contextPath}/js/modal.js" defer></script>
	</div>
</body>
</html>
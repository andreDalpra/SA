<%@ page import="java.util.List"%>
<%@ page import="br.senai.SoftLeve.entidade.tarefa.Tarefa"%>
<%@ page import="br.senai.SoftLeve.entidade.desenvolvedor.Desenvolvedor"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Minhas Tarefas</title>
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
			<h1>
				Minhas Tarefas
				<%
			Desenvolvedor devLogado = (Desenvolvedor) session.getAttribute("devLogado");
			if (devLogado == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp?error=notLogged");
				return;
			}
			%>

			</h1>
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
						<th>Ações</th>
					</tr>
				</thead>
				<tbody id="task-list">
					<%
					// Recupera as tarefas diretamente no JSP
					List<Tarefa> listarTarefas = Tarefa.tarefasDevs(devLogado.getId());
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

					if (listarTarefas != null && !listarTarefas.isEmpty()) {
						for (Tarefa t : listarTarefas) {
							String prazoFormatado = (t.getPrazo() != null) ? sdf.format(t.getPrazo()) : "Sem prazo";
					%>
					<tr>
						<td><%=t.getDescricao()%></td>
						<td><%=t.getStatus()%></td>
						<td><%=prazoFormatado%></td>
						<td>
							<button type="button" class="btn btn-editar"
								onclick="openModal('edit', {
                                    descricao: '<%=t.getDescricao()%>',
                                    status: '<%=t.getStatus()%>',
                                    prazo: '<%=prazoFormatado%>'
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
						<td colspan="4" class="text-center">Nenhuma tarefa
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
					<input type="hidden" name="action" value="atualizar-tarefa">
					<input type="hidden" id="edit-id" name="id">

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
							id="edit-prazo" name="prazo">
					</div>

					<button type="submit" id="edit-submit-button">Salvar
						Alterações</button>
				</form>
			</div>
		</div>

		<div class="text-center">
			<a
				href="${pageContext.request.contextPath}/paginas/desenvolvedor/homeDev.jsp"
				class="btn">Voltar</a>
		</div>
		<script src="${pageContext.request.contextPath}/js/modal.js" defer></script>
	</div>
</body>
</html>
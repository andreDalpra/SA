<%@ page import="java.util.List"%>
<%@ page import="br.senai.SoftLeve.entidade.tarefa.Tarefa"%>
<%@ page import="br.senai.SoftLeve.entidade.usuario.Usuario"%>
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
			<h1>Desenvolvedores</h1>

		</div>

		<div id="error-message" class="alert alert-danger"
			style="display: none;"></div>

		<div class="table-container">
			<table class="table" id="task-table">
				<thead>
					<tr>
						<th>ID</th>
						<th>Nome</th>
						<th>Email</th>
						<th>ID usuário</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody id="task-list">
					<%
					Desenvolvedor dev = new Desenvolvedor();
					List<Desenvolvedor> listarDev = dev.listarDev();
					if (listarDev != null && !listarDev.isEmpty()) {
						for (Desenvolvedor d : listarDev) {
					%>
					<tr>
						<td><%=d.getId()%></td>
						<td><%=d.getNome()%></td>
						<td><%=d.getUsuario_email()%></td>
						<td><%=d.getUsuario_id()%></td>
						<td>
							<button type="button" class="btn btn-editar"
								onclick="openModalVerDev({
        id: '<%=d.getId()%>'
    })">
								<i class="fa-regular fa-pen-to-square"></i> Editar
							</button>


							<button type="button" class="btn btn-danger"
								onclick="verDevDelete(<%=d.getId()%>)">
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
		<div id="edit-dev-modal-container" class="modal-container">
			<div class="modal">
				<span class="fechar" onclick="closeEditDevModal()">X</span>
				<h1 id="edit-dev-modal-title">Somente ADM</h1>
				
					<input type="hidden" name="action" id="edit-form-action"
						value="atualizar-dev"> <input type="hidden"
						id="edit-id-dev" name="id">

					

					<button type="button" id="edit-submit-button" onclick="window.location.href='${pageContext.request.contextPath}/paginas/desenvolvedor/verDevs.jsp'" class="btn btn-secondary">
    Voltar ao menu
</button>

				
			</div>
		</div>

		<!-- Modal de confirmação de exclusão -->
		<div id="delete-tipo-modal" class="modal-container" style="display: none;">
			<div class="modal">
				<span class="fechar" onclick="closeDeleteDevModal()">X</span>
				<h1>Somente ADM</h1>

				
					<input type="hidden" name="action" value="excluir-dev">
					<input type="hidden" id="delete-tipo-id" name="id">
					<div class="modal-buttons">
						
						<button type="button" class="btn btn-secondary"
							onclick="closeDeleteDevModal()">Voltar</button>
					</div>
				
			</div>
		</div>

		<div class="text-center">
			<a href="${pageContext.request.contextPath}/paginas/desenvolvedor/homeDev.jsp"
				class="btn">Voltar</a>
		</div>

		<script src="${pageContext.request.contextPath}/js/modal.js" defer></script>
	</div>
</body>
</html>
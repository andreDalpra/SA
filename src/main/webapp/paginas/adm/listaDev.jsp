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
								onclick="openModal('edit-dev', null, {
        id: '<%=d.getId()%>',
        nome: '<%=d.getNome()%>'
        
    })">
								<i class="fa-regular fa-pen-to-square"></i> Editar
							</button>


							<button type="button" class="btn btn-danger"
								onclick="confirmDevDelete(<%=d.getId()%>)">
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
				<h1 id="edit-dev-modal-title">Editar Desenvolvedor</h1>
				<form action="${pageContext.request.contextPath}/servlet"
					method="post" id="edit-task-form">
					<input type="hidden" name="action" id="edit-form-action"
						value="atualizar-dev"> <input type="hidden"
						id="edit-id-dev" name="id">

					<div class="form-group">
						<label for="edit-nome">Nome</label> <input type="text"
							id="edit-nome" name="nomeDev" required>
					</div>

					<button type="submit" id="edit-submit-button">Salvar
						Alterações</button>
				</form>
			</div>
		</div>

		<!-- Modal de confirmação de exclusão -->
		<div id="delete-dev-modal" class="modal-container" style="display: none;">
			<div class="modal">
				<span class="fechar" onclick="closeDeleteDevModal()">X</span>
				<h2>Confirmação de Exclusão</h2>

				<form action="${pageContext.request.contextPath}/servlet"
					method="POST">
					<input type="hidden" name="action" value="excluir-dev">
					<input type="hidden" id="delete-dev-id" name="id">
					<div class="modal-buttons">
						<button type="submit" class="btn btn-danger">Excluir</button>
						<button type="button" class="btn btn-secondary"
							onclick="closeDeleteDevModal()">Cancelar</button>
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
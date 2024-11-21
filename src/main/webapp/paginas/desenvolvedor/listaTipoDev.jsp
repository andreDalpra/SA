<%--  Pagina que lista os tipos de tarefa para o desenvolvedor --%>
<%@ page import="java.util.List"%>
<%@ page import="br.senai.SoftLeve.entidade.tipotarefa.TipoTarefa"%>
<%@ page import="br.senai.SoftLeve.entidade.usuario.Usuario"%>
<%@ page import="br.senai.SoftLeve.entidade.desenvolvedor.Desenvolvedor"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tipo Tarefa Dev</title>
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
			<h1>Tipo Tarefa Dev</h1>

		</div>

		<div id="error-message" class="alert alert-danger"
			style="display: none;"></div>

		<div class="table-container">
			<table class="table" id="task-table">
				<thead>
					<tr>
					<%--  Tabela --%>
						<th>ID</th>
						<th>Descrição</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody id="task-list">
				<%--  Listagem --%>
					<%
					// Recuperando a lista de tipos de tarefa
					TipoTarefa tipoTarefa = new TipoTarefa();
					List<TipoTarefa> listarTipos = tipoTarefa.listarTiposTarefa();
					if (listarTipos != null && !listarTipos.isEmpty()) {
						for (TipoTarefa tt : listarTipos) {
					%>
					<tr>
						<td><%=tt.getId()%></td>
						<td><%=tt.getDescricao()%></td>

						<td>
						<%--  Modal --%>
							<button type="button" class="btn btn-editar"
								onclick="openModalVerTipoDev({
            id: '<%=tt.getId()%>',
            descricao: '<%=tt.getDescricao()%>'
        })">
								<i class="fa-regular fa-pen-to-square"></i> Editar
							</button>



							<button type="button" class="btn btn-danger"
								onclick="verTipoDevDelete(<%=tt.getId()%>)">
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
		<div id="edit-tipo-modal-container" class="modal-container">
			<div class="modal">
				<span class="fechar" onclick="closeEditTipoModal()">X</span>
				<h1 id="edit-tipo-modal-title">Somente ADM</h1>
				
					<input type="hidden" name="action" id="edit-form-action"
						value="atualizar-tipo-tarefa"> <input type="hidden"
						id="edit-id-tipo" name="id">

					

					<button type="button" id="edit-submit-button" onclick="window.location.href='${pageContext.request.contextPath}/paginas/desenvolvedor/listaTipoDev.jsp'" class="btn btn-secondary">
    Voltar ao menu
</button>
				
			</div>
		</div>

		<!-- Modal de confirmação de exclusão -->
		<div id="delete-tipo-modal" class="modal-container"
			style="display: none;">
			<div class="modal">
				<span class="fechar" onclick="closeDeleteTipoModal()">X</span>
				<h2>Somente ADM</h2>

				
					<input type="hidden" name="action" value="excluir-tipo-tarefa"> <input
						type="hidden" id="delete-tipo-id" name="id">
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
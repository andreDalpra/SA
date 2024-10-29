// Função para abrir a modal de cadastro/edição
function openModal(task = null) {
	if (task) {
		document.getElementById('id').value = task.id;
		document.getElementById('descricao').value = task.descricao;
		document.getElementById('status').value = task.status;
		document.getElementById('prazo').value = task.prazo;
		document.getElementById('desenvolvedor_id').value = task.desenvolvedor_id;
		document.getElementById('tipo_tarefa_id').value = task.tipotarefa_id;
		document.getElementById('modal-title').innerText = "Editar Tarefa";
	} else {
		document.getElementById('task-form').reset();
		document.getElementById('modal-title').innerText = "Cadastro de Tarefa";
	}
	document.getElementById("modal-container").style.display = "flex";
}

// Função para fechar a modal de cadastro/edição
function closeModal() {
	document.getElementById("modal-container").style.display = "none";
}

// Função para abrir a modal de confirmação de exclusão
function confirmDelete(taskId) {
	document.getElementById("delete-task-id").value = taskId;  // Definindo o ID da tarefa para exclusão
	document.getElementById("delete-modal").style.display = "flex";  // Mostra a modal de exclusão
}

// Função para fechar a modal de confirmação de exclusão
function closeDeleteModal() {
	document.getElementById("delete-modal").style.display = "none";
}

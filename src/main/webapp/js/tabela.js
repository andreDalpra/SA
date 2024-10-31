// Função para abrir a modal de cadastro ou edição
function openModal(mode, task = null) {
    if (mode === 'edit' && task) {
        document.getElementById('edit-id').value = task.id;
        document.getElementById('edit-descricao').value = task.descricao;
        document.getElementById('edit-status').value = task.status;
        document.getElementById('edit-prazo').value = task.prazo;
        document.getElementById('edit-desenvolvedor_id').value = task.desenvolvedor_id;
        document.getElementById('edit-tipo_tarefa_id').value = task.tipotarefa_id;
        document.getElementById('edit-modal-title').innerText = "Editar Tarefa";
        document.getElementById('edit-modal-container').style.display = "flex";
    } else {
        document.getElementById('task-form').reset();
        document.getElementById('modal-title').innerText = "Cadastro de Tarefa";
        document.getElementById('modal-container').style.display = "flex";
    }
}

// Função para fechar a modal de cadastro
function closeModal() {
    document.getElementById("modal-container").style.display = "none";
}

// Função para fechar a modal de edição
function closeEditModal() {
    document.getElementById("edit-modal-container").style.display = "none";
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
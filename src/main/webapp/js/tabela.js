// Função para abrir a modal
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

// Função para fechar a modal
function closeModal() {
    document.getElementById("modal-container").style.display = "none";
}

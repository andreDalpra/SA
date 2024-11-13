// Função para abrir a modal de cadastro ou edição
function openModal(mode, task = null, dev = null) {
    if (mode === 'edit' && task) {
        // Modal de edição de tarefa
        document.getElementById('edit-id').value = task.id;
        document.getElementById('edit-descricao').value = task.descricao;
        document.getElementById('edit-status').value = task.status;
        document.getElementById('edit-prazo').value = task.prazo;
        document.getElementById('edit-desenvolvedor_id').value = task.desenvolvedor_id;
        document.getElementById('edit-tipo_tarefa_id').value = task.tipotarefa_id;
        document.getElementById('edit-modal-title').innerText = "Editar Tarefa";
        document.getElementById('edit-modal-container').style.display = "flex";
    } 
    else if (mode === 'edit-dev' && dev) {
        // Modal de edição de desenvolvedor
        document.getElementById('edit-id-dev').value = dev.id;
        document.getElementById('edit-nome').value = dev.nome;
        document.getElementById('edit-dev-modal-title').innerText = "Editar Desenvolvedor";
        document.getElementById('edit-dev-modal-container').style.display = "flex";
    }
   
    else {
        // Modal de cadastro de nova tarefa
        document.getElementById('task-form').reset();
        document.getElementById('modal-title').innerText = "Cadastro de Tarefa";
        document.getElementById('modal-container').style.display = "flex";
    }
}
 
function openModalTipo(tipo) {
    // Verifica se o objeto tipo contém os valores esperados
    if (tipo) {
        document.getElementById('edit-id-tipo').value = tipo.id;
        document.getElementById('edit-descricao').value = tipo.descricao;
        document.getElementById('edit-tipo-modal-title').innerText = "Editar Tipo Tarefa";
        document.getElementById('edit-tipo-modal-container').style.display = "flex";
    } else {
        console.warn("Objeto 'tipo' não fornecido ou inválido.");
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

function closeEditDevModal() {
    document.getElementById("edit-dev-modal-container").style.display = "none";
}

function closeEditTipoModal() {
    document.getElementById("edit-tipo-modal-container").style.display = "none";
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

// Função para abrir a modal de confirmação de exclusão
function confirmDevDelete(devId) {
    document.getElementById("delete-dev-id").value = devId;  // Definindo o ID da tarefa para exclusão
    document.getElementById("delete-dev-modal").style.display = "flex";  // Mostra a modal de exclusão
}

// Função para fechar a modal de confirmação de exclusão
function closeDeleteDevModal() {
    document.getElementById("delete-dev-modal").style.display = "none";
}

// Função para abrir a modal de confirmação de exclusão
function confirmTipoDelete(tipoId) {
    document.getElementById("delete-tipo-id").value = tipoId;  // Definin	do o ID da tarefa para exclusão
    document.getElementById("delete-tipo-modal").style.display = "flex";  // Mostra a modal de exclusão
}

// Função para fechar a modal de confirmação de exclusão
function closeDeleteTipoModal() {
    document.getElementById("delete-tipo-modal").style.display = "none";
}
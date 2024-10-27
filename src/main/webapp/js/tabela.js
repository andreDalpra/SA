const apiUrl = 'http://localhost:3000/tasks'; // Substitua pela URL do seu back-end
let editingTaskId = null; // Variável para armazenar o ID da tarefa que está sendo editada

// Função para abrir a modal
function openModal(task = null) {
    if (task) {
        // Se uma tarefa for passada, preencha o modal com os dados da tarefa
        editingTaskId = task.id;
        document.getElementById('task-id').value = task.id;
        document.getElementById('task-descricao').value = task.descricao;
        document.getElementById('task-status').value = task.status;
        document.getElementById('task-prazo').value = task.prazo;
        document.getElementById('task-desenvolvedor_id').value = task.desenvolvedor_id;
        document.getElementById('task-tipotarefa_id').value = task.tipotarefa_id;
        document.getElementById('modal-title').innerText = "Editar Tarefa";
    } else {
        // Se não houver tarefa, limpa o modal
        editingTaskId = null;
        document.getElementById('task-form').reset();
        document.getElementById('modal-title').innerText = "Cadastro de Tarefa";
    }
    document.getElementById("modal-container").style.display = "flex";
}

function closeModal() {
    document.getElementById("modal-container").style.display = "none";
}

// Adiciona um listener para o formulário de adicionar tarefa
document.getElementById('task-form').addEventListener('submit', async function (e) {
    e.preventDefault();

    const descricao = document.getElementById('task-descricao').value;
    const status = document.getElementById('task-status').value;
    const prazo = document.getElementById('task-prazo').value;
    const desenvolvedor_id = document.getElementById('task-desenvolvedor_id').value;
    const tipotarefa_id = document.getElementById('task-tipotarefa_id').value;

    const task = { descricao, status, prazo, desenvolvedor_id, tipotarefa_id };

    if (editingTaskId) {
        // Se estamos editando, chama a função de editar
        await editTask(editingTaskId, task);
    } else {
        // Se estamos adicionando, chama a função de adicionar
        await addTask(task);
    }

    closeModal();
});

// Função para adicionar uma tarefa
async function addTask(task) {
    try {
        const response = await fetch(apiUrl, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(task),
        });

        const data = await response.json();

        // Adiciona a tarefa à lista
        const taskList = document.getElementById('task-list');
        const taskRow = document.createElement('tr');
        taskRow.setAttribute('data-id', data.id); // Adiciona o atributo data-id
        taskRow.innerHTML = `
            <td>${data.id}</td>
            <td>${data.descricao}</td>
            <td>${data.status}</td>
            <td>${data.prazo}</td>
            <td>${data.desenvolvedor_id}</td>
            <td>${data.tipotarefa_id}</td>
            <td>
                <button class="btn btn-warning" onclick='openModal(${JSON.stringify(data)})'>Editar</button>
                <button class="btn btn-danger" onclick='deleteTask(${data.id})'>Excluir</button>
            </td>
        `;
        taskList.appendChild(taskRow);
    } catch (error) {
        console.error(error);
        // Mostra mensagem de erro
        const errorMessage = document.getElementById('error-message');
        errorMessage.textContent = 'Erro ao adicionar tarefa!';
        errorMessage.style.display = 'block';
    }
}

// Função para editar uma tarefa
async function editTask(id, task) {
    try {
        const response = await fetch(`${apiUrl}/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(task),
        });

        const data = await response.json();

        // Atualiza a tarefa na lista
        const taskList = document.getElementById('task-list');
        const taskRow = taskList.querySelector(`tr[data-id="${id}"]`);
        taskRow.innerHTML = `
            <td>${data.id}</td>
            <td>${data.descricao}</td>
            <td>${data.status}</td>
            <td>${data.prazo}</td>
            <td>${data.desenvolvedor_id}</td>
            <td>${data.tipotarefa_id}</td>
            <td>
                <button class="btn btn-warning" onclick='openModal(${JSON.stringify(data)})'>Editar</button>
                <button class="btn btn-danger" onclick='deleteTask(${data.id})'>Excluir</button>
            </td>
        `;
    } catch (error) {
        console.error(error);
        // Mostra mensagem de erro
        const errorMessage = document.getElementById('error-message');
        errorMessage.textContent = 'Erro ao editar tarefa!';
        errorMessage.style.display = 'block';
    }
}

// Função para excluir uma tarefa
async function deleteTask(id) {
    try {
        const response = await fetch(`${apiUrl}/${id}`, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },
        });

        const taskList = document.getElementById('task-list');
        const taskRow = taskList.querySelector(`tr[data-id="${id}"]`);
        taskRow.remove();
    } catch (error) {
        console.error(error);
        // Mostra mensagem de erro
        const errorMessage = document.getElementById('error-message');
        errorMessage.textContent = 'Erro ao excluir tarefa!';
        errorMessage.style.display = 'block';
    }
}

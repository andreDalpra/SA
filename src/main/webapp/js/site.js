function scrollToElement(elementSelector, instance = 0) {
    // Select all elements that match the given selector
    const elements = document.querySelectorAll(elementSelector);
    // Check if there are elements matching the selector and if the requested instance exists
    if (elements.length > instance) {
        // Scroll to the specified instance of the element
        elements[instance].scrollIntoView({ behavior: 'smooth' });
    }
}

const link1 = document.getElementById("link1");
const link2 = document.getElementById("link2");
const link3 = document.getElementById("link3");

link1.addEventListener('click', () => {
    scrollToElement('.header');
});

link2.addEventListener('click', () => {
    // Scroll to the second element with "header" class
    scrollToElement('.header', 1);
});

link3.addEventListener('click', () => {
    scrollToElement('.column');
});
document.addEventListener('DOMContentLoaded', function() {
    let activeDropdown = null; // Variável para armazenar o dropdown atualmente aberto

    function toggleDropdown(event, dropdownId) {
        event.preventDefault();
        const dropdown = document.getElementById(dropdownId);

        // Fecha o dropdown aberto, se for diferente do atual
        if (activeDropdown && activeDropdown !== dropdown) {
            activeDropdown.style.display = 'none';
        }

        // Alterna o estado do dropdown atual
        dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';

        // Define o activeDropdown para o dropdown atual se ele estiver visível, ou para null se estiver fechado
        activeDropdown = dropdown.style.display === 'block' ? dropdown : null;
    }

    // Fecha o dropdown se o usuário clicar fora dele
    document.addEventListener('click', function(event) {
        if (activeDropdown && !activeDropdown.contains(event.target) && 
            !event.target.closest('.link')) { 
            // fecha o dropdown aberto se o clique for fora do link e do dropdown ativo
            activeDropdown.style.display = 'none';
            activeDropdown = null;
        }
    });

    // Adiciona os eventos de clique para os links de usuários e desenvolvedores
    document.getElementById('usuarios-link').addEventListener('click', function(event) {
        toggleDropdown(event, 'usuarios-dropdown');
    });

    document.getElementById('dev-link').addEventListener('click', function(event) {
        toggleDropdown(event, 'dev-dropdown');
    });
});







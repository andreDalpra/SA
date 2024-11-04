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

function toggleDropdown(event, dropdownId) {
    event.preventDefault();
    const dropdown = document.getElementById(dropdownId);
    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
}

// Fecha o dropdown se o usuário clicar fora do menu
document.addEventListener('click', function(event) {
    const dropdown = document.getElementById('usuarios-dropdown');
    const link = document.getElementById('usuarios-link');

    // Verifica se o clique foi fora do link e do dropdown
    if (dropdown.style.display === 'block' && !link.contains(event.target) && !dropdown.contains(event.target)) {
        dropdown.style.display = 'none';
    }
});





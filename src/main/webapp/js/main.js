function validarSenhas() {
            const newPassword = document.getElementById('novaSenha').value;
            const confirmPassword = document.getElementById('senhaRepetida').value;
            if (newPassword !== confirmPassword) {
                alert("As senhas não correspondem!");
                return false;
            }
            return true;
        }
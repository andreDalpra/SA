<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cadastro</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<form action="${pageContext.request.contextPath}/servlet" method="post">
		<input type="hidden" name="action" value="registrar">
		<h2 class="card-title text-center">Cadastro</h2>
		<div class="form-group">
			<b><label for="username">User :</label></b> <input type="text"
				id="username" name="username" placeholder="Crie seu username">
		</div>
		<div class="form-group">
			<b><label for="password">Senha:</label></b> <input type="password"
				id="password" name="password" placeholder="Crie uma senha">
		</div>
		<div class="form-group">
			<b><label for="cargo">Cargo:</label></b> <select name="cargo">
				<option value="adm">Administrador</option>
				<option value="dev">Desenvolvedor</option>
				<option value="analista">Analista</option>
			</select>

		</div>

		<button type="submit" class="btn-login">Cadastrar</button>
		<a href="${pageContext.request.contextPath}/index.jsp"
			class="btn-register">Voltar</a>
	</form>
</body>
</html>

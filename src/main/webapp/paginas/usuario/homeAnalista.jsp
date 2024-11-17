<%@ page import="br.senai.SoftLeve.entidade.usuario.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/site.css">
<title>Soft Leve</title>
</head>

<body>

	<nav>
		<div class="nav-logo">
			<a href="#"> <img
				src="${pageContext.request.contextPath}/img/Logo.png" alt="Logo">
			</a>
		</div>

		<ul class="nav-links">
			<!-- Menu Dropdown de Usuários -->
			<li class="link"><a href="#" id="usuarios-link"
				onclick="toggleDropdown(event, 'usuarios-dropdown')"> Usuários <span
					class="arrow">▾</span>
			</a>
				<ul id="usuarios-dropdown" class="dropdown">
					<li><a
						href="${pageContext.request.contextPath}/paginas/usuario/usuariosAtivos.jsp">Usuários
							Ativos</a></li>
					<li><a
						href="${pageContext.request.contextPath}/paginas/usuario/usuariosBloqueados.jsp">Bloqueados</a></li>
				</ul></li>

			<!-- Menu Dropdown de Desenvolvedores -->
			<li class="link"><a href="#" id="desenvolvedores-link"
				onclick="toggleDropdown(event, 'desenvolvedores-dropdown')">
					Desenvolvedores <span class="arrow">▾</span>
			</a>
				<ul id="desenvolvedores-dropdown" class="dropdown">
					<li><a
						href="${pageContext.request.contextPath}/paginas/adm/cadastroDev.jsp">Cadastrar</a></li>
					<li><a
						href="${pageContext.request.contextPath}/paginas/adm/listaDev.jsp">Ver
							mais</a></li>
				</ul></li>

			</li>


			<li id="link1" class="link"><a
				href="${pageContext.request.contextPath}/paginas/tarefa/listaTarefa.jsp">Tarefas</a></li>

			<!-- Menu Dropdown de Tipos de Tarefas -->
			<li class="link"><a href="#" id="tipos-tarefas-link"
				onclick="toggleDropdown(event, 'tipos-tarefas-dropdown')"> Tipos
					de Tarefas <span class="arrow">▾</span>
			</a>
				<ul id="tipos-tarefas-dropdown" class="dropdown">
					<li><a
						href="${pageContext.request.contextPath}/paginas/tarefa/cadastroTipoTarefa.jsp">Cadastrar</a></li>
					<li><a
						href="${pageContext.request.contextPath}/paginas/tarefa/listaTipoTarefa.jsp">Ver
							tipos</a></li>
				</ul></li>
		</ul>


		<div class="profile">
			<div>
				<a href="#"> <%
 Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
 if (usuarioLogado != null) {
 	out.println("<p>" + usuarioLogado.getUsername() + "</p>");
 } else {
 	response.sendRedirect(request.getContextPath() + "/index.jsp?error= notLogged");
 	return;
 }
 %>
				</a>
				<p>Analista</p>
			</div>
		</div>

		<a href="${pageContext.request.contextPath}/servlet?action=logout">
			<button class="btn">Logout</button>
		</a>
	</nav>

	<header class="container">
		<div class="content">
			<span class="blur"></span> <span class="blur"></span>
			<H1>
				<%
				out.println("<h1>Olá, " + usuarioLogado.getUsername() + ".</h1>");
				%>
			</H1>

			<button class="btn">Dashboard</button>
		</div>

	</header>

	<section class="container">
		<h2 class="header">TECNOLOGIAS USADAS</h2>
		<div class="features">
			<div class="card">
				<span><img width="48" height="48"
					src="https://img.icons8.com/color/48/html-5--v1.png"
					alt="html-5--v1" /></span>
				<h4>HTML</h4>
				<p>é uma linguagem de marcação utilizada na construção de
					páginas na Web</p>

			</div>
			<div class="card">
				<span><img width="48" height="48"
					src="https://img.icons8.com/fluency/48/java-coffee-cup-logo.png"
					alt="java-coffee-cup-logo" /></span>
				<h4>JAVA</h4>
				<p>é uma linguagem orientada a objetos desenvolvida, por uma
					equipe de programadores chefiada por James Gosling.</p>

			</div>
			<div class="card">
				<span><img width="48" height="48"
					src="https://img.icons8.com/color/48/css3.png" alt="css3" /></span>
				<h4>CSS</h4>
				<p>é um mecanismo para adicionar estilos a uma página web,
					aplicado diretamente nas tags HTML ou ficar contido dentro das tags
					style.</p>

			</div>
			<div class="card">
				<span><img width="48" height="48"
					src="https://img.icons8.com/fluency/48/javascript.png"
					alt="javascript" /></span>
				<h4>JAVASCRIPT</h4>
				<p>é uma linguagem de programação interpretada estruturada , de
					script em alto nível com tipagem dinâmica fraca e multiparadigma</p>

			</div>
		</div>
	</section>

	<div class="copyright">Copyright © 2024 SoftLeve. All Rights
		Reserved.</div>

	<script src="${pageContext.request.contextPath}/js/site.js" defer></script>
</body>

</html>
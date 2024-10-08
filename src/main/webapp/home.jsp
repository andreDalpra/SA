
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>
    <div class="container">
        <h1>Bem-vindo</h1> 
        <a href="usuariosAtivos.jsp"><button class="btn">Usuários Ativos</button></a>
        <a href="usuariosBloqueados.jsp"><button class="btn">Usuários Bloqueados</button></a>
        <a href="index.jsp"><button class="btn">Voltar</button></a>
    </div>
</body>
</html>

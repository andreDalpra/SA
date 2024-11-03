<%@ page import="br.senai.SoftLeve.entidade.usuario.Usuario"%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/site.css">
    <title>Soft Leve</title>
</head>

<body>

    <nav>
        <div class="nav-logo">
            <a href="#">
                <img src="img/Logo.png">
            </a>
        </div>

        <ul class="nav-links">
            <li class="link"><a href="#">Usuários</a></li>
            <li id="link1" class="link"><a href="#">Desenvolvedores</a></li>
            <li id="link2" class="link"><a href="#">Tarefas</a></li>
            <li id="link3" class="link"><a href="#">Tipos de Tarefas</a></li>
        </ul>
        <div class="profile">
                <div>   
                    <a href="#"><% 
            // Recuperando o usuário da sessão
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

            if (usuarioLogado != null) {
                out.println("<p>" + usuarioLogado.getUsername() +"</p>");
            } else {
                // Se o usuário não estiver logado, redireciona para a página de login
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=notLogged");
                return; // Certifica-se de que o redirecionamento aconteça e o restante da página não seja executado
            }
        %></a>
                    <p>Administrador</p>
                </div>
            </div>
            <i class='bx bx-chevron-down'></i>
        </div> 

        <button class="btn"><b>Logout</b></button>
    </nav>

    <header class="container">
        <div class="content">
            <span class="blur"></span>
            <span class="blur"></span>
            <H1><%            
                out.println("<h1>Olá, " + usuarioLogado.getUsername() +".</h1>");
        %></H1>
          
            <button class="btn"><b>Dashboard</b></button>
        </div>
        
    </header>

    <section class="container">
        <h2 class="header">OUR FEATURES</h2>
        <div class="features">
            <div class="card">
                <span><i class="ri-money-dollar-box-line"></i></span>
                <h4>Free Tutorials</h4>
                <p>
                    My tutorials in my channel "AsmrProg" are free and you don't need to pay anything.
                </p>
                <a href="#">Join Now <i class="ri-arrow-right-line"></i></a>
            </div>
            <div class="card">
                <span><i class="ri-bug-line"></i></span>
                <h4>Fix Your Bugs</h4>
                <p>
                    You have any problem in your codes? Tell me, i will help you fix it.
                </p>
                <a href="#">Join Now <i class="ri-arrow-right-line"></i></a>
            </div>
            <div class="card">
                <span><i class="ri-history-line"></i></span>
                <h4>On Time Videos</h4>
                <p>
                    We have video each 4 days, So check channel every 4 days to watch it!
                </p>
                <a href="#">Join Now <i class="ri-arrow-right-line"></i></a>
            </div>
            <div class="card">
                <span><i class="ri-shake-hands-line"></i></span>
                <h4>Cooperation</h4>
                <p>
                    You want we work together? Write email to us, we will read it.
                </p>
                <a href="#">Join Now <i class="ri-arrow-right-line"></i></a>
            </div>
        </div>
    </section>

    

  

    <div class="copyright">
        Copyright © 2024 SoftLeve. All Rights Reserved.
    </div>


    <script src="${pageContext.request.contextPath}/js/site.js"></script>
</body>

</html>
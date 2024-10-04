<%@page import="br.senai.F1Devs.entidade.Usuario"%>
<%
    String vUser =  request.getParameter("username");
    String vPass =  request.getParameter("password");
    
    Usuario u = new Usuario();
    
    u.setUsername(vUser);
    u.setPassword(vPass);
    
    if (u.incluirUsuario()){
        
        response.sendRedirect("index.html");
    }
    

%>O
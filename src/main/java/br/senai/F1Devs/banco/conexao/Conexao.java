package br.senai.F1Devs.banco.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
    public static Connection conectar() throws ClassNotFoundException {
        Connection con = null;
        String url = "jdbc:mysql://localhost:3306/loginportfolio?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = ""; // Senha nula
        
        try {
            // Registrar o driver do MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Conexão bem-sucedida com o banco de dados.");
        } catch (SQLException ex) {
            System.out.println("Erro ao conectar com o banco: " + ex.getMessage());
        }
        
        return con;
    }
}

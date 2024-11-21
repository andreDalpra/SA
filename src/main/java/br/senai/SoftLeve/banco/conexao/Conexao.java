package br.senai.SoftLeve.banco.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
	//Classe conexão ao banco com uma mensagem caso confirmando que a conexão ocorreu com exito
    public static Connection conectar() throws ClassNotFoundException {
        Connection con = null;
        String url = "jdbc:mysql://localhost:3306/softleve?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "12345"; 
        
        try {
           
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Conexão bem-sucedida com o banco de dados.");
        } catch (SQLException ex) {
            System.out.println("Erro ao conectar com o banco: " + ex.getMessage());
        }
        
        return con;
    }
}

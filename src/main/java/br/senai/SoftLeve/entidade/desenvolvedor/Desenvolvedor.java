	package br.senai.SoftLeve.entidade.desenvolvedor;
	
	import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.senai.SoftLeve.banco.conexao.Conexao;
	
	public class Desenvolvedor {
	
		private int id;
		private String nome;
		private String usuario_email;
		private int usuario_id;
		
		public boolean incluirDev() throws ClassNotFoundException {
		    // Primeiro, busca o usuario_id com base no usuario_email fornecido
		    String buscarUsuarioIdSQL = "SELECT id FROM usuario WHERE email = ?";
		    try (Connection con = Conexao.conectar();
		         PreparedStatement buscarStmt = con.prepareStatement(buscarUsuarioIdSQL)) {
		        
		        buscarStmt.setString(1, this.getUsuario_email());
		        ResultSet rs = buscarStmt.executeQuery();
		        
		        if (rs.next()) {
		            this.usuario_id = rs.getInt("id"); // Armazena o usuario_id encontrado
		        } else {
		            System.out.println("Usuário não encontrado para o email fornecido.");
		            return false; // Retorna false se o usuário não for encontrado
		        }
		        
		    } catch (SQLException e) {
		        System.out.println("Erro ao buscar o ID do usuário: " + e.getMessage());
		        return false;
		    }

		    // Em seguida, insere o desenvolvedor na tabela com os dados obtidos
		    String sql = "INSERT INTO desenvolvedor (nome, usuario_email, usuario_id) VALUES (?, ?, ?)";
		    try (Connection con = Conexao.conectar();
		         PreparedStatement stm = con.prepareStatement(sql)) {
		        
		        stm.setString(1, this.getNome());
		        stm.setString(2, this.getUsuario_email());
		        stm.setInt(3, this.getUsuario_id());
		        stm.executeUpdate(); // Executa a inserção do desenvolvedor
		        
		    } catch (SQLException e) {
		        System.out.println("Erro na inclusão do desenvolvedor: " + e.getMessage());
		        return false;
		    }
		    return true;
		}


	
		public int getId() {
			return id;
		}
	
		public void setId(int id) {
			this.id = id;
		}
	
		public String getNome() {
			return nome;
		}
	
		public void setNome(String nome) {
			this.nome = nome;
		}
	
		public String getUsuario_email() {
			return usuario_email;
		}
	
		public void setUsuario_email(String usuario_email) {
			this.usuario_email = usuario_email;
		}
	
		public int getUsuario_id() {
			return usuario_id;
		}
	
		public void setUsuario_id(int usuario_id) {
			this.usuario_id = usuario_id;
		}
		
		
	}

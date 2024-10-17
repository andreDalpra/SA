package br.senai.SoftLeve.entidade.desenvolvedor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.senai.SoftLeve.banco.conexao.Conexao;


public class Desenvolvedor {

	private int id;
	private String nome;
	private String usuario_email;
	private int usuario_id;

	public boolean incluirDev() throws ClassNotFoundException {
		// Primeiro, busca o usuario_id com base no usuario_email fornecido
		String buscarUsuarioIdSQL = "SELECT id FROM usuario WHERE email = ? and nivel = 1";
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
		try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {

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
	
	public boolean alterarDev() throws ClassNotFoundException {
	    String sql = "UPDATE desenvolvedor SET nome = ?, usuario_email = ? WHERE id = ?"; // Corrigido
	    Connection con = Conexao.conectar();
	    try {
	        PreparedStatement stm = con.prepareStatement(sql);
	        stm.setString(1, this.getNome());
	        stm.setString(2, this.getUsuario_email()); // Adiciona o email do usuário
	        stm.setInt(3, this.getId()); // Define o ID do desenvolvedor a ser atualizado
	        int rowsUpdated = stm.executeUpdate(); // Execute o update
	        return rowsUpdated > 0; // Retorna true se a atualização for bem-sucedida
	    } catch (SQLException e) {
	        System.out.println("Erro na alteração do desenvolvedor: " + e.getMessage());
	        return false;
	    } finally {
	        try {
	            con.close(); // Fecha a conexão
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	
	 public boolean excluirDev() throws ClassNotFoundException {
	        String sql = "DELETE FROM desenvolvedor ";
	        sql += "WHERE id = ? ";
	        Connection con = Conexao.conectar();
	        try {
	            PreparedStatement stm = con.prepareStatement(sql);
	            stm.setInt(1, this.getId());
	            stm.execute();
	        } catch (SQLException e) {
	            System.out.println("Erro na exclusão do desenvoldedor");
	            return false;
	        }
	        return true;
	    }


	public List<Desenvolvedor> listarDev() throws ClassNotFoundException {
	    List<Desenvolvedor> listarDev = new ArrayList<>();
	    Connection con = Conexao.conectar();
	    String sql = "SELECT id, nome, usuario_email, usuario_id FROM desenvolvedor ORDER BY id";
	    try {
	        PreparedStatement stm = con.prepareStatement(sql);
	        ResultSet rs = stm.executeQuery();
	        while (rs.next()) {
	            Desenvolvedor dev = new Desenvolvedor();
	            dev.setId(rs.getInt("id"));
	            dev.setNome(rs.getString("nome"));
	            dev.setUsuario_email(rs.getString("usuario_email"));
	            dev.setUsuario_id(rs.getInt("usuario_id"));
	            listarDev.add(dev);
	        }
	    } catch (SQLException e) {
	        System.out.println("Erro na lista de Desenvolvedores: " + e.getMessage());
	        e.printStackTrace(); // Adicionado para detalhar a exceção no console.
	        return null;
	    }
	    return listarDev;
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

package br.senai.SoftLeve.entidade.tipotarefa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.senai.SoftLeve.banco.conexao.Conexao;

public class TipoTarefa {
	
	private int id ;
	private String descricao;
	
	public boolean incluirTipoTarefa() throws ClassNotFoundException {
        String sql = "INSERT INTO tipotarefa (descricao) VALUES (?)";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, this.getDescricao());
            stm.executeUpdate(); // Use executeUpdate() para INSERT
        } catch (SQLException e) {
            System.out.println("Erro na inclusão do tipo da tarefa: " + e.getMessage());
            return false;
        }
        return true;
    }
	
	public boolean alterarTipoTarefa() throws ClassNotFoundException {
	    String sql = "UPDATE tipotarefa SET descricao = ? WHERE id = ?"; // Corrigido
	    Connection con = Conexao.conectar();
	    try {
	        PreparedStatement stm = con.prepareStatement(sql);
	        stm.setString(1, this.getDescricao());	        
	        stm.setInt(2, this.getId()); // Define o ID do desenvolvedor a ser atualizado
	        int rowsUpdated = stm.executeUpdate(); // Execute o update
	        return rowsUpdated > 0; // Retorna true se a atualização for bem-sucedida
	    } catch (SQLException e) {
	        System.out.println("Erro na alteração do tipo da taerfa: " + e.getMessage());
	        return false;
	    } finally {
	        try {
	            con.close(); // Fecha a conexão
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	public boolean excluirTipoTarefa() throws ClassNotFoundException {
        String sql = "DELETE FROM tipotarefa ";
        sql += "WHERE id = ? ";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.getId());
            stm.execute();
        } catch (SQLException e) {
            System.out.println("Erro na exclusão do tipo da tarefa");
            return false;
        }
        return true;
    }
	
	public List<TipoTarefa> listarTiposTarefa() throws ClassNotFoundException {
	    List<TipoTarefa> listarTiposTarefa = new ArrayList<>();
	    Connection con = Conexao.conectar();
	    String sql = "SELECT id, descricao FROM tipotarefa ORDER BY id";
	    try {
	        PreparedStatement stm = con.prepareStatement(sql);
	        ResultSet rs = stm.executeQuery();
	        while (rs.next()) {
	            TipoTarefa tt = new TipoTarefa();
	            tt.setId(rs.getInt("id"));
	            tt.setDescricao(rs.getString("descricao"));
	            
	            listarTiposTarefa.add(tt);
	        }
	    } catch (SQLException e) {
	        System.out.println("Erro na lista de tipos de tarefa: " + e.getMessage());
	        e.printStackTrace(); // Adicionado para detalhar a exceção no console.
	        return null;
	    }
	    return listarTiposTarefa;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	
}	

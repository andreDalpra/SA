package br.senai.SoftLeve.entidade.tarefa;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.senai.SoftLeve.banco.conexao.Conexao;

public class Tarefa {
    
    private int id;
    private String descricao;
    private Status status;
    private Date prazo;
    private int desenvolvedor_id;
    private int tipotarefa_id;
    
    // Atualizando o enum para corresponder aos valores do banco de dados
    public static enum Status {
        PENDENTE("PENDENTE"),
        EM_ANDAMENTO("EM_ANDAMENTO"),
        CONCLUIDA("CONCLUIDA"),
        ATRASADA("ATRASADA");
    


        private String value;

        Status(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }

        public static Status fromString(String statusStr) {
            if (statusStr == null) {
                throw new IllegalArgumentException("Status não pode ser nulo");
            }
            System.out.println("Status recebido para conversão: " + statusStr); // Para depuração
            switch (statusStr.toUpperCase()) {
                case "PENDENTE":
                    return PENDENTE;
                case "EM_ANDAMENTO":
                    return EM_ANDAMENTO;
                case "CONCLUIDA": // Verifique se a string está exatamente como no enum
                    return CONCLUIDA;
                case "ATRASADA":
                    return ATRASADA;
                default:
                    throw new IllegalArgumentException("Status inválido: " + statusStr);
            }
        }


    }


    public boolean incluirTarefa() throws ClassNotFoundException {
        if (this.getStatus() == null) {
            System.out.println("Erro: Status da tarefa não pode ser nulo.");
            return false;
        }

        String sql = "INSERT INTO Tarefa (descricao, status, prazo, desenvolvedor_id, tipo_tarefa_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, this.getDescricao());
            stm.setString(2, this.getStatus().getValue()); // Usa getValue() para garantir a correspondência
            stm.setDate(3, this.getPrazo());
            stm.setInt(4, this.getDesenvolvedor_id());
            stm.setInt(5, this.getTipotarefa_id());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro na inclusão da tarefa: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean alterarTarefa() throws ClassNotFoundException {
        String sql = "UPDATE tarefa SET descricao = ?, status = ?, prazo = ?, desenvolvedor_id = ?, tipo_tarefa_id = ? WHERE id = ?";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, this.getDescricao());
            stm.setString(2, this.getStatus().getValue()); // Usa getValue() para garantir a correspondência
            stm.setDate(3, this.getPrazo());
            stm.setInt(4, this.getDesenvolvedor_id());
            stm.setInt(5, this.getTipotarefa_id());
            stm.setInt(6, this.getId());
            int rowsUpdated = stm.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("Erro na alteração da tarefa: " + e.getMessage());
            return false;
        }
    }
    
    public boolean alterarTarefaDev() throws ClassNotFoundException {
        String sql = "UPDATE tarefa SET descricao = ?, status = ? WHERE id = ?";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, this.getDescricao());
            stm.setString(2, this.getStatus().getValue()); // Usa getValue() para garantir a correspondência
            stm.setInt(3, this.getId());
            int rowsUpdated = stm.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("Erro na alteração da tarefa: " + e.getMessage());
            return false;
        }
    }
    
    public boolean excluirTarefa() throws ClassNotFoundException {
        String sql = "DELETE FROM tarefa WHERE id = ?";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setInt(1, this.getId());
            stm.execute();
        } catch (SQLException e) {
            System.out.println("Erro na exclusão da tarefa: " + e.getMessage());
            return false;
        }
        return true;
    }
    
    public List<Tarefa> listarTarefas() throws ClassNotFoundException {
        List<Tarefa> listaTarefas = new ArrayList<>();
        String sql = "SELECT id, descricao, status, prazo, desenvolvedor_id, tipo_tarefa_id FROM tarefa ORDER BY id";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Tarefa tarefa = new Tarefa();
                tarefa.setId(rs.getInt("id"));
                tarefa.setDescricao(rs.getString("descricao"));
                // Converte o status usando o método fromString para lidar com diferenças nos valores
                tarefa.setStatus(Tarefa.Status.fromString(rs.getString("status")));
                tarefa.setPrazo(rs.getDate("prazo"));
                tarefa.setDesenvolvedor_id(rs.getInt("desenvolvedor_id"));
                tarefa.setTipotarefa_id(rs.getInt("tipo_tarefa_id"));
                listaTarefas.add(tarefa);
            }
        } catch (SQLException e) {
            System.out.println("Erro ao listar as tarefas: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        return listaTarefas;
    }
    
    public static List<Tarefa> tarefasDevs(int desenvolvedorId) throws ClassNotFoundException {
        List<Tarefa> tarefasDev = new ArrayList<>();
        String sql = "SELECT id, descricao, status, prazo, desenvolvedor_id, tipo_tarefa_id FROM tarefa WHERE desenvolvedor_id = ?";

        try (Connection con = Conexao.conectar();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, desenvolvedorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
            	Tarefa tarefa = new Tarefa();
                tarefa.setId(rs.getInt("id"));
                tarefa.setDescricao(rs.getString("descricao"));
                // Converte o status usando o método fromString para lidar com diferenças nos valores
                tarefa.setStatus(Tarefa.Status.fromString(rs.getString("status")));
                tarefa.setPrazo(rs.getDate("prazo"));
                tarefa.setDesenvolvedor_id(rs.getInt("desenvolvedor_id"));
                tarefa.setTipotarefa_id(rs.getInt("tipo_tarefa_id"));
                tarefasDev.add(tarefa);
            }
        } catch (SQLException e) {
            System.out.println("Erro ao listar tarefas: " + e.getMessage());
        }

        return tarefasDev;
    }
    
    public static String buscarNomePorDevId(int devId) throws ClassNotFoundException {
        String nome = null;
        String sql = "SELECT nome FROM desenvolvedor WHERE id = ?";

        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, devId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    nome = rs.getString("nome");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return nome;
    }
    
    public static String buscarTipoTarefaPorId(int tipoId) throws ClassNotFoundException {
        String descricao = null;
        String sql = "SELECT descricao FROM tipotarefa WHERE id = ?";

        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tipoId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    descricao = rs.getString("descricao");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return descricao;
    }


    // Getters e Setters
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

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Date getPrazo() {
        return prazo;
    }

    public void setPrazo(Date prazo) {
        this.prazo = prazo;
    }

    public int getDesenvolvedor_id() {
        return desenvolvedor_id;
    }

    public void setDesenvolvedor_id(int desenvolvedor_id) {
        this.desenvolvedor_id = desenvolvedor_id;
    }

    public int getTipotarefa_id() {
        return tipotarefa_id;
    }

    public void setTipotarefa_id(int tipotarefa_id) {
        this.tipotarefa_id = tipotarefa_id;
    }
}

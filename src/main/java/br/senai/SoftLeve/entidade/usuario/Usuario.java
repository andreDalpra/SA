package br.senai.SoftLeve.entidade.usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.senai.SoftLeve.banco.conexao.Conexao;
import br.senai.SoftLeve.entidade.desenvolvedor.Desenvolvedor;

public class Usuario {

    private int id;
    private String username;
    private String password;
    private String email;
    private boolean bloqueado = false;
    private boolean ativo = true;
    private int nivel = 0;
    private int tentativas = 0; // Contador de tentativas

    // Inclusão de Usuario
    public boolean incluirUsuario() throws ClassNotFoundException {
        String sql = "INSERT INTO usuario (username, password, email, bloqueado, ativo, nivel, tentativas) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, this.getUsername());
            stm.setString(2, this.getPassword());
            stm.setString(3, this.getEmail());
            stm.setBoolean(4, this.isBloqueado());
            stm.setBoolean(5, this.isAtivo());
            stm.setInt(6,this.getNivel());
            stm.setInt(7, this.getTentativas()); // Armazena tentativas ao incluir
            stm.executeUpdate(); // Use executeUpdate() para INSERT
        } catch (SQLException e) {
            System.out.println("Erro na inclusão do usuário: " + e.getMessage());
            return false;
        }
        return true;
    }

    // Autenticação do usuário
    public boolean autenticarUsuario() throws ClassNotFoundException {
        Connection con = Conexao.conectar();
        String sql = "SELECT id, username, password, email, bloqueado, ativo, nivel, tentativas FROM usuario WHERE username = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.getUsername());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("id"); // Pega o ID do usuário
                boolean bloqueado = rs.getBoolean("bloqueado");
                this.tentativas = rs.getInt("tentativas"); // Carrega tentativas do banco

                if (bloqueado) {
                    return false; // Usuário está bloqueado
                }

                // Verifica a senha
                if (rs.getString("password").equals(this.getPassword())) {
                    this.setId(userId); // Atribui o ID ao objeto Usuario
                    this.setnivel(rs.getInt("nivel")); // Armazena o nível do usuário após autenticar
                    this.setEmail(rs.getString("email")); // Armazena o email para futuras operações
                    resetarTentativas(); // Reseta tentativas ao logar
                    atualizarTentativas(userId, 0); // Reseta tentativas no banco
                    return true; // Login bem-sucedido
                } else {
                    incrementarTentativas();
                    if (this.tentativas >= 3) {
                        bloquearUsuario(userId); // Bloqueia o usuário após 3 tentativas
                    } else {
                        atualizarTentativas(userId, this.tentativas); // Atualiza tentativas no banco
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro na consulta do usuario: " + e.getMessage());
            return false;
        }
        return false; // Login mal-sucedido
    }

    
    public Desenvolvedor buscarDesenvolvedorPorId(int usuarioId) throws ClassNotFoundException {
        Desenvolvedor desenvolvedor = null;

        String sql = "SELECT id, nome, usuario_email, usuario_id FROM desenvolvedor WHERE usuario_id = ?";

        try (Connection con = Conexao.conectar();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, usuarioId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                desenvolvedor = new Desenvolvedor();
                desenvolvedor.setId(rs.getInt("id"));
                desenvolvedor.setNome(rs.getString("nome"));
                desenvolvedor.setUsuario_email(rs.getString("usuario_email"));
                desenvolvedor.setUsuario_id(rs.getInt("usuario_id"));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar desenvolvedor: " + e.getMessage());
        }

        return desenvolvedor;
    }



    // Atualizar tentativas
    public void atualizarTentativas(int id, int tentativas) throws ClassNotFoundException {
        String sql = "UPDATE usuario SET tentativas = ? WHERE id = ?";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setInt(1, tentativas);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro ao atualizar tentativas: " + e.getMessage());
        }
    }

    // Bloquear usuário
    public boolean bloquearUsuario(int id) throws ClassNotFoundException {
        String sql = "UPDATE usuario SET bloqueado = ?, tentativas = ? WHERE id = ?";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setBoolean(1, true); // Bloqueia o usuário
            stm.setInt(2, 0); // Reseta tentativas ao bloquear
            stm.setInt(3, id);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Erro ao bloquear usuário: " + e.getMessage());
            return false;
        }
    }

    // Desbloquear usuário
    public boolean desbloquearUsuario(String username, String novaSenha) throws ClassNotFoundException {
        String sql = "UPDATE usuario SET bloqueado = ?, password = ?, tentativas = ? WHERE username = ?";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setBoolean(1, false); // Desbloqueia o usuário
            stm.setString(2, novaSenha); // Atualiza a senha do usuário
            stm.setInt(3, 0); // Reseta o número de tentativas
            stm.setString(4, username); // Usa o username ao invés do ID
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Erro ao desbloquear usuário: " + e.getMessage());
            return false;
        }
    }

    // Listar usuários ativos
    private List<Usuario> listarUsuarios(boolean bloqueado) throws ClassNotFoundException {
        List<Usuario> listarUsuarios = new ArrayList<>();
        String sql = "SELECT id, username, password FROM usuario WHERE bloqueado = ? ORDER BY id";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setBoolean(1, bloqueado);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                listarUsuarios.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Erro na lista de usuários: " + e.getMessage());
            return null;
        }
        return listarUsuarios;
    }

    // Métodos públicos
    public List<Usuario> listarUsuariosAtivos() throws ClassNotFoundException {
        return listarUsuarios(false);
    }

    public List<Usuario> listarUsuariosBloqueados() throws ClassNotFoundException {
        return listarUsuarios(true);
    }
    
    public List<Usuario> listarUsuariosDev() throws ClassNotFoundException { 
        List<Usuario> listarUsuariosDev = new ArrayList<>();
        String sql = "SELECT id, username, nivel  FROM usuario WHERE nivel = 1 ORDER BY id";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));             
                u.setUsername(rs.getString("username"));
                u.setnivel(rs.getInt("nivel"));
                listarUsuariosDev.add(u);
            }
            System.out.println("Total de usuários encontrados: " + listarUsuariosDev.size());
        } catch (SQLException e) {
            System.out.println("Erro na lista de usuários: " + e.getMessage());
            return null;
        }
        return listarUsuariosDev;
    }
    
    public List<Usuario> listarUsuariosDevEmail() throws ClassNotFoundException { 
        List<Usuario> listarUsuariosDev = new ArrayList<>();
        String sql = "SELECT id, email, nivel  FROM usuario WHERE nivel = 1 ORDER BY id";
        try (Connection con = Conexao.conectar(); PreparedStatement stm = con.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));             
                u.setEmail(rs.getString("email"));
                u.setnivel(rs.getInt("nivel"));
                listarUsuariosDev.add(u);
            }
            System.out.println("Total de usuários encontrados: " + listarUsuariosDev.size());
        } catch (SQLException e) {
            System.out.println("Erro na lista de usuários: " + e.getMessage());
            return null;
        }
        return listarUsuariosDev;
    }
    
    
    // Incrementar tentativas
    public void incrementarTentativas() {
        this.tentativas++;
    }

    // Resetar tentativas
    public void resetarTentativas() {
        this.tentativas = 0;
    }

    // Getters e Setters
    public int getTentativas() {
        return tentativas;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isBloqueado() {
        return bloqueado;
    }

    public void setBloqueado(boolean bloqueado) {
        this.bloqueado = bloqueado;
    }

	public boolean isAtivo() {
		return ativo;
	}

	public void setAtivo(boolean ativo) {
		this.ativo = ativo;
	}

	public int getNivel() {
		return nivel;
	}

	public void setnivel(int nivel) {
		this.nivel = nivel;
	}
        
}

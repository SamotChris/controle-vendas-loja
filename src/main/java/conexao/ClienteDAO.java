/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Christopher
 */

package conexao;

import conexao.Conexao;
import conexao.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    // Listar todos os clientes
    public List<String> listarClientes() {
        List<String> clientes = new ArrayList<>();
        String sql = "SELECT id, nome, email, telefone FROM clientes";

        try (Connection conn = Conexao.conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String cliente = String.format(
                    "ID: %d | Nome: %s | Email: %s | Telefone: %s",
                    rs.getInt("id"),
                    rs.getString("nome"),
                    rs.getString("email"),
                    rs.getString("telefone")
                );
                clientes.add(cliente);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao listar clientes: " + e.getMessage());
        }

        return clientes;
    }

    // Inserir um novo cliente
public void inserirCliente(String nome, String email, String telefone) throws SQLException {
    System.out.println("Dados recebidos no DAO: Nome=" + nome + ", Email=" + email + ", Telefone=" + telefone);

    String sql = "INSERT INTO clientes (nome, email, telefone) VALUES (?, ?, ?)";

    try (Connection conn = Conexao.conectar();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, nome);
        stmt.setString(2, email);
        stmt.setString(3, telefone);

        int linhasAfetadas = stmt.executeUpdate();

        if (linhasAfetadas > 0) {
            System.out.println("Cliente cadastrado com sucesso!");
        } else {
            System.err.println("Nenhuma linha foi afetada.");
        }
    } catch (SQLException e) {
        System.err.println("Erro ao inserir cliente: " + e.getMessage());
    }
}



}




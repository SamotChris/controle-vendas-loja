/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexao;
/**
 *
 * @author Christopher
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EstoqueDAO {

    public void inserirProduto(String nome, int quantidade, double preco) throws SQLException {
    String sql = "INSERT INTO estoque (nome, quantidade, preco) VALUES (?, ?, ?)";

    try (Connection conn = Conexao.conectar();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, nome);
        stmt.setInt(2, quantidade);
        stmt.setDouble(3, preco);
        stmt.executeUpdate();

        System.out.println("Produto cadastrado com sucesso!");
    } catch (SQLException e) {
        System.err.println("Erro ao inserir produto: " + e.getMessage());
        throw e; // Repassa exceção para o chamador
    }
}

}

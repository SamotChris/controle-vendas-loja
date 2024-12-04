/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Christopher
 */


package conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class VendaDAO {

    // Método para registrar uma venda
    public void registrarVenda(int clienteId, int produtoId, int quantidade) throws SQLException {
        // Consulta para obter preço e estoque do produto
        String sqlSelectProduto = "SELECT preco, quantidade FROM produtos WHERE id = ?";
        // Inserir a venda
        String sqlInsertVenda = "INSERT INTO vendas (cliente_id, produto_id, quantidade, total, data_venda) VALUES (?, ?, ?, ?, CURDATE())";
        // Atualizar o estoque
        String sqlUpdateEstoque = "UPDATE produtos SET quantidade = quantidade - ? WHERE id = ?";

        try (Connection conn = Conexao.conectar();
             PreparedStatement stmtSelectProduto = conn.prepareStatement(sqlSelectProduto);
             PreparedStatement stmtInsertVenda = conn.prepareStatement(sqlInsertVenda);
             PreparedStatement stmtUpdateEstoque = conn.prepareStatement(sqlUpdateEstoque)) {

            // Obter preço e quantidade do produto
            stmtSelectProduto.setInt(1, produtoId);
            ResultSet rs = stmtSelectProduto.executeQuery();

            if (rs.next()) {
                double preco = rs.getDouble("preco");
                int estoqueAtual = rs.getInt("quantidade");

                // Verificar estoque suficiente
                if (estoqueAtual < quantidade) {
                    throw new SQLException("Estoque insuficiente para o produto ID: " + produtoId);
                }

                double total = preco * quantidade;

                // Inserir a venda
                stmtInsertVenda.setInt(1, clienteId);
                stmtInsertVenda.setInt(2, produtoId);
                stmtInsertVenda.setInt(3, quantidade);
                stmtInsertVenda.setDouble(4, total);
                stmtInsertVenda.executeUpdate();

                // Atualizar o estoque
                stmtUpdateEstoque.setInt(1, quantidade);
                stmtUpdateEstoque.setInt(2, produtoId);
                stmtUpdateEstoque.executeUpdate();

                System.out.println("Venda registrada com sucesso!");
            } else {
                throw new SQLException("Produto não encontrado para o ID: " + produtoId);
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao registrar venda: " + e.getMessage(), e);
        }
    }

    // Método para listar vendas
public List<String> listarVendas() {
    List<String> vendas = new ArrayList<>();
    String sql = "SELECT v.id, c.nome AS cliente, p.nome AS produto, v.quantidade, v.total, v.data_venda " +
                 "FROM vendas v " +
                 "JOIN clientes c ON v.cliente_id = c.id " +
                 "JOIN estoque p ON v.produto_id = p.id";

    try (Connection conn = Conexao.conectar();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {

        while (rs.next()) {
            String venda = String.format("ID: %d | Cliente: %s | Produto: %s | Quantidade: %d | Total: %.2f | Data: %s",
                rs.getInt("id"),
                rs.getString("cliente"),
                rs.getString("produto"),
                rs.getInt("quantidade"),
                rs.getDouble("total"),
                rs.getDate("data_venda").toString()
            );
            vendas.add(venda);
        }
    } catch (SQLException e) {
        System.err.println("Erro ao listar vendas: " + e.getMessage());
    }

    return vendas;
}

}






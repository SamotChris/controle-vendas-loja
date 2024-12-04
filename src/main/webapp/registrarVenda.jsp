<%-- 
    Document   : registrarVenda
    Created on : 3 de dez. de 2024, 22:25:51
    Author     : Christopher
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="conexao.Conexao" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Registrar Venda</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>Registrar Venda</h1>
    </header>
    <main>
        <%
            String nomeCliente = request.getParameter("nomeCliente");
            String nomeProduto = request.getParameter("nomeProduto");
            int quantidade = Integer.parseInt(request.getParameter("quantidade"));
            String mensagem = "";

            if (nomeCliente != null && nomeProduto != null && quantidade > 0) {
                String sqlCliente = "SELECT id FROM clientes WHERE nome = ?";
                String sqlProduto = "SELECT id, preco FROM estoque WHERE produto = ?";
                String sqlVenda = "INSERT INTO vendas (cliente_id, produto_id, quantidade, total, data_venda) VALUES (?, ?, ?, ?, CURDATE())";

                try (Connection conn = Conexao.conectar();
                     PreparedStatement stmtCliente = conn.prepareStatement(sqlCliente);
                     PreparedStatement stmtProduto = conn.prepareStatement(sqlProduto);
                     PreparedStatement stmtVenda = conn.prepareStatement(sqlVenda)) {

                    // Buscar o ID do cliente
                    stmtCliente.setString(1, nomeCliente);
                    ResultSet rsCliente = stmtCliente.executeQuery();
                    if (!rsCliente.next()) {
                        mensagem = "Cliente não encontrado!";
                    } else {
                        int clienteId = rsCliente.getInt("id");

                        // Buscar o ID e preço do produto
                        stmtProduto.setString(1, nomeProduto);
                        ResultSet rsProduto = stmtProduto.executeQuery();
                        if (!rsProduto.next()) {
                            mensagem = "Produto não encontrado!";
                        } else {
                            int produtoId = rsProduto.getInt("id");
                            double preco = rsProduto.getDouble("preco");
                            double total = preco * quantidade;

                            // Registrar a venda
                            stmtVenda.setInt(1, clienteId);
                            stmtVenda.setInt(2, produtoId);
                            stmtVenda.setInt(3, quantidade);
                            stmtVenda.setDouble(4, total);
                            stmtVenda.executeUpdate();

                            mensagem = "Venda registrada com sucesso!";
                        }
                    }
                } catch (Exception e) {
                    mensagem = "Erro ao registrar venda: " + e.getMessage();
                }
            } else {
                mensagem = "Dados inválidos!";
            }
        %>
        <p><%= mensagem %></p>
        <a href="vendas.html">Voltar</a>
    </main>
    <footer>
        <p>&copy; 2024 Controle de Vendas</p>
    </footer>
</body>
</html>


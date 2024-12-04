<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="conexao.Conexao" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Venda</title>
</head>
<body>
    <h1>Resultado do Registro de Venda</h1>
    <%
        String nomeCliente = request.getParameter("nomeCliente");
        String nomeProduto = request.getParameter("nomeProduto");
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        int clienteId = -1;
        int produtoId = -1;
        double total = 0.0;

        // SQL para buscar IDs do cliente e do produto e o preço do produto
        String buscarClienteSQL = "SELECT id FROM clientes WHERE nome = ?";
        String buscarProdutoSQL = "SELECT id, preco FROM estoque WHERE produto = ?";
        String registrarVendaSQL = "INSERT INTO vendas (cliente_id, produto_id, quantidade, total, data_venda) VALUES (?, ?, ?, ?, CURDATE())";

        try (Connection conn = Conexao.conectar();
             PreparedStatement buscarClienteStmt = conn.prepareStatement(buscarClienteSQL);
             PreparedStatement buscarProdutoStmt = conn.prepareStatement(buscarProdutoSQL);
             PreparedStatement registrarVendaStmt = conn.prepareStatement(registrarVendaSQL)) {

            // Buscar o ID do cliente pelo nome
            buscarClienteStmt.setString(1, nomeCliente);
            ResultSet clienteRs = buscarClienteStmt.executeQuery();
            if (clienteRs.next()) {
                clienteId = clienteRs.getInt("id");
            } else {
                out.println("<p style='color:red;'>Erro: Cliente não encontrado.</p>");
                return;
            }

            // Buscar o ID e o preço do produto pelo nome
            buscarProdutoStmt.setString(1, nomeProduto);
            ResultSet produtoRs = buscarProdutoStmt.executeQuery();
            if (produtoRs.next()) {
                produtoId = produtoRs.getInt("id");
                double preco = produtoRs.getDouble("preco");
                total = preco * quantidade;
            } else {
                out.println("<p style='color:red;'>Erro: Produto não encontrado.</p>");
                return;
            }

            // Registrar a venda
            registrarVendaStmt.setInt(1, clienteId);
            registrarVendaStmt.setInt(2, produtoId);
            registrarVendaStmt.setInt(3, quantidade);
            registrarVendaStmt.setDouble(4, total);
            registrarVendaStmt.executeUpdate();

            out.println("<p style='color:green;'>Venda registrada com sucesso!</p>");
            out.println("<p>Cliente: " + nomeCliente + "</p>");
            out.println("<p>Produto: " + nomeProduto + "</p>");
            out.println("<p>Quantidade: " + quantidade + "</p>");
            out.println("<p>Total: R$ " + new DecimalFormat("#,##0.00").format(total) + "</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao registrar venda: " + e.getMessage() + "</p>");
        }
    %>
    <a href="vendas.html">Voltar</a>
</body>
</html>

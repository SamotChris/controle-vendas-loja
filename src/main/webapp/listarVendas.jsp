<%-- 
    Document   : vendas realizadas
    Created on : 28 de nov. de 2024, 23:46:59
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Vendas</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>Lista de Vendas</h1>
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="vendas.html">Gestão de Vendas</a></li>
                <li><a href="estoque.jsp">Gestão de Estoque</a></li>
                <li><a href="clientes.html">Gestão de Clientes</a></li>
                <li><a href="listarClientes.jsp">Lista de Clientes</a></li>
                <li><a href="listarVendas.jsp">Lista de Vendas</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <section>
            <h2>Vendas Registradas</h2>
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Produto</th>
                        <th>Quantidade</th>
                        <th>Total</th>
                        <th>Data</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Consulta para buscar as vendas com os nomes dos clientes e produtos
                        String sql = "SELECT v.id, c.nome AS cliente, e.produto AS produto, v.quantidade, v.total, v.data_venda " +
                                     "FROM vendas v " +
                                     "INNER JOIN clientes c ON v.cliente_id = c.id " +
                                     "INNER JOIN estoque e ON v.produto_id = e.id";
                        
                        try (Connection conn = Conexao.conectar();
                             PreparedStatement stmt = conn.prepareStatement(sql);
                             ResultSet rs = stmt.executeQuery()) {
                             
                             while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("cliente") %></td>
                        <td><%= rs.getString("produto") %></td>
                        <td><%= rs.getInt("quantidade") %></td>
                        <td><%= String.format("R$ %.2f", rs.getDouble("total")) %></td>
                        <td><%= rs.getDate("data_venda") %></td>
                    </tr>
                    <%
                             }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='6' style='color:red;'>Erro ao carregar vendas: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Controle de Vendas</p>
    </footer>
</body>
</html>


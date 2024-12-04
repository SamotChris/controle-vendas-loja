<%-- 
    Document   : estoque
    Created on : 3 de dez. de 2024, 22:39:00
    Author     : Christopher
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="conexao.Conexao" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestão de Estoque</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>Gestão de Estoque</h1>
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
            <h2>Produtos no Estoque</h2>
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Produto</th>
                        <th>Quantidade</th>
                        <th>Preço (R$)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String sql = "SELECT id, produto, quantidade, preco FROM estoque";

                        try (Connection conn = Conexao.conectar();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery(sql)) {

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("produto") %></td>
                        <td><%= rs.getInt("quantidade") %></td>
                        <td><%= String.format("%.2f", rs.getDouble("preco")) %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='4' style='color:red;'>Erro ao carregar produtos: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </section>

        <section>
            <h2>Adicionar Produto ao Estoque</h2>
            <form action="RegistrarProduto.jsp" method="post">
                <label for="produto">Nome do Produto:</label>
                <input type="text" id="produto" name="produto" required>
                <br>
                <label for="quantidade">Quantidade:</label>
                <input type="number" id="quantidade" name="quantidade" required>
                <br>
                <label for="preco">Preço (R$):</label>
                <input type="number" step="0.01" id="preco" name="preco" required>
                <br>
                <button type="submit">Adicionar Produto</button>
            </form>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Controle de Vendas</p>
    </footer>
</body>
</html>

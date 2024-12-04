<%-- 
    Document   : produtos
    Created on : 28 de nov. de 2024, 23:48:20
    Author     : Christopher
--%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastro de Produto</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>Resultado do Cadastro</h1>
    <%
        String nome = request.getParameter("nome");
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        double preco = Double.parseDouble(request.getParameter("preco"));

        try {
            Connection conn = conexao.Conexao.conectar();
            String sql = "INSERT INTO produtos (nome, quantidade, preco) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nome);
            stmt.setInt(2, quantidade);
            stmt.setDouble(3, preco);

            int linhas = stmt.executeUpdate();
            if (linhas > 0) {
                out.println("<p>Produto cadastrado com sucesso!</p>");
            } else {
                out.println("<p>Erro ao cadastrar produto.</p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p>Erro: " + e.getMessage() + "</p>");
        }
    %>
    <a href="produtos.html">Voltar</a>
</body>
</html>

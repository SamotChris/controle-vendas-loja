<%-- 
    Document   : RegistrarProduto
    Created on : 3 de dez. de 2024, 22:40:44
    Author     : Christopher
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="conexao.Conexao" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Registrar Produto</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>Registrar Produto</h1>
    </header>
    <main>
        <%
            String produto = request.getParameter("produto");
            String quantidadeStr = request.getParameter("quantidade");
            String precoStr = request.getParameter("preco");

            String mensagem;

            if (produto != null && quantidadeStr != null && precoStr != null) {
                try {
                    int quantidade = Integer.parseInt(quantidadeStr);
                    double preco = Double.parseDouble(precoStr);

                    String sql = "INSERT INTO estoque (produto, quantidade, preco) VALUES (?, ?, ?)";

                    try (Connection conn = Conexao.conectar();
                         PreparedStatement stmt = conn.prepareStatement(sql)) {

                        stmt.setString(1, produto);
                        stmt.setInt(2, quantidade);
                        stmt.setDouble(3, preco);
                        stmt.executeUpdate();
                        mensagem = "Produto cadastrado com sucesso!";
                    }
                } catch (Exception e) {
                    mensagem = "Erro ao cadastrar produto: " + e.getMessage();
                }
            } else {
                mensagem = "Preencha todos os campos!";
            }
        %>
        <p><%= mensagem %></p>
        <a href="estoque.jsp">Voltar</a>
    </main>
    <footer>
        <p>&copy; 2024 Controle de Vendas</p>
    </footer>
</body>
</html>

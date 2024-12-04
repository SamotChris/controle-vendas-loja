<%@ page import="conexao.ClienteDAO" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cadastro de Cliente</title>
    </head>
    <body>
        <h1>Resultado do Cadastro</h1>
        <%
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String telefone = request.getParameter("telefone");

            // Exibe os dados recebidos para depuração
            out.println("<p>Depuração no JSP:</p>");
            out.println("<p>Nome: " + nome + "</p>");
            out.println("<p>Email: " + email + "</p>");
            out.println("<p>Telefone: " + telefone + "</p>");

            try {
                ClienteDAO clienteDAO = new ClienteDAO();
                clienteDAO.inserirCliente(nome, email, telefone);
                out.println("<p style='color:green;'>Cliente cadastrado com sucesso!</p>");
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Erro ao cadastrar cliente: " + e.getMessage() + "</p>");
            }
        %>
        <a href="clientes.html">Voltar</a>
    </body>
</html>

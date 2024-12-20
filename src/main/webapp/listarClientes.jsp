<%@page import="java.util.List"%>
<%@page import="conexao.ClienteDAO"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Clientes</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>Lista de Clientes</h1>
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="vendas.html">Gest�o de Vendas</a></li>
                <li><a href="estoque.jsp">Gest�o de Estoque</a></li>
                <li><a href="clientes.html">Gest�o de Clientes</a></li>
                <li><a href="listarClientes.jsp">Lista de Clientes</a></li>
                <li><a href="listarVendas.jsp">Lista de Vendas</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <section>
            <h2>Clientes Cadastrados</h2>
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>E-mail</th>
                        <th>Telefone</th>
                    </tr>
                </thead>
 <tbody>
                    <% 
                        ClienteDAO clienteDAO = new ClienteDAO();
                        List<String> clientes = clienteDAO.listarClientes();
                        for (String cliente : clientes) {
                            String[] dados = cliente.split(" \\| ");
                            out.println("<tr>");
                            for (String dado : dados) {
                                String[] keyValue = dado.split(": ");
                                if (keyValue.length == 2) {
                                    out.println("<td>" + keyValue[1] + "</td>");
                                }
                            }
                            out.println("</tr>");
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

package conexao;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

// Mapeamento do servlet
@WebServlet("/api/ListarClientes")
public class ListarClientesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        // Lista para armazenar os dados dos clientes
        List<String> clientes = new ArrayList<>();

        // Consulta SQL para buscar os dados
        String sql = "SELECT id, nome, email, telefone FROM clientes";

        try (Connection conn = Conexao.conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            // Monta os dados em formato JSON
            while (rs.next()) {
                String cliente = String.format(
                        "{\"id\":%d,\"nome\":\"%s\",\"email\":\"%s\",\"telefone\":\"%s\"}",
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email"),
                        rs.getString("telefone")
                );
                clientes.add(cliente);
            }
        } catch (Exception e) {
            System.err.println("Erro ao listar clientes: " + e.getMessage());
        }

        // Retorna os dados como JSON
        try (PrintWriter out = response.getWriter()) {
            out.println("[" + String.join(",", clientes) + "]");
        }
    }
}


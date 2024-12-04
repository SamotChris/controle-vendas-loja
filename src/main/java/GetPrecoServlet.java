
import conexao.Conexao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Christopher
 */
@WebServlet("/api/getPreco")
public class GetPrecoServlet extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        String nomeProduto = request.getParameter("produto");
        String sql = "SELECT preco FROM estoque WHERE produto = ?";

        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nomeProduto);
            ResultSet rs = stmt.executeQuery();

            try (PrintWriter out = response.getWriter()) {
                if (rs.next()) {
                    double preco = rs.getDouble("preco");
                    out.println("{\"preco\":" + preco + "}");
                } else {
                    out.println("{\"preco\":null}");
                }
            }
        } catch (Exception e) {
            System.err.println("Erro ao buscar preço: " + e.getMessage());
        }
    }
}


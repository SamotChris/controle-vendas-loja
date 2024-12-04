package conexao;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Christopher
 */
@WebServlet("/api/listarVendas")
public class ListarVendasServlet extends HttpServlet {

    private final VendaDAO vendaDAO = new VendaDAO();

    /**
     *
     * @param request
     * @param response
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            List<String> vendas = vendaDAO.listarVendas();
            out.println("[");
            for (int i = 0; i < vendas.size(); i++) {
                out.print(vendas.get(i));
                if (i < vendas.size() - 1) {
                    out.print(",");
                }
            }
            out.println("]");
        }
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Christopher
 */
package conexao;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistrarVendaServlet")
public class RegistrarVendaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Obter parâmetros do formulário
        int clienteId = Integer.parseInt(request.getParameter("clienteId"));
        int produtoId = Integer.parseInt(request.getParameter("produtoId"));
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));

        // Processar a venda
        try (PrintWriter out = response.getWriter()) {
            VendaDAO vendaDAO = new VendaDAO();
            vendaDAO.registrarVenda(clienteId, produtoId, quantidade);
            
            // Exibir feedback para o usuário
            response.setContentType("text/html");
            out.println("<html><body>");
            out.println("<h1>Venda registrada com sucesso!</h1>");
            out.println("<a href='vendas.html'>Voltar</a>");
            out.println("</body></html>");
        } catch (Exception e) {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body>");
                out.println("<h1>Erro ao registrar venda: " + e.getMessage() + "</h1>");
                out.println("<a href='vendas.html'>Voltar</a>");
                out.println("</body></html>");
            }
        }
    }
}


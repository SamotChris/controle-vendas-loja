package css;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Christopher
 */
public class TesteConexao {

    private static Object conexao;
    public static void main(String[] args) {
        try {
            Connection conn = Conexao.conectar();
            System.out.println("Conexão estabelecida com sucesso!");
            conn.close();
        } catch (SQLException e) {
            System.err.println("Erro ao conectar ao banco de dados: " + e.getMessage());
        }
    }
}

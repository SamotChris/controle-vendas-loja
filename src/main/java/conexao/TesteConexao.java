/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexao;

import java.sql.SQLException;

/**
 *
 * @author Christopher
 */

public class TesteConexao {
    public static void main(String[] args) {
        try {
            Conexao.conectar();
        } catch (SQLException e) {
            System.err.println("Erro ao conectar ao banco: " + e.getMessage());
        }
    }
}

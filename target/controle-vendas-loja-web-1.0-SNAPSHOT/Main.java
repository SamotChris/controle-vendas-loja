/**
 *
 * @author Christopher
 */
import conexao.ClienteDAO;
import conexao.EstoqueDAO;
import conexao.VendaDAO;
import java.sql.SQLException;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws SQLException {
        // Instanciar DAOs
        ClienteDAO clienteDAO = new ClienteDAO();
        try {
        clienteDAO.inserirCliente("Teste", "teste@teste.com", "123456789");
        System.out.println("Cliente inserido com sucesso!");
    } catch (SQLException e) {
        System.err.println("Erro ao inserir cliente: " + e.getMessage());
    }
        
        EstoqueDAO estoqueDAO = new EstoqueDAO();
        VendaDAO vendaDAO = new VendaDAO();

        try (Scanner scanner = new Scanner(System.in)) {
            int opcao;

            do {
                System.out.println("\n==== Sistema de Controle de Vendas (Teste CLI) ====");
                System.out.println("1. Cadastrar Cliente");
                System.out.println("2. Cadastrar Produto no Estoque");
                System.out.println("3. Registrar Venda");
                System.out.println("4. Listar Clientes");
                System.out.println("5. Listar Vendas");
                System.out.println("6. Sair");
                System.out.print("Escolha uma opção: ");
                opcao = scanner.nextInt();
                scanner.nextLine(); // Consumir a quebra de linha

                switch (opcao) {
                    case 1 -> {
                        // Cadastro de Cliente
                        System.out.print("Digite o nome do cliente: ");
                        String nome = scanner.nextLine();
                        System.out.print("Digite o e-mail do cliente: ");
                        String email = scanner.nextLine();
                        System.out.print("Digite o telefone do cliente: ");
                        String telefone = scanner.nextLine();
                        clienteDAO.inserirCliente(nome, email, telefone);
                        System.out.println("Cliente cadastrado com sucesso!");
                    }

                    case 2 -> {
                        // Cadastro de Produto no Estoque
                        System.out.print("Digite o nome do produto: ");
                        String produto = scanner.nextLine();
                        System.out.print("Digite a quantidade em estoque: ");
                        int quantidade = scanner.nextInt();
                        System.out.print("Digite o preço do produto: ");
                        double preco = scanner.nextDouble();
                        estoqueDAO.inserirProduto(produto, quantidade, preco);
                        System.out.println("Produto cadastrado com sucesso!");
                    }

                    case 3 -> {
    // Registro de Venda
    System.out.print("Digite o ID do cliente: ");
    int clienteId = scanner.nextInt();
    System.out.print("Digite o ID do produto: ");
    int produtoId = scanner.nextInt();
    System.out.print("Digite a quantidade vendida: ");
    int quantidadeVendida = scanner.nextInt();

    try {
        vendaDAO.registrarVenda(clienteId, produtoId, quantidadeVendida);
        System.out.println("Venda registrada com sucesso!");
    } catch (SQLException e) {
        System.err.println("Erro ao registrar venda: " + e.getMessage());
    }
}


                    case 4 -> {
                        // Listar Clientes
                        clienteDAO.listarClientes().forEach(System.out::println);
                    }

                    case 5 -> {
    // Listar Vendas
    System.out.println("\n==== Lista de Vendas ====");
    vendaDAO.listarVendas().forEach(System.out::println);
}


                    case 6 -> System.out.println("Saindo do sistema. Obrigado!");

                    default -> System.out.println("Opção inválida! Tente novamente.");
                }
            } while (opcao != 6);
        }
    }
}



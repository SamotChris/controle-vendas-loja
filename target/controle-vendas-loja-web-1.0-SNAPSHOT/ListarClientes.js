fetch("http://localhost:8080/controle-vendas-loja-web-1.0-SNAPSHOT/api/ListarClientes")
    .then(response => {
        if (!response.ok) {
            throw new Error("Erro ao acessar o servidor: " + response.status);
        }
        return response.json();
    })
    .then(data => {
        const tabela = document.getElementById("dadosClientes");
        data.forEach(cliente => {
            const linha = document.createElement("tr");
            linha.innerHTML = `
                <td>${cliente.id}</td>
                <td>${cliente.nome}</td>
                <td>${cliente.email}</td>
                <td>${cliente.telefone}</td>
            `;
            tabela.appendChild(linha);
        });
    })
    .catch(error => console.error("Erro ao carregar clientes:", error));

document.addEventListener("DOMContentLoaded", () => {
    fetch("/controle-vendas-loja-web-1.0-SNAPSHOT/api/listarVendas")
        .then(response => response.json())
        .then(data => {
            const tabela = document.getElementById("dadosVendas");
            data.forEach(venda => {
                const linha = document.createElement("tr");
                linha.innerHTML = venda; // Certifique-se de que a venda está em formato HTML no servlet
                tabela.appendChild(linha);
            });
        })
        .catch(error => console.error("Erro ao carregar vendas:", error));
});

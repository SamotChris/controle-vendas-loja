/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function validarFormulario() {
    const nome = document.getElementById('nome').value;
    if (nome === '') {
        alert('O campo Nome é obrigatório.');
        return false;
    }
    return true;
}

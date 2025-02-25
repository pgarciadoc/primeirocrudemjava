<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir produtos</title>
    </head>
    <body>
        <%
         
           //try catch serve para tratamento de exceções, ou seja, erros

           //recebe o código digitado no formulário
           int cod;
           cod = Integer.parseInt(request.getParameter("codigo"));
         try {
           //conecta ao banco de dados chamado bancocrudjava
           Class.forName("com.mysql.cj.jdbc.Driver");
           Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancocrudjava", "root", "secret");
           //Exclui o produto de código que será informado no campo
           PreparedStatement st = conecta.prepareStatement("DELETE FROM produto WHERE codigo=?");
           st.setInt(1, cod);
           /*
           comando que executa o comando DELETE, se o código existir no banco.
           Se não existir, ele mostrará uma mensagem e a ação não será executada.
           */

           int resultado = st.executeUpdate();
           if (resultado == 1){
                st.executeUpdate();
                out.print("O produto de código " + cod + " foi deletado com sucesso");
            }else{
                out.print("Esse código não está cadastrado");
            }   
         } catch(Exception erro) {
                String mensagemErro = erro.getMessage();
                out.print("Entre em contato com o suporte e informe o erro: " + mensagemErro);
            }
        %>
    </body>
</html>

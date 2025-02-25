<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alteração de Produtos</title>
    </head>
    <body>
        <%
            //Recebe os dados alterados no formulário carragaprod.jsp
            int codigo;
            String nome, marca;
            double preco;
            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome");
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco"));

            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancocrudjava", "root", "secret");
            //alterar os dados na tabela produtos do banco de dados
            st = conecta.prepareStatement("UPDATE produto SET nome = ?, marca = ?, preco = ? WHERE codigo = ?");
            st.setString(1, nome);
            st.setString(2, marca);
            st.setDouble(3, preco);
            st.setInt(4, codigo);
            st.executeUpdate(); //Executa o update, a alteração no banco de dados
            out.print("O dados do produto " + codigo + " foram alterado com sucesso");
        %>
    </body>
</html>

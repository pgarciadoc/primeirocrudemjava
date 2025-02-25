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

            //Recebe o código do produto a alterar
            int c;
            c = Integer.parseInt(request.getParameter("codigo"));
            //Conectar ao banco de dados
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancocrudjava", "root", "secret");
            //Buscar o produto pelo código digitado
            st = conecta.prepareStatement("SELECT * FROM produto WHERE codigo = ?");
            st.setInt(1, c);
            ResultSet resultado = st.executeQuery(); //executa o comando SELECT armazenando os dados do produto selecionado na variável resultado
            //verifica se o produto de código informado foi encontrado
            if (!resultado.next()) { //o next verifica se dentro da variável resultado tem alguma linha de dados do produto pesquisado 
                out.print("Este produto não foi encontrado");
            } else { //se encontrou o produto
        %>
        <form method="post" action="alterar_produtos.jsp">
            <p>
                <label for="codigo">Código:</label>
                <input type="number" name="codigo" id="codigo" value="<%= resultado.getString("codigo")%>" readonly>
            </p>

            <p>
                <label for="nome">Nome do Produto</label>
                <input type="text" name="nome" id="nome" size="50" maxlength="50" value="<%= resultado.getString("nome")%>">
            </p>

            <p>
                <label for="marca">Marca</label>
                <input type="text" name="marca" id="marca" maxlength="50" value="<%= resultado.getString("marca")%>">
            </p>

            <p>
                <label for="preco">Preço</label>
                <input type="number" step="0.1" name="preco" id="preco" value="<%= resultado.getString("preco")%>">
            </p>

            <p>
                <input type="submit" value="Salvar Alterações">
            </p>
        </form>
        <%
            }
        %>
    </body>
</html>

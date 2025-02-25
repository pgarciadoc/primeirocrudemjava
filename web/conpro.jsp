<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Consulta de Produtos</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: blue;
            color: white;
        }
    </style>
</head>
<body>
<%
    //Recebe o nome do produto digitado no formulado conpro.html
    String n;
    n = request.getParameter("nome");
    
    try {

        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancocrudjava", "root", "secret");
        /*
        Daqui pra cima são comandos padrão para realizar a conexão com banco de dados.
        Do conecta = DriverManager para baixo, vai mudar, já que iremos
        desenvolver a lógica para aparecer a lista de produtos cadastrados. 
        */
        //Inserindo comando SQL para selecionar um produto pelas letras digitadas
        st = conecta.prepareStatement("SELECT * FROM produto WHERE nome LIKE ?");
        st.setString(1, "%" + n + "%");
        /*
        as porcentagens servem para realizar a busca no banco através da digitação
        de poucas palavras, como deira, que irá fazer com que o banco liste todos
        os produtos que tenham "deira" no nome.
        */
        /*
        Aqui precisamos gravar o comando execute, que irá executar o
        comando SQL acima, numa variável ResultSet. Os dados que o comando
        executamos executeQuery()traz da tabela precisam ser armazenados,
        por isso a varíavel rs da classe ResultSet precisa ser empregada.
        ResultSet é uma classe que serve apenas para guardar tudo que é
        trazido do banco de dados para a aplicação.
        */
        ResultSet rs = st.executeQuery();      
%>
    <table>
        <thead>
            <tr>
                <th>Código</th>
                <th>Nome</th>
                <th>Marca</th>
                <th>Preço</th>
                <th>Excluir Produto</th>
            </tr>
                    
        </thead>
        <tbody>
                
<%
        while(rs.next()) {
%>
            <tr>
                <td> <%= rs.getInt("codigo") %></td>
                <td> <%= rs.getString("nome") %></td>
                <td> <%= rs.getString("marca") %></td>
                <td> <%= rs.getDouble("preco") %></td>
                <!-- chama as funcionalidades de excpro.jsp para que delete o código da linha selecionada -->
                <td><a href="excpro.jsp?codigo=<%= rs.getInt("codigo")%>">Excluir</a></td>
                
            </tr>
<%
        }
%>
        <tbody>
    </table>
<%
    /*
    O bloco acima é em html, por isso que o Java recomeça a partir daqui.
    Table constrói uma tabela onde os produtos serão exibidos. Tag tr delimita as linhas
    que serão utilizadas. tag th gera o cabeçalho da tabela (t = table h = head).
    A tag td serve para alocar os dados da tabela (table data). Dentro do td, colocamos
    o código Java para exibir os campos da tabela. Como é só para exibição dos dados, precisamos
    colocar o sinal de igual.
    */
    
    } catch (Exception x) {
        out.print("Erro:" + x.getMessage());
    }
%>
</body>
</html>

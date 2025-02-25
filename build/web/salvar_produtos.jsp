<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            //Recebendo os dados digitados no formulário cadpro.htmll
            int codigo;
            String nome, marca;
            double preco;
            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome");
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco"));
            
            /*
            O comando try nos ajuda a resumir/identificar melhor os erros que o banco
            pode apresentar. Try significa tentar. Lemos da seguinte maneira: tente
            executar esses comandos aqui dentro, caso não consiga/se der erro, pegue (catch) e
            guarde na variável "x". O getMessage serve para APENAS a mensagem que identifica o erro e mostra na tela
            
            
            precisa colocar toda a parte que fará a conexão e a gravação no banco de dados
            dentro do comando try
            */
            
            //try catch serve para tratamento de exceções, ou seja, erros
            try {
  
            /*
            Conexão com o banco de dados
            Connection é uma classe do Java. Precisa ser importada e o caminho precisa ser alterado para java.sql.Connection
            Connection conecta;
            */
            Connection conecta;
            /*
            Variável para permitir digitar comandos SQL, como o insert,
            que enviará os dados pra tabela.
            PreparedStatement Também é uma classe do Java
            */
            PreparedStatement st;
            
            /*
            Class.forName: diz onde está a classe do driver que fará
            a conexão com o banco de dados
            */
            Class.forName("com.mysql.cj.jdbc.Driver");
            /*
            A variável conecta está guardando a ferramenta do Java DriverManager.
            DriverManager é responsável por permitir indicar o nome do banco de dados,
            a senha do mysql, o usuário para realizar a conexão.
            
            A ferramenta também precisa ser importada.
            
            Dentro de DriverManager temos o método getConnection para permitir
            a conexão com o banco de dados. 
            
            getConnection: precisa informar o caminho do banco de dados, que está
            na documentação do Java, exceto a parte do localhost para frente;
            o root como user, que criamos quando instalamos o mysql;
            E a senha do nosso root, que também criamos ao instalar o mysql.
            3306 é a porta para a conexão.
            Se o banco estiver em um servidor em outro local, precisamos colocar o IP
            da máquina do servidor no lugar de localhost:3306
            */
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancocrudjava", "root", "secret");
            
            /*
            Inserindo os dados na tabela produto do banco de dados definido em getConnection
            
            Agora usaremos a varíavel st, criada mais acima
            
            O comando entre aspas dentro do prepareStatement é programação de banco
            de dados já
            
            produto é o nome da tabela criada no mysql workbench
            
            no VALUES não devemos colocar as variáveis que o programa deverá jogar
            dentro do banco. Colocamos pontos de interrogação para cada uma, por enquanto
            */
            st = conecta.prepareStatement("INSERT INTO produto VALUES(?,?,?,?)");
            
            /*
            st.setInt quer dizer que será inserido um valor inteiro no primeiro ponto
            de interrogação, ou seja, o PRIMEIRO ponto será substituído pelo que será inserido
            na variável codigo
            */
            st.setInt(1, codigo);
            st.setString(2, nome);
            st.setString(3, marca);
            st.setDouble(4, preco);
            //Método que irá executar a inserção no banco de dados
            st.executeUpdate();
            //Mostrar mensagem dizendo que tudo ocorreu bem
            out.print("<p Style='color: blue; font-size: 20px;'>Produto cadastrado com sucesso</p>");
            
            /*
            catch significa que pegamos a Exception x, ou seja, o erro do sistema.
            
            O bloco catch serve para formatarmos as mensagens de erro, além de ser necessário
            para avisar o usuário sobre o erro na tela. Salvamos a mensagem de erro em uma string
            chamada "erro", logo após fazemos uma condição: se o erro conter entrada duplicada, ou
            seja, mesmo código de cadastro, surgirá a mensagem sugerindo que o produto já está
            cadastrado. Se for outro erro, irá aparecer a mensagem específica do erro na tela, formatada
            para aparecer apenas a parte que está indicando de forma assertiva o erro em evidência.
            */
            } catch (Exception x) {
                String erro = x.getMessage();
                if(erro.contains("Duplicate entry")){
                    out.print("<p Style ='color: red; font-size: 20px;'>Erro: Este produto já está cadastrado</p>");
                }else {
                    out.print("Mensagem de erro:" + erro);
                }
                
            }
        %>
    </body>
</html>

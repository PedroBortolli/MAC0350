Pedro Vítor Bortolli Santos - No USP: 9793721
Pedro Teotonio Sousa - No USP: 9793648
Lucas Daher - No USP: 8991769
Rubens Douglas Roccia - No USP: 9793590
Lucas Moretto - No USP: 


Inicialmente, incluímos na pasta raiz do EP3 um arquivo shell denominado "setup_db.sh".
Este script tem como função criar todas as tabelas (bem como populá-las), relacionamentos e funções que serão utilizadas no projeto.
Para rodar este script, basta mudar usuario e senha no script e executar em seu diretório:

sh setup_db.sh

Aguarde alguns segundos para que tudo seja feito com sucesso.
Alguns comandos de DROP são feitos e uma mensagem dizendo que não foi feito aparecerão. Isso é normal pois muitas (ou todas) das tabelas/funções que são dropadas ainda não existem na base de dados local.


Agora, dividimos o EP em duas partes: servidor (server) e cliente (client). Entraremos em detalhes em como rodá-las agora.


Server:

Entre no diretório /server. O servidor foi escrito em javascript utilizando Node.js.
Também certifique-se de que você possui npm - um pacote de gerenciamento de bibliotecas de javascript.
Para instalar tudo:

sudo apt-get update
sudo apt-get install nodejs
sudo apt-get install npm

OBS: A versão da npm que foi testada durante o desenvolvimento foi a 6.2.0.
OBS2: A versão do node que foi testada durante durante o desenvolvimento foi a v10.9.0.

Agora, instale as dependências do servidor rodando:

npm install

E para subir o servidor:

npm start

O servidor já estará rodando na porta 5000 do localhost (http://localhost:5000).



Client:

O cliente foi escrito também em javascript utilizando React.
Abra outro terminal (pois precisamos de um terminal para ficar rodando o servidor especificado acima), e navegue até o diretório /client da pasta do EP3.

Instale yarn:

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn

OBS: A versão do yarn que foi testada durante o desenvolvimento foi a 1.9.4.

Agora, instale as dependências:

yarn install

E finalmente levante o cliente rodando:

yarn start

O client já estará rodando na porta 3000 do localhost (http://localhost:3000).






Login:

Criamos dois usuários no sistema.
O primeiro é um administrador, que tem poder de editar/criar certas coisas no servidor. Seu login e senha são, respectivamente:

admin
password


Também criamos um usuário comum que é um aluno, que consegue salvar/excluir suas disciplinas no sistema. Seu login e senha são, respectivamente:

pedroteosousa
senhasenhasenha
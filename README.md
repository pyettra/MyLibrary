**Projeto Minha Biblioteca**

**1. Introdução**

O projeto consiste no desenvolvimento de um aplicativo para dispositivos iOS, denominado "Minha Biblioteca", que permite aos usuários acessar uma coleção de livros e gerenciar sua leitura. O aplicativo permite visualizar uma lista de livros disponíveis, ver detalhes sobre cada livro, como nome, autor, descrição e capa, além de permitir aos usuários adicionar livros à sua lista de leitura ou marcá-los como lidos.

**2. Implementação**

2.1 Linguagem de Programação
O aplicativo foi desenvolvido em Swift, uma linguagem de programação amplamente utilizada para o desenvolvimento de aplicativos iOS.

2.2 Banco de Dados
Para armazenar os dados dos livros e autores, foi utilizado o SQLite3, um banco de dados relacional de código aberto. O esquema do banco de dados inclui duas tabelas: "authors" para armazenar informações sobre os autores e "books" para armazenar informações sobre os livros.

Script do Banco de Dados:

sql
Copy code
CREATE TABLE authors (
    author_id INTEGER PRIMARY KEY,
    author_name TEXT NOT NULL
);

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    book_name TEXT NOT NULL,
    is_read INTEGER,
    is_wishlist INTEGER,
    author_id INTEGER,
    description TEXT,
    image TEXT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


**3. Requisitos Funcionais**

3.1 Visualização de Livros
Os usuários podem visualizar uma lista de livros disponíveis na biblioteca.

3.2 Detalhes do Livro
Os usuários podem ver detalhes de um livro específico, incluindo nome, autor, descrição e capa.

3.3 Adicionar à Lista de Leitura
Os usuários podem adicionar um livro à sua lista de leitura.

3.4 Marcar como Lido
Os usuários podem marcar um livro como lido.

3.5 Marcar como Desejado
Os usuários podem adicionar um livro à sua lista de desejos.


**4. Requisitos Não Funcionais**

4.1 Usabilidade
O aplicativo deve ter uma interface intuitiva e fácil de usar.

4.2 Desempenho
O aplicativo deve ter um desempenho responsivo, mesmo quando lidando com grandes volumes de dados.

4.3 Segurança
Os dados dos usuários devem ser armazenados de forma segura no banco de dados SQLite3.


**5. Bibliografia**

Apple Inc. (2021). "The Swift Programming Language." Disponível em: https://docs.swift.org/swift-book/
SQLite. (s.d.). "SQLite Home Page." Disponível em: https://www.sqlite.org/index.html
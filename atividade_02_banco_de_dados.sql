-- DESENVOLVIDO POR HYGOR RASEC | MATRÍCULA: 202212020
-- UNIVERSIDADE DE VASSOURAS - CAMPUS MARICÁ
-- DISCIPLINA: BANCO DE DADOS
-- PROFESSOR: FABRÍCIO DIAS
-- 29/11/2023

-- Subir o arquivo .sql no github e enviar o código.
-- Criar um banco de dados de uma rede social.

-- CREATE TABLE Usuarios
-- CREATE TABLE Postagens
-- CREATE TABLE Comentarios
-- CREATE TABLE Amizades

-- Precisa observar os relacionamentos.

-- Responder:

-- Recuperação de Postagens:

-- Liste todas as postagens feitas por um usuário chamado 'João'.
-- Comentários em uma Postagem:

-- Mostre todos os comentários feitos em uma postagem com o texto 'Bom dia, mundo!'.
-- Estatísticas de Atividades:

-- Apresente a contagem total de postagens e comentários feitos por cada usuário.
-- Amizades Recentes:

-- Liste todas as novas amizades formadas nos últimos 30 dias.
-- Detalhes de um Usuário:

-- Forneça informações detalhadas sobre um usuário chamado 'Maria', incluindo suas postagens e amizades.

create database redesocial;
use redesocial;

create table if not exists usuarios (
	id int auto_increment primary key,
    nome varchar(100)
);
DROP TABLE usuarios;

create table if not exists postagens (
	id int auto_increment primary key,
    id_usuario int,
    texto text,
    data date
);
DROP TABLE postagens;

create table if not exists comentarios (
	id int auto_increment primary key,
    texto text,
    id_usuario int,
    id_postagem int,
    data date
);
DROP TABLE comentarios;

create table if not exists amizades (
    id int auto_increment primary key,
    id_usuario1 int,
    id_usuario2 int,
    data date
);
DROP TABLE amizades;

insert into usuarios (nome) values
('João'),
('Maria'),
('Pedro'),
('Ana');

insert into postagens (texto, id_usuario, data) values
('Olá, mundo!', 2, '2023-11-21'),
('Bom dia, mundo!', 1, '2023-11-22'),
('Boa noite, pessoal!', 3, '2023-11-23'),
('Boa noite!', 4, '2023-11-24'),
('Como vocês estão?!', 4, '2023-11-25');

insert into comentarios (texto, id_usuario, id_postagem, data) values
('Oiii!', 1, 1, '2023-11-22'),
('Bom dia pra você também!', 1, 2, '2023-11-22'),
('Boa noite pra você também!', 2, 3, '2023-11-23'),
('Boa noite!!!', 3, 3, '2023-11-23'),
('Olá!', 4, 1, '2023-11-24'),
('Estou bem, e você?', 4, 5, '2023-11-25'),
('Me conte uma novidade!', 4, 5, '2023-11-25');

insert into amizades (id_usuario1, id_usuario2, data) values
(1, 2, '2023-11-01'),
(3, 4, '2023-11-02'),
(2, 4, '2023-11-03');

-- Liste todas as postagens feitas por um usuário chamado 'João'.
select texto, data from postagens where id in (select id from usuarios where nome = 'João');

-- Mostre todos os comentários feitos em uma postagem com o texto 'Bom dia, mundo!'.
select texto, data from comentarios where id in (select id from postagens where texto = 'Bom dia, mundo!');

-- Apresente a contagem total de postagens e comentários feitos por cada usuário.
select
	u.nome as usuario,
    count(distinct p.id) as Total_Postagens,
    count(distinct c.id) as Total_Comentarios
from usuarios as u
left join postagens p on u.id = p.id_usuario
left join comentarios c on u.id = c.id_usuario
group by u.nome;

-- Liste todas as novas amizades formadas nos últimos 30 dias.
select u.nome as usuario1, u2.nome as usuario2, a.data
from amizades a
inner join usuarios u on a.id_usuario1 = u.id
inner join usuarios u2 on a.id_usuario2 = u2.id
where a.data >= curdate() - interval 30 day;

-- Forneça informações detalhadas sobre um usuário chamado 'Maria', incluindo suas postagens e amizades.
select u.nome as usuario,
       p.texto as postagem,
       a.data as data_amizade,
       u2.nome as amigo
from usuarios as u
left join postagens as p on u.id = p.id_usuario
left join amizades as a on u.id = a.id_usuario1 or u.id = a.id_usuario2
left join usuarios as u2 on (u.id = a.id_usuario1 and u2.id = a.id_usuario2) or (u.id = a.id_usuario2 and u2.id = a.id_usuario1)
where u.nome = 'Maria';

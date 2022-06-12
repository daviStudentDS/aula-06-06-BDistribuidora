/*
    Tabela aqui   =   Tabela do professor
    tbPedido      =   tbCompra
    tbCompra      =   tbVenda
    tbItemCompra  =   tbItemVenda
    tbPedidoProduto = tbItemCompra
*/

drop database dbDistribuidora;
create database dbDistribuidora;
use dbDistribuidora;

create table tbCliente(
	IdCli int primary key auto_increment,
    NomeCli varchar(200) not null,
    NumEnd numeric(6) not null,
    CompEnd varchar(50),
    CepCli numeric(8) not null
);

create table tbClientePF(
	CPF numeric(11) primary key,
    RG numeric(9) not null,
    RG_Dig char(1) not null,
    Nasc date not null,
    IdCli int unique not null 
); 

create table tbClientePJ(
	CNPJ numeric(14) primary key,
    IE numeric(11) unique,
    IdCli int unique not null 
);

create table tbProduto(
    CodigoBarras numeric(14) primary key,
    NomeProd varchar(200) not null,
    Valor decimal(5,2) not null,
    Qtd int
);

create table tbCompra(
	CodigoCompra numeric(10) primary key,
    DataCompra date,
    ValorTotal decimal(6,2) not null,
    QtdTotal int not null,
    NotaFiscal int,
    IdCli int
);

create table tbNotaFiscal(
	NotaFiscal int primary key,
    TotalNota decimal(5,2) not null,
    DataEmissao date not null
);

create table tbItemCompra(
	NotaFiscal int,
    CodigoBarras numeric(14),
    ValorItem decimal(5,2) not null,
    Qtd int not null,
    primary key(NotaFiscal,CodigoBarras)
);

create table tbFornecedor(
	IdFornecedor int auto_increment primary key,
    CNPJ numeric(13) not null unique,
    NomeFornecedor varchar(100) not null,
    telefone numeric(11)
);

create table tbPedido(
	NotaFiscalPedido int primary key,
    DataCompra date not null,
    ValorTotal decimal (6,2) not null,
    QtdTotal int not null,
    IdFornecedor int
);

create table tbPedidoProduto(
	NotaFiscalPedido int,
    CodigoBarras numeric(14),
    primary key(NotaFiscalPedido,CodigoBarras)
);

create table tbEndereco(
	CEP numeric(8) primary key,
    Logradouro varchar(200),
    IdBairro int not null,
    IdCidade int not null,
    IdUF int not null
);

create table tbBairro(
    IdBairro int primary key,
    Bairro varchar(200) not null
);
create table tbCidade(
    IdCidade int primary key,
    Cidade varchar(200) not null
);
create table tbUF(
    IdUF int primary key,
    UF varchar(200) not null
);

alter table tbCliente add foreign key (CepCli) references tbEndereco(CEP);

alter table tbClientePF add foreign key (IdCli) references tbCliente(IdCli);

alter table tbClientePJ add foreign key (IdCli) references tbCliente(IdCli);

alter table tbCompra add foreign key (NotaFiscal) references tbNotaFiscal(NotaFiscal);
alter table tbCompra add foreign key (IdCli) references tbCliente(IdCli);

alter table tbItemCompra add foreign key (NotaFiscal) references tbCompra(NotaFiscal);
alter table tbItemCompra add foreign key (CodigoBarras) references tbProduto(CodigoBarras);

alter table tbPedido add foreign key (IdFornecedor) references tbFornecedor(IdFornecedor);

alter table tbPedidoProduto add foreign key (NotaFiscalPedido) references tbPedido(NotaFiscalPedido);
alter table tbPedidoProduto add foreign key (CodigoBarras) references tbProduto(CodigoBarras);

alter table tbEndereco add foreign key (IdBairro) references tbBairro(IdBairro);
alter table tbEndereco add foreign key (IdCidade) references tbCidade(IdCidade);
alter table tbEndereco add foreign key (IdUF) references tbUF(IdUF);

insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1245678937123,"Revenda Chico Loco",11934567897);
insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1345678937123,"José Faz Tudo S/A",11934567898);
insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1445678937123,"Vadalto Entregas",11934567899);
insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1545678937123,"Astrogildo das Estrelas",11934567800);
insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1645678937123,"Amoroso e Doce",11934567801);
insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1745678937123,"Marcelo Dedal",11934567802);
insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1845678937123,"Franciscano Cachaça",11934567803);
insert into tbFornecedor (CNPJ, NomeFornecedor, telefone) values (1945678937123,"Joãozinho Chupeta",11934567804);
select * from tbFornecedor;
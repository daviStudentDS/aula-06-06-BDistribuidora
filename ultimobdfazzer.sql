create database dbDistribuidoraPrincipals;
use dbDistribuidoraPrincipals;




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
    Nome varchar(200) not null,
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
    IdUF int primary key auto_increment,
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

/*
    Tabela aqui   =   Tabela do professor
    tbPedido      =   tbCompra
    tbCompra      =   tbVenda
    tbItemCompra  =   tbItemVenda
    tbPedidoProduto = tbItemCompra
*/

/* 
Sintaxe - 
Delimitter$$
CREATE PROCEDURE nome_procedimento ([parâmetros]) []--opcional dentro das chaves
BEGIN
CORPO DO PROCEDIMENTO
END $$
*/

show tables;

Describe tbCidade;
select * from tbBairro;


Delimiter $$

Create Procedure spinsertcidade(IdCidade int, Cidade varchar(200))
begin

insert into tbCidade(IdCidade, Cidade) values(IdCidade, Cidade);

end 
$$

call spInsertCidade(1,"Rio de Janeiro");
call spInsertCidade(2,"São Carlos");
call spInsertCidade(3,"Campinas");
call spInsertCidade(4,"Franco da Rocha");
call spInsertCidade(5,"Osasco");
call spInsertCidade(6,"Pirituba");
call spInsertCidade(7,"Lapa");
call spInsertCidade(8,"Ponta Grossa");

Delimiter $$

Create Procedure spinsertUF(UF varchar(200))
begin

insert into tbUF(UF) values(UF);

end 
$$

call spInsertUF("SP");
call spInsertUF("RJ");
call spInsertUF("RS");

-- select * from tbUF;

Delimiter $$

Create Procedure spinsertbairro(Idbairro int, bairro varchar(200))
begin

insert into tbbairro(Idbairro, bairro) values(IdBairro, Bairro);

end 
$$

call spInsertBairro(1,"Aclimção");
call spInsertBairro(2,"Capão Redondo");
call spInsertBairro(3,"Pirituba");
call spInsertBairro(4,"Liberdade");
select * from tbBairro;









-- Describe tbProduto;



Delimiter $$

Create Procedure spinsertproduto(CodigoBarras numeric(14), nome varchar(200),Valor decimal(5,2),Qtd int)
begin

insert into tbproduto(codigobarras, nome, valor, qtd) values(codigobarras, nome, valor, qtd);

end 
$$

call spInsertproduto(1234567891011,"Rei de Papel Mache", 54.61 , 120);
call spInsertproduto(1234567891012,"Bolinha de Sabão", 100.45 , 120);
call spInsertproduto(1234567891013,"Carro Bate Bate", 44.00 , 120);
call spInsertproduto(1234567891014,"Bola Furada", 10.00 , 120);
call spInsertproduto(1234567891015,"Maçã Laranja", 99.44 , 120);
call spInsertproduto(1234567891016,"Boneco do Hitler", 124.00 , 200);
call spInsertproduto(1234567891017,"Fainha de Suruí", 50.00 , 200);
call spInsertproduto(1234567891018,"Zelador de Cemitério", 24.50 , 120);


select * from tbProduto;

Delimiter $$

Create Procedure spinsertendereco(logradouro varchar(200), CEP numeric(14), Cidade varchar(200), Bairro varchar(200), UF varchar(200))
begin

if not exists (select Cep from tbEndereco) then

insert into tbendereco(logradouro,cep) values(logradouro,cep);
insert into tbbairro(bairro) values(bairro);
insert into tbcidade(cidade) values(cidade);
insert into tbuf(uf) values(uf);

end if;

               
end $$

call spInsertendereco("Rua de Federal","Lapa", "sp" ,"12345-050" );
call spInsertproduto(1234567891012,"Bolinha de Sabão", 100.45 , 120);
call spInsertproduto(1234567891013,"Carro Bate Bate", 44.00 , 120);
call spInsertproduto(1234567891014,"Bola Furada", 10.00 , 120);
call spInsertproduto(1234567891015,"Maçã Laranja", 99.44 , 120);
call spInsertproduto(1234567891016,"Boneco do Hitler", 124.00 , 200);
call spInsertproduto(1234567891017,"Fainha de Suruí", 50.00 , 200);
call spInsertproduto(1234567891018,"Zelador de Cemitério", 24.50 , 120);




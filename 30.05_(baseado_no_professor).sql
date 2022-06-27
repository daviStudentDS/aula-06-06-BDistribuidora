create database dbRegistProd;
use dbRegistProd;

create table tbUF (
	IdUF int auto_increment primary key,
	UF char(2) unique
);

create table tbBairro (
	IdBairro int auto_increment primary key,
	Bairro varchar(200)
);

create table tbCidade (
	IdCidade int auto_increment primary key,
	Cidade varchar(200)
);

create table tbEndereco (
	CEP varchar(8) primary key,
	Logradouro varchar(200),
	IdBairro int,
	IdCidade int,
	IdUF int,
    foreign key (IdBairro) references tbBairro(IdBairro),
    foreign key (IdCidade) references tbCidade(IdCidade),
	foreign key (IdUF) references tbUF(IdUF)
);

create table tbCliente (
	Id int primary key auto_increment,
	Nome varchar(50) not null,
	CEP varchar(8) not null,
	CompEnd varchar(50),
	foreign key (CEP) references tbEndereco(CEP)
);

create table tbClientePF (
	IdCliente int auto_increment,
	Cpf varchar(11) not null primary key,
	Rg varchar(8),
	RgDig varchar(1),
	Nasc date,
	foreign key (IdCliente) references tbCliente(Id)   
);

create table tbClientePJ (
	IdCliente int auto_increment,
	Cnpj varchar(14) not null primary key,
	Ie varchar(9),
    foreign key (IdCliente) references tbCliente(Id)
);

create table tbNotaFiscal (
	NF int primary key,
	TotalNota decimal(7,2) not null,
	DataEmissao date not null
);

create table tbFornecedor (
	Codigo int primary key auto_increment,
	Cnpj varchar(14) not null,
	Nome varchar(200),
	Telefone varchar(11)
);

create table tbCompra (
	NotaFiscal int primary key,
	DataCompra date not null,
	ValorTotal decimal(8,2) not null,
	QtdTotal int not null,
	Cod_Fornecedor int,
	foreign key (Cod_Fornecedor) references tbFornecedor(Codigo)
);

create table tbProduto (
	CodBarras varchar(14) primary key,
	Qtd int,
	Nome varchar(50),
	ValorUnitario decimal(6,2) not null
);

create table tbItemCompra (
	Qtd int not null,
	ValorItem decimal(6,2) not null,
	NotaFiscal int,
	CodBarras varchar(14),
	primary key (NotaFiscal, CodBarras),
	foreign key (NotaFiscal) references tbCompra(NotaFiscal),
	foreign key (CodBarras) references tbProduto(CodBarras)
);

create table tbVenda (
	IdCliente int,
	NumeroVenda int auto_increment primary key,
	DataVenda date not null,
	TotalVenda decimal(7,2) not null,
	NotaFiscal int,
	foreign key (IdCliente) references tbCliente(Id),    
	foreign key (NotaFiscal) references tbNotaFiscal(NF)
);

create table tbItemVenda (
	NumeroVenda int,
	CodBarras varchar(14),
	Qtd int,
	ValorItem decimal(6,2),    
	primary key (NumeroVenda, CodBarras),
	foreign key (NumeroVenda) references tbVenda(NumeroVenda),
	foreign key (CodBarras) references tbProduto(CodBarras)
);

insert into tbFornecedor(Nome, Cnpj, Telefone)
	values('Revenda Chico loco', '1245678937123', '11934567897'),
		  ('José FAz Tudo S/A', '1345678937123', '11934567898'),
	      ('Vadalto Entregas', '1445678937123', '11934567899'),    
	      ('Astrogildo das Estrela', '1545678937123', '11934567800'),
          ('Amoroso e Doce', '1645678937123', '11934567801'),
          ('Marcelo Dedal', '1745678937123', '11934567802'),
          ('Franciscano Cachaça', '1845678937123', '11934567803'),
          ('Joãozinho Chupeta', '1945678937123', '11934567804');
          
select * from tbFornecedor;  


Delimiter $$

create procedure spCidade(vCidade varchar(200))

begin
insert into tbCidade (Cidade)
	values(vCidade); 
end $$ 

	call spCidade('Rio de Janeiro');
    call spCidade('São Carlos');
    call spCidade('Campinas');
    call spCidade('Franco da Rocha');
    call spCidade('Osasco');
    call spCidade('Pirituba');
    call spCidade('lapa');
    call spCidade('Ponta Grossa');   

select * from tbCidade;


Delimiter $$

create procedure spEstado(vUF char(2))

begin
insert into tbUF (UF)
	values(vUF); 
end $$

	call spEstado('SP');
    call spEstado('RJ');
    call spEstado('RS');
   
select * from tbUF;   


Delimiter $$

create procedure spBairro(vBairro varchar(200))

begin
insert into tbBairro (Bairro)
	values(vBairro); 
end $$

	call spBairro('Aclimação');
    call spBairro('Capão Redondo');
    call spBairro('Pirituba');
    call spBairro('Liberdade');

select * from tbBairro;


Delimiter $$

create procedure spProd(vCod varchar(14), vNome varchar(50), vValor decimal(6,2), vQtd int)

begin
insert into tbProduto (CodBarras, Nome, ValorUnitario,  Qtd)
	values(vCod, vNome, vValor, vQtd); 
end $$

	call spProd('12345678910111', 'Rei de Papel Mache', '54.61', 120);
    call spProd('12345678910112', 'Bolinha de Sabão', '100.45', 120);
    call spProd('12345678910113', 'Carro Bate Bate', '44', 120);
    call spProd('12345678910114', 'Bola Furada', '10', 120);
    call spProd('12345678910115', 'Maçã Laranja', '99.44', 120);
    call spProd('12345678910116', 'Boneco do Hitler', '124', 200);
    call spProd('12345678910117', 'Farinha de Suruí', '50', 200);
    call spProd('12345678910118', 'Zelador de Cemitério', '24.50', 100);
    
   select * from tbProduto;
   
   
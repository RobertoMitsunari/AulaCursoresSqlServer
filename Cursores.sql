Create database Envios
go
use Envios

create table envio (
CPF varchar(20),
NR_LINHA_ARQUIV	int,
CD_FILIAL int,
DT_ENVIO datetime,
NR_DDD int,
NR_TELEFONE	varchar(10),
NR_RAMAL varchar(10),
DT_PROCESSAMENT	datetime,
NM_ENDERECO varchar(200),
NR_ENDERECO int,
NM_COMPLEMENTO	varchar(50),
NM_BAIRRO varchar(100),
NR_CEP varchar(10),
NM_CIDADE varchar(100),
NM_UF varchar(2)
)

create table endereço(
CPF varchar(20),
CEP	varchar(10),
PORTA	int,
ENDEREÇO	varchar(200),
COMPLEMENTO	varchar(100),
BAIRRO	varchar(100),
CIDADE	varchar(100),
UF Varchar(2))

/*
Por se tratar de dados confidenciais, a procedure abaixo foi feita para se criar
dados fictícios nas tabelas
*/


create procedure sp_insereenvio
as
declare @cpf as int
declare @cont1 as int
declare @cont2 as int
declare @conttotal as int
set @cpf = 11111
set @cont1 = 1
set @cont2 = 1
set @conttotal = 1
	while @cont1 <= @cont2 and @cont2 < = 100
			begin
				insert into envio (CPF, NR_LINHA_ARQUIV, DT_ENVIO)
				values (cast(@cpf as varchar(20)), @cont1,GETDATE())
				insert into endereço (CPF,PORTA,ENDEREÇO)
				values (@cpf,@conttotal,CAST(@cont2 as varchar(3))+'Rua '+CAST(@conttotal as varchar(5)))
				set @cont1 = @cont1 + 1
				set @conttotal = @conttotal + 1
				if @cont1 > = @cont2
					begin
						set @cont1 = 1
						set @cont2 = @cont2 + 1
						set @cpf = @cpf + 1
					end
	end




exec sp_insereenvio

select * from envio order by CPF,NR_LINHA_ARQUIV asc
select * from endereço order by CPF asc

exec sp_insereEnderecoEnvio
/*
Codigo bem ineficiente mas dada situação é oq temos
*/

create procedure sp_insereEnderecoEnvio
as
	declare @cpf varchar(20),@NR_LINHA_ARQUIV int,@cursor1_status int, @cursor2_status int,@rua varchar(20),@porta int,
	@contLinha int
	declare c1 cursor for select CPF,NR_LINHA_ARQUIV from envio 
	open c1
	FETCH NEXT FROM c1 INTO @cpf,@NR_LINHA_ARQUIV
	select @cursor1_status = @@FETCH_STATUS
	
	while @cursor1_status = 0
	BEGIN
		declare c2 cursor for select PORTA,ENDEREÇO from endereço where CPF = @cpf
		open c2
		FETCH NEXT FROM c2 INTO @porta,@rua
		select @cursor2_status = @@FETCH_STATUS
		set @contLinha = 1
		while @cursor2_status = 0
		BEGIN
			if(@contLinha = @NR_LINHA_ARQUIV)
			BEGIN
				update envio set NM_ENDERECO = @rua, NR_ENDERECO = @porta where CPF = @cpf and NR_LINHA_ARQUIV = @NR_LINHA_ARQUIV
			END
			set @contLinha = @contLinha + 1
			FETCH NEXT FROM c2 INTO @porta,@rua
			select @cursor2_status = @@fetch_status
		END
		CLOSE c2
		DEALLOCATE c2
		FETCH NEXT FROM c1 INTO @cpf,@NR_LINHA_ARQUIV
		select @cursor1_status = @@FETCH_STATUS
	END
	CLOSE c1
	DEALLOCATE c1

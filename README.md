--Exercício tirado de situação real.
/* A empresa tinha duas tabelas: Envio e Endereço, como listada abaixo.
No atributo NR_LINHA_ARQUIV, há um número que referencia a 
linha de incidência do endereço na tabela endereço.
Por exemplo: 

ENVIO:
|CPF		|NR_LINHA_ARQUIV	|...
|11111111111	|1			|
|11111111111	|2			|

ENDEREÇO:
|CPF		|CEP		|PORTA	|ENDEREÇO	|COMPLEMENTO		|BAIRRO			|CIDADE			|UF	|
|11111111111	|11111111	|10	|Rua A		|			|Pq A			|São Paulo		|SP	|
|11111111111	|22222222	|125	|Rua B		|			|Pq B			|São Paulo		|SP	|

Portanto, o NR_LINHA_ARQUIV (1) referencia o registro do endereço da Rua A e o NR_LINHA_ARQUIV (2) 
referencia o endereço da Rua B.

Como se trata de uma estrutura completamente mal feita, o DBA solicitou
que se colcasse as colunas NM_ENDERECO, NR_ENDERECO, NM_COMPLEMENTO, NM_BAIRRO, NR_CEP,
NM_CIDADE, NM_UF varchar(2) e movesse os dados da tabela endereço para a tabela envio.

Fazer uma PROCEDURE, com cursor, que resolva esse problema
*/

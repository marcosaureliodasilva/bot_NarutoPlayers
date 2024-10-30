## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;

sub garimpar_tag {
my $funcao = shift;
my	$deleta_vazio = substr($funcao,0,1);
my $total = shift;
my $tags = shift;
my @mapa = @_;
my @opcao;
my @parte;
my $i;
my $linha;
my $pagina;
my $conta;
for ($i=0; $i<$total; $i++){
$opcao[$i] = shift(@mapa);
}#fim for
$i = @mapa;
if ($i > 0){
$linha = &mod_agrupar('11',@mapa);
}else{
@mapa = &ler_status('./auto_arquivos/unzip.eafc');
$linha = &mod_agrupar('11',@mapa);
}
@mapa = ();
do {
if ($linha =~ /<$tags([^<>]+)>/i){
	$pagina = $1;
#	print "<$tags$pagina>---------";
for ($i=0; $i<$total; $i++){
	if ($pagina =~ /$opcao[$i]="([^"]+)"/i){
	$parte[$i] = $1;
#	print "$parte[$i]\n";
	}else{
	$parte[$i] = '';
	}#fim else
	}#fim for
$linha =~ s/<$tags/<excluido/i;
$conta = 0;
for ($i=0; $i<$total; $i++){
	if ($parte[$i]){
	$conta++;
	}
}#fim for
if (($conta == $total) || ($deleta_vazio ne '1')){
for ($i=0; $i<$total; $i++){
	push(@mapa,$parte[$i]);
}#fim for
}#fim se
}else{
	$pagina = 'nada';
}#fim else
} while ($pagina ne 'nada');
	return @mapa;
}

sub sub_array {
my $coluna = shift;
my $parte = shift;
my @mapa;
my @linha = @_;
my $total = @linha;
my $i;
my $b=0;
$parte--;
$coluna--;
for ($i=$parte; $i<$total; $i++){
$mapa[$b] = $linha[$i];
$b++;
$i= $i+$coluna;
}#fim for
return @mapa;
}

sub quebrar_banco {
my @linha = @_;
my $total = @linha;
my $i;
$total--;
for ($i=0; $i<$total; $i++) {
$linha[$i] = $linha[$i]."\n";
}#fim for
return @linha;
}

sub quebrar_tabela {
my $cor1;
my $cor2;
my $pagina;
my @mapa;
my $linha = shift;
	$linha =~ s/<table[^<>]*>//ig;
	$linha =~ s/<\\\/table>//ig;
	$linha =~ s/<tr[^<>]+>/<tr>/ig;
	$linha =~ s/<td[^<>]+>/<td>/ig;
	$linha =~ s/&nbsp;//ig;
do {
	if ($linha =~ /<tr>/i){
	$cor1 = index($linha,"<tr>");
		if ($linha =~ /<\\\/tr>/i){
		$cor2 = index($linha,"<\\\/tr>",$cor1);
		$cor2 = $cor2+6;
			if ($cor1 > -1 && $cor2 > -1 ){
			$pagina = substr($linha,$cor1,($cor2-$cor1));
			$linha =~ s/<tr>/<excluido>/i;
			$linha =~ s/<\\\/tr>/<\\\/excluido>/i;
			$pagina =~ s/\r//g;
			$pagina =~ s/\t//g;
			$pagina =~ s/<\\\/td><td>/;/ig;
			$pagina =~ s/<[^<>]+>//ig;
			$pagina =~ s/^;//ig;
			$pagina =~ s/;$//ig;
			push(@mapa,$pagina);
			}#fim se cor
		}#fim se form
	}else{
	$pagina = 'nada';
	}#fim else
} while ($pagina ne 'nada');
return @mapa;
}

1;
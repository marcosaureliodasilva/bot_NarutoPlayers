## criado por marcos aurelio em 20/03/2010
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;

sub banco_naruto {
my $c_origem = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $c_cookie_x = $c_cookie.'_x';
my $c_cookie_y = $c_cookie.'_y';
my $c_cookie_r = $c_cookie.'_r';
my $server = shift;
my $total;
my $conectar;
my @u_cookie;
my @acao;
my @linha;
my @cookie;
#my @atual;
my @tabela;
my @habili;
my @p_habili;
my $t_p_habili;
my $ni;
my $ryous;
my $pega_parte;
my $saida;
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@acao = &extrair_nome('<a[^<>]+href="([^"]+)"[^<>]*>Status<\\\/a>');
if ($acao[0]){
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
$acao[0] =~ s/^\///i;
$acao[0] =~ s/http:\/\///i;
$acao[0] =~ s/$cookie[0]\///i;
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome,$acao[0]);
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@linha = &mod_solicitar($cookie[0],$cookie[1],$cookie[2].'; '.$cookie[3].'; '.$cookie[4].'; '.$cookie[5],'');
$conectar = &cliente_pagina($cookie[0],'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
if ($u_cookie[0] eq '?p=login'){
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome,'nada');
print "novo login\n";
}
@acao = &sugar_form_naruto($cookie[0],$cookie[1],$c_cookie,'','./auto_col_arquivos/col_caminhos.eafc');
if ($acao[1]) {
	@acao = &garimpar_tag('1','1','form','action',$acao[1]);
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
$acao[0] =~ s/^\///i;
$acao[0] =~ s/http:\/\///i;
$acao[0] =~ s/$cookie[0]\///i;
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome,$acao[0]);
#########################################
	@acao = &extrair_nome('<tr[^<>]*>[^<>]*<td[^<>]*>N.{1,2}vel:<\\\/td>[^<>]*<td[^<>]*>([^<>]+)<\\\/td>[^<>]*<\\\/tr>');
	$acao[0] =~ s/\D+//ig;
	&gravar_status('./banco_arquivos/atributos_'.$server.'.eafc','nivel: '.$acao[0]."\n");
	@acao = &extrair_nome('<tr[^<>]*>[^<>]*<td[^<>]*>Total de ryous faturados:<\\\/td>[^<>]*<td>([^<>]+)<\\\/td>[^<>]*<\\\/tr>');
	$acao[0] =~ s/,00//i;
	$acao[0] =~ s/\D+//ig;
	&gravar_log('./banco_arquivos/atributos_'.$server.'.eafc','Total de ryous faturados: '.$acao[0]."\n");
	@acao = &extrair_nome('<tr[^<>]*>[^<>]*<td[^<>]*>Total de ryous perdidos:<\\\/td>[^<>]*<td>([^<>]+)<\\\/td>[^<>]*<\\\/tr>');
	$acao[0] =~ s/,00//i;
	$acao[0] =~ s/\D+//ig;
	&gravar_log('./banco_arquivos/atributos_'.$server.'.eafc','Total de ryous perdidos: '.$acao[0]."\n");
	@acao = &extrair_nome('<tr[^<>]*>[^<>]*<td[^<>]*>Combates:<\\\/td>[^<>]*<td>([^<>]+)<\\\/td>[^<>]*<\\\/tr>');
	$acao[0] =~ s/\D+//ig;
	&gravar_log('./banco_arquivos/atributos_'.$server.'.eafc','Combates: '.$acao[0]."\n");
	@acao = &extrair_nome('<tr[^<>]*>[^<>]*<td[^<>]*>Vit.{1,2}rias:<\\\/td>[^<>]*<td>([^<>]+)<\\\/td>[^<>]*<\\\/tr>');
	$acao[0] =~ s/\D+//ig;
	&gravar_log('./banco_arquivos/atributos_'.$server.'.eafc','Vitorias: '.$acao[0]."\n");
	@acao = &extrair_nome('<tr[^<>]*>[^<>]*<td[^<>]*>Derrotas:<\\\/td>[^<>]*<td>([^<>]+)<\\\/td>[^<>]*<\\\/tr>');
	$acao[0] =~ s/\D+//ig;
	&gravar_log('./banco_arquivos/atributos_'.$server.'.eafc','Derrotas: '.$acao[0]."\n");
	@acao = &extrair_nome('<tr[^<>]*>[^<>]*<td[^<>]*>Empates:<\\\/td>[^<>]*<td>([^<>]+)<\\\/td>[^<>]*<\\\/tr>');
	$acao[0] =~ s/\D+//ig;
	&gravar_log('./banco_arquivos/atributos_'.$server.'.eafc','Empates: '.$acao[0]."\n");
#########################################
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
@acao = &sugar_form_naruto($cookie[0],$cookie[1],$c_cookie,'','./auto_col_arquivos/col_caminhos.eafc');
@tabela = &extrair_tag('<table','<\\\/table>','<table','<\/table>');
if ($tabela[7] =~ /<td>Ryous:<\\\/td>[^<>]*<td[^<>]+colspan="4">([^<>]+)<\\\/td>/i){
$ryous = $1;
$ryous =~ s/,00//i;
$ryous =~ s/\D+//ig;
}else{
die "nao achou ryous--->\n";
}#se posicao
if ($tabela[7] =~ /<td>Taijutsu:<\\\/td>[^<>]*<td[^<>]*>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<\\\/td>[^<>]*<td>[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>[^<>]*<td>Valor:[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>/i){
$habili[0] = $1;
$p_habili[0] = $2;
$p_habili[0] =~ s/,00//i;
$p_habili[0] =~ s/\D+//ig;
}else{
die "nao achou tai--->\n";
}#se posicao
if ($tabela[7] =~ /<td>Ninjutsu:<\\\/td>[^<>]*<td[^<>]*>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<\\\/td>[^<>]*<td>[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>[^<>]*<td>Valor:[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>/i){
$habili[1] = $1;
$p_habili[1] = $2;
$p_habili[1] =~ s/,00//i;
$p_habili[1] =~ s/\D+//ig;
}else{
die "nao achou nin--->\n";
}#se posicao
if ($tabela[7] =~ /<td>Genjutsu:<\\\/td>[^<>]*<td[^<>]*>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<\\\/td>[^<>]*<td>[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>[^<>]*<td>Valor:[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>/i){
$habili[2] = $1;
$p_habili[2] = $2;
$p_habili[2] =~ s/,00//i;
$p_habili[2] =~ s/\D+//ig;
}else{
die "nao achou gen--->\n";
}#se posicao
if ($tabela[7] =~ /<td>Intelig.{1,2}ncia:<\\\/td>[^<>]*<td[^<>]*>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<img[^<>]+>[^<>]*<\\\/td>[^<>]*<td>[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>[^<>]*<td>Valor:[^<>]*<strong>([^<>]+)<\\\/strong>[^<>]*<\\\/td>/i){
$habili[3] = $1;
$p_habili[3] = $2;
$p_habili[3] =~ s/,00//i;
$p_habili[3] =~ s/\D+//ig;
}else{
die "nao achou int--->\n";
}#se posicao
$t_p_habili = @p_habili;
$ni = 0;
$saida = 1;
	while (($ni < $t_p_habili) && ($saida)){
	$saida = $ryous-$p_habili[$ni];
&gravar_log('./banco_arquivos/log_'.$server.'.eafc',"verificar $server\n");
if ($saida > 0){
if ($ni == 0){
$ryous = $ryous-$p_habili[$ni];
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@acao = &sugar_form_naruto($cookie[0],$cookie[1],$c_cookie,'treino=1','./auto_col_arquivos/col_caminhos.eafc');
$saida = 0;
&gravar_log('./banco_arquivos/log_'.$server.'.eafc',"treino=1\n");
}elsif ($ni == 1){
$ryous = $ryous-$p_habili[$ni];
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@acao = &sugar_form_naruto($cookie[0],$cookie[1],$c_cookie,'treino=2','./auto_col_arquivos/col_caminhos.eafc');
$saida = 0;
&gravar_log('./banco_arquivos/log_'.$server.'.eafc',"treino=2\n");
}elsif ($ni == 2){
$ryous = $ryous-$p_habili[$ni];
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@acao = &sugar_form_naruto($cookie[0],$cookie[1],$c_cookie,'treino=3','./auto_col_arquivos/col_caminhos.eafc');
$saida = 0;
&gravar_log('./banco_arquivos/log_'.$server.'.eafc',"treino=3\n");
}elsif ($ni == 3){
$ryous = $ryous-$p_habili[$ni];
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@acao = &sugar_form_naruto($cookie[0],$cookie[1],$c_cookie,'treino=4','./auto_col_arquivos/col_caminhos.eafc');
$saida = 0;
&gravar_log('./banco_arquivos/log_'.$server.'.eafc',"treino=4\n");
}#fin ni
}else{
$saida = 1;
}#se saida>0
	$ni++;
	}#while
if ($ni >= $t_p_habili){
$saida = 0;
}else{
$saida = 1;
}
&gravar_status('./banco_arquivos/ryous_'.$server.'.csv',$ryous);
$pega_parte = $habili[0].';;;'.$p_habili[0]."\n".$habili[1].';;;'.$p_habili[1]."\n".$habili[2].';;;'.$p_habili[2]."\n".$habili[3].';;;'.$p_habili[3];
&gravar_status('./banco_arquivos/score_'.$server.'.csv',$pega_parte);
return $saida;
}else{
die "nao achou form\n";
}
}else{
die "nao achou treino\n";
}
}

sub sugar_naruto {
my $arquivo = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $c_cookie_x = $c_cookie.'_x';
my $c_cookie_y = $c_cookie.'_y';
my $c_cookie_r = $c_cookie.'_r';
my $c_tempo = shift;
my $c_origem = shift;
my @galaxy = &ler_config('1','./auto_arquivos/config.eafc','ponto');
my $total;
my $conectar;
my $servidor = 1;
my $bi;
my $treino;
my @u_cookie;
my @nome;
my @acao;
my @linha;
my @cookie;
my @pausa = &ler_config('1','./auto_arquivos/config.eafc','reconectar');
my @atual = &ler_status('./auto_arquivos/tempo.eafc');
my @tempo = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo);
my @indi;
if ($tempo[0] < $atual[0]){
$tempo[0] = $atual[0]+$pausa[0];
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo[0]);
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
if ($cookie[1] ne 'nada'){
if ($cookie[0] eq 'www.narutoplayers.com'){
$servidor = 'server01';
}elsif ($cookie[0] eq 'server02.narutoplayers.com'){
$servidor = 'server02';
}elsif ($cookie[0] eq 'server03.narutoplayers.com'){
$servidor = 'server03';
}elsif ($cookie[0] eq 'server04.narutoplayers.com'){
$servidor = 'server04';
}elsif ($cookie[0] eq 'server05.narutoplayers.com'){
$servidor = 'server05';
}else{
die "nao identificou servidor\n";
}
@indi = &ler_config('1','./banco_arquivos/atributos_'.$servidor.'.eafc','nivel');
if ($indi[0] < 6){
$indi[0] = '1';
}elsif ($indi[0] >= 6){
$indi[0] = '2';
}elsif ($indi[0] >= 20){
$indi[0] = '3';
}elsif ($indi[0] >= 40){
$indi[0] = '4';
}elsif ($indi[0] >= 60){
$indi[0] = '5';
}elsif ($indi[0] >= 80){
$indi[0] = '6';
}else{
die "nao identificou nivel\n";
}
	@linha = &mod_solicitar($cookie[0],$cookie[1],$cookie[2].'; '.$cookie[3].'; '.$cookie[4].'; '.$cookie[5],'');
$conectar = &cliente_pagina($cookie[0],'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
if ($u_cookie[0] eq '?p=login'){
@acao = ();
&gravar_config('1',$arquivo,$c_nome,'nada');
print "novo login\n";
}elsif ($u_cookie[0] ne '1'){
@acao = $u_cookie[0];
}else{
@acao = &extrair_nome('<a[^<>]+href="([^"]+)"[^<>]*>Miss.{1,2}es<\\\/a>');
}
if ($acao[0]){
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
$acao[0] =~ s/^\///i;
$acao[0] =~ s/http:\/\///i;
$acao[0] =~ s/$cookie[0]\///i;
	&gravar_config('1',$arquivo,$c_nome,$acao[0]);
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
@atual = &sugar_form_naruto($cookie[0],$cookie[1],$c_cookie,'','./auto_col_arquivos/col_caminhos.eafc');
if ($indi[0] == 1){
@acao = &extrair_nome('<input[^<>]+(id="missao"[^<>]+value="1")[^<>]+\\\/>');
}elsif ($indi[0] == 2){
@acao = &extrair_nome('<input[^<>]+(id="missao"[^<>]+value="2")[^<>]+\\\/>');
}elsif ($indi[0] == 3){
@acao = &extrair_nome('<input[^<>]+(id="missao"[^<>]+value="3")[^<>]+\\\/>');
}elsif ($indi[0] == 4){
@acao = &extrair_nome('<input[^<>]+(id="missao"[^<>]+value="4")[^<>]+\\\/>');
}elsif ($indi[0] == 5){
@acao = &extrair_nome('<input[^<>]+(id="missao"[^<>]+value="5")[^<>]+\\\/>');
}elsif ($indi[0] == 6){
@acao = &extrair_nome('<input[^<>]+(id="missao"[^<>]+value="6")[^<>]+\\\/>');
}else{
die "valor de missoes nao definido\n";
}
if ($atual[5] && $acao[0]) {
	@atual = &garimpar_tag('0','2','input','name','value',$atual[5]);
$total = &criar_linha_missao($indi[0],@atual);
$treino = 1;
while ($treino){
$treino = &banco_naruto($c_origem,$c_nome,$c_cookie,$servidor);
#desabilita = 0 habilita = $treina
if (0){
	@acao = &extrair_nome('<a[^<>]+href="([^"]+)"[^<>]*>Status<\\\/a>');
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
$acao[0] =~ s/^\///i;
$acao[0] =~ s/http:\/\///i;
$acao[0] =~ s/$cookie[0]\///i;
	&gravar_config('1',$arquivo,$c_nome,$acao[0]);
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@linha = &mod_solicitar($cookie[0],$cookie[1],$cookie[2].'; '.$cookie[3].'; '.$cookie[4].'; '.$cookie[5],'');
$conectar = &cliente_pagina($cookie[0],'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
if ($u_cookie[0] eq '?p=login'){
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome,'nada');
print "novo login\n";
}
}#fim se treino
}#fim while
@acao = &extrair_nome('<a[^<>]+href="([^"]+)"[^<>]*>Miss.{1,2}es<\\\/a>');
if ($acao[0]){
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
$acao[0] =~ s/^\///i;
$acao[0] =~ s/http:\/\///i;
$acao[0] =~ s/$cookie[0]\///i;
	&gravar_config('1',$arquivo,$c_nome,$acao[0]);
}else{
die "nao achou missoes\n";
}
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@linha = &mod_solicitar($cookie[0],$cookie[1],$cookie[2].'; '.$cookie[3].'; '.$cookie[4].'; '.$cookie[5],$total);
$conectar = &cliente_pagina($cookie[0],'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
if ($u_cookie[0] eq '?p=login'){
&gravar_config('1',$arquivo,$c_nome,'nada');
print "novo login\n";
}
&gravar_log('./banco_arquivos/log_'.$servidor.'.eafc',"$total\n-------------\n");
}else{
@acao = &extrair_nome('(ATEN.{1,2}.{1,2}O - Voc.{1,2} est.{1,2} ocupado)');
if ($acao[0]){
print "$acao[0]\n";
&gravar_log('./banco_arquivos/log_'.$servidor.'.eafc',"$acao[0]\n-------------\n");
}else{
print "nao achou form e tag\n";
&gravar_log('./banco_arquivos/log_'.$servidor.'.eafc',"nao achou form e tag\n-------------\n");
}
@acao = &extrair_nome('clique[^<>]+<a[^<>]+href=(\S+)[^<>]*>aqui<\\\/a>[^<>]+para[^<>]+receber');
if ($acao[0]){
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
$acao[0] =~ s/\'//ig;
$acao[0] =~ s/^\///i;
$acao[0] =~ s/http:\/\///i;
$acao[0] =~ s/$cookie[0]\///i;
	&gravar_config('1',$arquivo,$c_nome,$acao[0]);
}else{
@acao = &extrair_nome('<a[^<>]+href="([^"]+)"[^<>]*>Miss.{1,2}es<\\\/a>');
if ($acao[0]){
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
$acao[0] =~ s/\'//ig;
$acao[0] =~ s/^\///i;
$acao[0] =~ s/http:\/\///i;
$acao[0] =~ s/$cookie[0]\///i;
	&gravar_config('1',$arquivo,$c_nome,$acao[0]);
}#se missao
}#se aqui
}#se form e tag
}else{
	&gravar_config('1',$arquivo,$c_nome,'nada');
print "sessao nao encontrada\n";
}
}else{
print "nome nao encontrado\n";
}
}#se tempo
}

sub criar_linha_missao {
my $missao = shift;
my @atual = @_;
my @saida;
my $total;
my $bi;
my $ti=0;
my $rad;
$total = @atual;
	for ($bi=0; $bi<$total; $bi++){
	if ($atual[$bi] eq 'missao'){
	$bi++;
	$saida[$ti] = 'missao';
	$ti++;	
	$saida[$ti] = $missao;
	$ti++;	
	}elsif ($atual[$bi] eq 'confirmar'){
	$bi++;
	}else{
	$saida[$ti] = $atual[$bi];
	$ti++;
	}#fim se
	}#fim for
@atual = &hex_get(@saida);
@atual = &formar_get1(@atual);
$total = &formar_get2(@atual);
$total = 'tempo_missao=1&'.$total;
return $total;
}

sub criar_linha_naruto {
my $login = shift;
my $senha = shift;
my $origem = shift;
my @atual = @_;
my @saida;
my $total;
my $bi;
my $ti=0;
my $rad;
$total = @atual;
	for ($bi=0; $bi<$total; $bi++){
	if ($atual[$bi] eq 'usuario'){
	$bi++;
	$saida[$ti] = 'usuario';
	$ti++;	
	$saida[$ti] = $login;
	$ti++;	
	}elsif ($atual[$bi] eq 'senha'){
	$bi++;
	$saida[$ti] = 'senha';
	$ti++;	
	$saida[$ti] = $senha;
	$ti++;	
	}elsif ($atual[$bi] eq 'Button1'){
	$bi++;
	$saida[$ti] = 'menu1';
	$ti++;	
	$saida[$ti] = $origem;
	$ti++;	
	}elsif ($atual[$bi] eq 'confirmar'){
	$bi++;
	}else{
	$saida[$ti] = $atual[$bi];
	$ti++;
	}#fim se
	}#fim for
@atual = &hex_get(@saida);
@atual = &formar_get1(@atual);
$total = &formar_get2(@atual);
return $total;
}

sub sugar_cookie_naruto {
my $arquivo = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $c_cookie_x = $c_cookie.'_x';
my $c_cookie_y = $c_cookie.'_y';
my $c_cookie_r = $c_cookie.'_r';
my $origem = shift;
my $caminho = shift;
my $linha = shift;
my $conectar;
my @linha;
my @u_cookie;
	@linha = &mod_solicitar($origem,'','','');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
	if (($u_cookie[0] ne '1') && ($c_nome)){
	$u_cookie[0] =~ s/^\///i;
	&gravar_config('1',$arquivo,$c_nome,$u_cookie[0]);
	}elsif ($c_nome){
	&gravar_config('1',$arquivo,$c_nome,'nada');
die "nao achou location\n";
	}#fim se
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	}else{
die "nao achou cookie\n";
	}#fim se
	return 'tudo ok';
}

sub sugar_cookie_naruto2 {
my $arquivo = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $c_cookie_x = $c_cookie.'_x';
my $c_cookie_y = $c_cookie.'_y';
my $c_cookie_r = $c_cookie.'_r';
my $origem = shift;
my $caminho = shift;
my $linha = shift;
my $conectar;
my @parte;
my @linha;
my	@cookie = &ler_config('2','./auto_col_arquivos/col_caminhos.eafc',$c_nome,$c_cookie);
my @u_cookie;
my @u_cookie2;
	@linha = &mod_solicitar($origem,$cookie[0],$cookie[1],$linha);
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
	if (($u_cookie[0] ne '1') && ($c_nome)){
	$u_cookie[0] =~ s/^\///i;
	&gravar_config('1',$arquivo,$c_nome,$u_cookie[0]);
	}elsif ($c_nome){
	&gravar_config('1',$arquivo,$c_nome,'nada');
die "nao achou location\n";
	}#fim se
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	@u_cookie2 = &ler_status('./auto_arquivos/ultima5.eafc');
	if (($u_cookie[0] ne '1') && ($u_cookie2[0] ne '1') && ($c_cookie_x)){
	&gravar_config('1',$arquivo,$c_cookie_x,$u_cookie2[0].'; '.$u_cookie[0]);
	}else{
die "nao achou cookie_x\n";
	}#fim se
	@u_cookie = &ler_status('./auto_arquivos/ultima2.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie_y)){
	&gravar_config('1',$arquivo,$c_cookie_y,$u_cookie[0]);
	}else{
die "nao achou cookie_y\n";
	}#fim se
	@u_cookie = &ler_status('./auto_arquivos/ultima3.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie_r)){
	&gravar_config('1',$arquivo,$c_cookie_r,$u_cookie[0]);
	}else{
die "nao achou cookie_r\n";
	}#fim se
	return 'tudo ok';
}

sub sugar_nome_naruto {
my $arquivo = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $c_cookie_x = $c_cookie.'_x';
my $c_cookie_y = $c_cookie.'_y';
my $c_cookie_r = $c_cookie.'_r';
my $c_origem = shift;
my $local;
my $conectar;
my @u_cookie;
my @nome;
my @acao;
my @linha;
my @cookie;
	@cookie = &ler_config('6','./auto_col_arquivos/col_caminhos.eafc',$c_origem,$c_nome,$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@linha = &mod_solicitar($cookie[0],$cookie[1],$cookie[2].'; '.$cookie[3].'; '.$cookie[4].'; '.$cookie[5],'');
$conectar = &cliente_pagina($cookie[0],'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
if ($u_cookie[0] eq '?p=login'){
die "novo login\n";
}elsif ($u_cookie[0] ne '1'){
@nome = $u_cookie[0];
}else{
@nome = &extrair_nome('<a[^<>]+href="([^"]+)"[^<>]*>Miss.{1,2}es<\\\/a>');
##@nome = &extrair_nome('<a[^<>]+href="([^"]+)"[^<>]*>Status<\\\/a>');
}
@nome = &string_expressao(@nome);
@nome = &codigo_html(@nome);
if ($nome[0]){
	$nome[0] =~ s/^\///i;
	$nome[0] =~ s/http:\/\///i;
	$nome[0] =~ s/$cookie[0]\///i;
	&gravar_config('1',$arquivo,$c_nome,$nome[0]);
print "$nome[0]-----------------\n";
}else{
	&gravar_config('1',$arquivo,$c_nome,'nada');
print "nome nao encontrado\n";
}
}

sub sugar_form_naruto {
my $origem = shift;
my $caminho = shift;
my $c_cookie = shift;
my $c_cookie_x = $c_cookie.'_x';
my $c_cookie_y = $c_cookie.'_y';
my $c_cookie_r = $c_cookie.'_r';
my $linha_form = shift;
my $arquivo = shift;
my $conectar;
my @u_cookie;
my @linha;
my @cookie;
	@cookie = &ler_config('4','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$c_cookie_x,$c_cookie_y,$c_cookie_r);
	@linha = &mod_solicitar($origem,$caminho,$cookie[0].'; '.$cookie[1].'; '.$cookie[2].'; '.$cookie[3],$linha_form);
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/location.eafc');
if ($u_cookie[0] eq '?p=login'){
die "novo login\n";
}
	@linha = &extrair_tag('<form','<\\\/form>','<form','<\/form>');
return @linha;
}

1;

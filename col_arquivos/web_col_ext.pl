## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub mercado_cheio {
my $nome = shift;
my $total;
my $ima;
my $ime;
my $maior;
my $menor;
my $i;
my @banco;
my @mat;
my @t_mat;
$total = './auto_col_arquivos/mat_'.$nome.'.csv';
@banco = &ler_status($total);
$total = @banco;
for ($i=0; $i<$total; $i++){
if ($banco[$i] =~ /^(\d+);(\d+)$/){
$mat[$i] = $1;
$t_mat[$i] = $2;
}#fim se banco
}#fim for
$menor=200000;
$maior=0;
for ($i=0; $i<$total; $i++){
if ($mat[$i]<$menor){
$menor=$mat[$i];
$ime=$i;
}#fim se
if ($maior<$mat[$i]){
$maior=$mat[$i];
$ima=$i;
}#fim se
}#fim for
###1200,1700,3100
$nome = $t_mat[$ima]-200;
if (($mat[$ima] >= $nome) && ($t_mat[$ima] >= 1700)){
print $mat[$ima].'-> ';
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$mat[$ima].'-> ');
if ($ima == 0){
$ima = 'madeira';
}elsif ($ima == 1){
$ima = 'barro';
}elsif ($ima == 2){
$ima = 'ferro';
}elsif ($ima == 3){
$ima = 'cereal';
}#fim se
print $ima."---------\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$ima."---------\n");
print $mat[$ime].'-> ';
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$mat[$ime].'-> ');
if ($ime == 0){
$ime = 'madeira';
}elsif ($ime == 1){
$ime = 'barro';
}elsif ($ime == 2){
$ime = 'ferro';
}elsif ($ime == 3){
$ime = 'cereal';
}#fim se
print $ime."---------\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$ime."---------\n");
@banco = ($ima,$ime);
}else{
@banco = (0,0);
}#fim se >=
return @banco;
}

sub mercado_cami {
my $nome = shift;
my $cami_mer=0;
my @banco;
my @mapa;
my $total;
my $i;
$total = './auto_col_arquivos/cid_'.$nome.'.csv';
@banco = &ler_status($total);
chomp(@banco);
$total = @banco;
for ($i=0; $i<$total; $i++){
@mapa = split(/;/,$banco[$i]);
if ($mapa[7] =~ /^Mercado$/i){
$cami_mer = $mapa[5];
}#fim se mercado
}#fim for
if ($cami_mer){
return $cami_mer;
}else{
return 0;
}#fim se cami
}

sub quartel_cami {
my $nome = shift;
my $cami_mer=0;
my @banco;
my @mapa;
my $total;
my $i;
$total = './auto_col_arquivos/cid_'.$nome.'.csv';
@banco = &ler_status($total);
chomp(@banco);
$total = @banco;
for ($i=0; $i<$total; $i++){
@mapa = split(/;/,$banco[$i]);
if (($mapa[7] =~ /^Quartel$/i) && ($mapa[8] >= 5)){
$cami_mer = $mapa[5];
}#fim se mercado
}#fim for
if ($cami_mer){
return $cami_mer;
}else{
return 0;
}#fim se cami
}

sub fabrica_cami {
my $nome = shift;
my $cami_mer=0;
my @banco;
my @mapa;
my $total;
my $i;
$total = './auto_col_arquivos/cid_'.$nome.'.csv';
@banco = &ler_status($total);
chomp(@banco);
$total = @banco;
for ($i=0; $i<$total; $i++){
@mapa = split(/;/,$banco[$i]);
if ($mapa[7] =~ /^F.{1,2}brica de Armadilhas$/i){
$cami_mer = $mapa[5];
}#fim se mercado
}#fim for
if ($cami_mer){
return $cami_mer;
}else{
return 0;
}#fim se cami
}

sub ponto_cami {
my $nome = shift;
my $cami_mer=0;
my @banco;
my @mapa;
my $total;
my $i;
$total = './auto_col_arquivos/cid_'.$nome.'.csv';
@banco = &ler_status($total);
chomp(@banco);
$total = @banco;
for ($i=0; $i<$total; $i++){
@mapa = split(/;/,$banco[$i]);
if ($mapa[7] =~ /^Ponto de Reuni.{2,4}o Militar$/i){
$cami_mer = $mapa[5];
}#fim se mercado
}#fim for
if ($cami_mer){
return $cami_mer;
}else{
return 0;
}#fim se cami
}

sub ponto_soldados {
my $nome = shift;
my $cami_mer=0;
my @banco;
my @mapa;
my $total;
my $i;
$total = './auto_col_arquivos/tro_'.$nome.'.csv';
@banco = &ler_status($total);
chomp(@banco);
$total = @banco;
for ($i=0; $i<$total; $i++){
@mapa = split(/;/,$banco[$i]);
if ($mapa[1]){
if ($mapa[1] =~ /^espadachi/i){
$cami_mer = $mapa[0];
}#fim se mercado
}#se mapa1
}#fim for
if ($cami_mer){
return $cami_mer;
}else{
return 0;
}#fim se cami
}

sub mercado_lista{
my $maior = shift;
my $menor = shift;
my $total;
my $casa=0;
my $b;
my $amigo;
my @tempo;
my @banco;
my @mapa;
$total = './auto_col_arquivos/u_mercado.csv';
@banco = &ler_status($total);
chomp(@banco);
$total = @banco;
$amigo = &mod_agrupar('00',&ler_config('1','./auto_arquivos/config.eafc','nome_mercado'));
for ($b=$total-1; $b>=0; $b--){
@mapa = split(/;/,$banco[$b]);
### 750,1500
if (($mapa[0] eq $menor) && ($mapa[2] eq $maior) && ($mapa[3] <= 750) && ($mapa[1] >= $mapa[3])){
@tempo = split(/:/, $mapa[5]);
@tempo = &trans_tempo(@tempo);
### 21600,28800
if ($tempo[0] <= 28800){
@tempo = &string_expressao($mapa[6]);
print $mapa[0].': '.$mapa[1].' - '.$mapa[2].': '.$mapa[3].' - '.$mapa[5]."---------mercado\n\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$mapa[0].': '.$mapa[1].' - '.$mapa[2].': '.$mapa[3].' - '.$mapa[5]."---------mercado\n");
$casa = $tempo[0];
}#se tempo
}elsif ($mapa[4] eq $amigo){
@tempo = &string_expressao($mapa[6]);
print $mapa[0].': '.$mapa[1].' - '.$mapa[2].': '.$mapa[3].' - '.$mapa[4]."---------mercado\n\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$mapa[0].': '.$mapa[1].' - '.$mapa[2].': '.$mapa[3].' - '.$mapa[4]."---------mercado\n");
$casa = $tempo[0];
$b = -1;
}#se eq
}#fim for
if ($casa){
return $casa;
}else{
return 0;
}#fim se
}

sub criar_linha_login {
my $login = shift;
my $senha = shift;
my @atual = @_;
my @saida;
my $total;
my $bi;
my $ni=0;
my $rad;
$total = @atual;
	for ($bi=0; $bi<$total; $bi++){
	if ($atual[$bi] eq 'w'){
	$bi++;
	$saida[$ni] = 'w';
	$ni++;
	$saida[$ni] = '1024:768';
	$ni++;
	}elsif ($atual[$bi] eq 'name'){
	$bi++;
	$saida[$ni] = 'name';
	$ni++;
	$saida[$ni] = $login;
	$ni++;
	}elsif ($atual[$bi] eq 'password'){
	$bi++;
	$saida[$ni] = 'password';
	$ni++;
	$saida[$ni] = $senha;
	$ni++;
	}else{
	$saida[$ni] = $atual[$bi];
	$ni++;
	}#fim se
	}#fim for
@atual = &hex_get(@saida);
@atual = &formar_get1(@atual);
$total = &formar_get2(@atual);
@atual = &ler_status('./banco_arquivos/segredo_login.eafc');
chomp(@atual);
$rad = @atual;
$rad = rand($rad);
$total =~ s/&s1=login/$atual[$rad]/i;
return $total;
}

sub criar_linha_ok {
my $soldado = shift;
my @atual = @_;
my $total;
my $bi;
my $rad;
$total = pop(@atual);
$total = pop(@atual);
$total = @atual;
	for ($bi=0; $bi<$total; $bi++){
	if ($atual[$bi] eq 't2'){
	$atual[$bi+1] = $soldado;
	}elsif ($atual[$bi] eq 't99'){
	$atual[$bi+1] = $soldado;
	}#fim se
	}#fim for
@atual = &hex_get(@atual);
@atual = &formar_get1(@atual);
$total = &formar_get2(@atual);
@atual = &ler_status('./banco_arquivos/segredo_ok.eafc');
chomp(@atual);
$rad = @atual;
$rad = rand($rad);
$total = $total.$atual[$rad];
return $total;
}

sub criar_linha_ok_tropas1 {
my $soldado = shift;
my $cordx = shift;
my $cordy = shift;
my @atual = @_;
my @novo;
my $total;
my $bi;
my $ni=0;
my $rad;
$total = pop(@atual);
$total = pop(@atual);
$total = @atual;
##	$nome =~ s/^s7(.+)$/$1/i;
	for ($bi=0; $bi<$total; $bi++){
	if (($atual[$bi] eq 'c') && ($atual[$bi+1] ne '4')){
	$bi++;
	}elsif ($atual[$bi] eq 't2'){
	$bi++;
	$novo[$ni] = 't2';
	$ni++;
	$novo[$ni] = $soldado;
	$ni++;
	}elsif ($atual[$bi] eq 'x'){
	$bi++;
	$novo[$ni] = 'x';
	$ni++;
	$novo[$ni] = $cordx;
	$ni++;
	}elsif ($atual[$bi] eq 'y'){
	$bi++;
	$novo[$ni] = 'y';
	$ni++;
	$novo[$ni] = $cordy;
	$ni++;
	}else{
	$novo[$ni] = $atual[$bi];
	$ni++;
	}#fim se
	}#fim for
@atual = &hex_get(@novo);
@atual = &formar_get1(@atual);
$total = &formar_get2(@atual);
@atual = &ler_status('./banco_arquivos/segredo_ok_tropas.eafc');
chomp(@atual);
$rad = @atual;
$rad = rand($rad);
$total = $total.$atual[$rad];
return $total;
}

sub criar_linha_ok_tropas2 {
my @atual = @_;
my $total;
my $bi;
my $ni=0;
my $rad;
$total = pop(@atual);
$total = pop(@atual);
@atual = &hex_get(@atual);
@atual = &formar_get1(@atual);
$total = &formar_get2(@atual);
@atual = &ler_status('./banco_arquivos/segredo_ok_tropas.eafc');
chomp(@atual);
$rad = @atual;
$rad = rand($rad);
$total = $total.$atual[$rad];
return $total;
}

sub ver_producao {
my $fonte = shift;
my $mat = shift;
my @b_fonte;
my @b_mat;
my @m_fonte;
my @m_mat;
my $t_fonte;
my $bi;
@b_fonte = &ler_status($fonte);
chomp(@b_fonte);
@b_fonte = &expressao_string(@b_fonte);
$t_fonte = @b_fonte;
@b_mat = &ler_status($mat);
chomp(@b_mat);
@b_mat = &expressao_string(@b_mat);
for ($bi=0; $bi<$t_fonte; $bi++){
@m_fonte = split(/;/,$b_fonte[$bi]);
if ($bi>=1){
@m_mat = split(/;/,$b_mat[$bi-1]);
}
if ($m_fonte[1]){
if ($m_fonte[1] < 0){
print "$fonte--------------------------------\n";
print $m_fonte[0].' '.$m_fonte[1]." producao negativa\n";
print $m_mat[0]." no estoque\n";
print "--------------------------------\n\n";
&gravar_log('./auto_col_arquivos/aaa_log_perigo.eafc',"$fonte-----------------------------\n".$m_fonte[0].' '.$m_fonte[1]." producao negativa\n".$m_mat[0]." no estoque\n-----------------------------\n\n");
}#fim se
}#fim se
}#for
}

sub comparar_copia {
my $fonte = shift;
my $copia = shift;
my @b_fonte;
my @b_copia;
my @m_fonte;
my @m_copia;
my $t_fonte;
my $t_copia;
my $bi;
my $vi;
my $resu=0;
my $nada;
@b_fonte = &ler_status($fonte);
chomp(@b_fonte);
@b_fonte = &expressao_string(@b_fonte);
$t_fonte = @b_fonte;
@b_copia = &ler_status($copia);
chomp(@b_copia);
@b_copia = &expressao_string(@b_copia);
$t_copia = @b_copia;
for ($bi=0; $bi<$t_copia; $bi++){
@m_copia = split(/;/,$b_copia[$bi]);
$nada = 1;
for ($vi=0; $vi<$t_fonte; $vi++){
@m_fonte = split(/;/,$b_fonte[$vi]);
if ($m_fonte[5] eq $m_copia[5]){
$nada = 0;
if ($m_fonte[8] < $m_copia[8]){
print "$copia--------------------------------\n";
print $m_copia[7].' -- '.$m_copia[5]." foi atacado\n";
print "--------------------------------\n\n";
&gravar_log('./auto_col_arquivos/aaa_log_perigo.eafc',"$copia-----------------------------\n".$m_copia[7].' -- '.$m_copia[5]." foi atacado\n-----------------------------\n\n");
$resu++;
}#fim se <
}#fim se
}#for
if ($nada){
print "$copia--------------------------------\n";
print $m_copia[7].' -- '.$m_copia[5]." foi destruido\n";
print "--------------------------------\n\n";
&gravar_log('./auto_col_arquivos/aaa_log_perigo.eafc',"$copia-----------------------------\n".$m_copia[7].' -- '.$m_copia[5]." foi destruido\n-----------------------------\n\n");
$resu++;
}#se nada
}#for
return $resu;
}

sub colonizar {
my $fome = shift;
my $prefixo = shift;
my $nome = shift;
my $tempo = &log_tempo();
my $total;
my $conta = 0;
my @banco;
my @materia;
my @mapa;
my $b;
my $i;
$total = './auto_col_arquivos/'.$prefixo.'_'.$nome.'.csv';
@banco = &ler_status($total);
chomp(@banco);
$total = './auto_col_arquivos/mat_'.$nome.'.csv';
@materia = &ler_status($total);
$total = @materia;
for ($i=0; $i<$total; $i++){
if ($materia[$i] =~ /^(\d+);\d+$/){
$materia[$i] = $1;
}#fim se
}#fim for
$total = @banco;
for ($b=0; $b<$total; $b++){
@mapa = split(/;/,$banco[$b]);
$conta = 0;
for ($i=0; $i<4; $i++){
if (($mapa[7] !~ /^Campo de Cereal$/i) && ($fome == 1)){
$mapa[$i] = 200000;
}#fim se
if ($mapa[$i] <= $materia[$i]){
$conta++;
}#fim se
}#fim for
if ($conta == 4){
$b = $total;
}#fim se
}#fim for
if ($conta == 4){
&gravar_log('./auto_col_arquivos/aaa_log.eafc',"-----------------------------\n".$nome.' - '.$mapa[4].' - '.$mapa[5].' - '.$mapa[7].' - '.$mapa[8].' - '.$tempo."\n");
@mapa = ($mapa[5],$mapa[4]);
return @mapa;
}else{
&gravar_log('./auto_col_arquivos/aaa_log.eafc',"-----------------------------\n".$nome.' - nenhum - '.$tempo."\n");
#print $nome." - nenhum\n";
@mapa = (0,0);
return @mapa;
}#fim else
}

sub colonizar_sub {
my $origem = shift;
my $tempo = shift;
my $recurso = shift;
my $c_nome = shift;
my $c_tempo = shift;
my $c_cookie = shift;
my $c_escudo_x = shift;
my $c_escudo_y = shift;
my @ancoras;
my @nome;
my $caminho;
my $banco;
my $bi;
my @atual = &ler_status('./auto_arquivos/tempo.eafc');
if ($tempo < $atual[0]){
@nome = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome);
if ($nome[0] ne 'nada'){
$caminho = './auto_col_arquivos/anco_'.$nome[0].'.csv';
if ( -e $caminho){
@ancoras = &ler_status($caminho);
chomp(@ancoras);
$caminho = @ancoras;
	if ($caminho){
		for ($bi=$caminho-1; $bi>=0; $bi--){
		if ($bi == 0){
	if ($nome[0] =~ /^s3/i){	
		$banco = './banco_arquivos/ativo1_s3.eafc';
	}elsif($nome[0] =~ /^s4/i){
		$banco = './banco_arquivos/ativo1_s4.eafc';
	}
		}else{
	if ($nome[0] =~ /^s3/i){	
		$banco = './banco_arquivos/ativo2_s3.eafc';
	}elsif($nome[0] =~ /^s4/i){
		$banco = './banco_arquivos/ativo2_s4.eafc';
	}
		}#fim else
		&gravar_log('./auto_col_arquivos/aaa_log.eafc','------casa '.$bi."\n");
		&colonizar_ato($banco,$origem,$atual[0],$recurso,$c_nome,$c_tempo,$c_cookie,$c_escudo_x,$c_escudo_y,$ancoras[$bi]);
		}#fim for
	}else{
	if ($nome[0] =~ /^s3/i){	
	$banco = './banco_arquivos/ativou_s3.eafc';
	&colonizar_ato($banco,$origem,$atual[0],$recurso,$c_nome,$c_tempo,$c_cookie,$c_escudo_x,$c_escudo_y,'');
	}elsif($nome[0] =~ /^s4/i){
	$banco = './banco_arquivos/ativou_s4.eafc';
	&colonizar_ato($banco,$origem,$atual[0],$recurso,$c_nome,$c_tempo,$c_cookie,$c_escudo_x,$c_escudo_y,'');
	}
	}#fim se caminho
}else{
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome,'nada');
}#fim se existe arquivo
}#fim se nome
}#fim se tempo
}

sub ativar_auto {
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c1_nome','c1_cookie','c1_tempo','c1_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c2_nome','c2_cookie','c2_tempo','c2_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c3_nome','c3_cookie','c3_tempo','c3_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c4_nome','c4_cookie','c4_tempo','c4_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c5_nome','c5_cookie','c5_tempo','c5_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c6_nome','c6_cookie','c6_tempo','c6_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c7_nome','c7_cookie','c7_tempo','c7_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c8_nome','c8_cookie','c8_tempo','c8_origem');
&sugar_naruto('./auto_col_arquivos/col_caminhos.eafc','c9_nome','c9_cookie','c9_tempo','c9_origem');
####&tempo_campos();
}

sub quartel_sub {
my $origem = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $fixo = shift;
my @ancoras;
my @nome;
my $caminho;
my $bi;
@nome = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome);
if ($nome[0] ne 'nada'){
$caminho = './auto_col_arquivos/anco_'.$nome[0].'.csv';
if ( -e $caminho){
@ancoras = &ler_status($caminho);
chomp(@ancoras);
$caminho = @ancoras;
if ($caminho){
for ($bi=$caminho-1; $bi>=0; $bi--){
&quartel_ato($origem,$c_nome,$c_cookie,$fixo,$ancoras[$bi]);
}#fim for
}else{
&quartel_ato($origem,$c_nome,$c_cookie,$fixo,'');
}#fim se caminho
}#fim se existe arquivo
}#fim se nome
}

sub fabrica_sub {
my $origem = shift;
my $c_nome = shift;
my $c_cookie = shift;
my @ancoras;
my @nome;
my $caminho;
my $bi;
@nome = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome);
if ($nome[0] ne 'nada'){
$caminho = './auto_col_arquivos/anco_'.$nome[0].'.csv';
if ( -e $caminho){
@ancoras = &ler_status($caminho);
chomp(@ancoras);
$caminho = @ancoras;
if ($caminho){
for ($bi=$caminho-1; $bi>=0; $bi--){
&fabrica_ato($origem,$c_nome,$c_cookie,$ancoras[$bi]);
}#fim for
}else{
&fabrica_ato($origem,$c_nome,$c_cookie,'');
}#fim se caminho
}#fim se existe arquivo
}#fim se nome
}

sub colonizar_ato {
my $banco = shift;
my $origem = shift;
my @atual = shift;
my $recurso = shift;
my $c_nome = shift;
my $c_tempo = shift;
my $c_cookie = shift;
my $c_escudo_x = shift;
my $c_escudo_y = shift;
my $ancoras = shift || '';
my	$status = 0;
my $tempo;
my $conectar;
my @nome;
my @casa;
my @acao;
my @mensagem;
my @parte;
my @linha;
my @cookie;
my @u_cookie;
my @pausa = &ler_config('1','./auto_arquivos/config.eafc','reconectar');
my @pagina = &ler_config('5','./auto_col_arquivos/endereco.eafc','pagina0','pagina1','pagina2','pagina3','pagina4');
if ($ancoras){
$pagina[1] = $pagina[1].'?'.$ancoras;
$pagina[2] = $pagina[2].'?'.$ancoras;
$pagina[3] = $pagina[3].'?'.$ancoras;
$pagina[4] = $pagina[4].'?'.$ancoras;
}
###daqui
&sugar_dados($banco,'./auto_col_arquivos/col_caminhos.eafc',$c_nome,$c_cookie,$recurso,$origem,$pagina[1],$pagina[2],$pagina[3],$pagina[4]);
@nome = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome);
if ($nome[0] ne 'nada'){
@acao = &ler_config('1','./auto_arquivos/config.eafc','nome_fome');
if ($nome[0] ne $acao[0]){
@casa = &colonizar('0','cid',$nome[0]);
if ($casa[0]){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	@acao = &extrair_nome('<a[^<>]+href="([^<>]+)">Melhorar\spara\sn.{1,2}vel\s\d+<\\\/a>');
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
	if ($acao[0]){
	$tempo = $atual[0]+$pausa[0];
	$status = 1;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"melhorando construcao\n\n");
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$acao[0],$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	}#fim se
	@acao = &extrair_nome('(Falta\scomida:\saumente\so\sn.{1,2}vel\sdos\scampos\sde\scereais\sprimeiro)');
	if ($acao[0]){
	$status = 2;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"nao foi possivel melhorar\n\n");
	}#fim se
	@acao = &extrair_nome('(Os\strabalhadores\sj.{1,2}\sest.{1,2}o\socupados)');
	if ($acao[0]){
	$tempo = $atual[0]+$pausa[0];
	$status = 3;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"nao foi possivel melhorar\n\n");
&ponto_ato($origem,$c_cookie,$c_escudo_x,$c_escudo_y,$nome[0]);
&mercado_ato($origem,$c_cookie,$nome[0]);
	}#fim se
	@acao = &extrair_nome('(Poucos\srecusos)');
	if ($acao[0]){
	$tempo = $atual[0]+$pausa[0];
	$status = 4;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"nao foi possivel melhorar\n\n");
&ponto_ato($origem,$c_cookie,$c_escudo_x,$c_escudo_y,$nome[0]);
&mercado_ato($origem,$c_cookie,$nome[0]);
	}#fim se
}#fim se colonizar
if (($status != 1) && ($status != 2) && ($status != 3) && ($status != 4)){
@casa = &colonizar('0','cam',$nome[0]);
if ($casa[0]){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	@acao = &extrair_nome('<a[^<>]+href="([^<>]+)">Melhorar\spara\sn.{1,2}vel\s\d+<\\\/a>');
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
	if ($acao[0]){
	$tempo = $atual[0]+$pausa[0];
	$status = 1;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"melhorando construcao\n\n");
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$acao[0],$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	}#fim se melhorar
	@acao = &extrair_nome('(Falta\scomida:\saumente\so\sn.{1,2}vel\sdos\scampos\sde\scereais\sprimeiro)');
	if ($acao[0]){
	$status = 2;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"nao foi possivel melhorar\n\n");
	}#fim se
	@acao = &extrair_nome('(Os\strabalhadores\sj.{1,2}\sest.{1,2}o\socupados)');
	if ($acao[0]){
	$tempo = $atual[0]+$pausa[0];
	$status = 3;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"nao foi possivel melhorar\n\n");
&ponto_ato($origem,$c_cookie,$c_escudo_x,$c_escudo_y,$nome[0]);
&mercado_ato($origem,$c_cookie,$nome[0]);
	}#fim se
	@acao = &extrair_nome('(Poucos\srecusos)');
	if ($acao[0]){
	$tempo = $atual[0]+$pausa[0];
	$status = 4;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"nao foi possivel melhorar\n\n");
&ponto_ato($origem,$c_cookie,$c_escudo_x,$c_escudo_y,$nome[0]);
&mercado_ato($origem,$c_cookie,$nome[0]);
	}#fim se
}#fim se colonizar
}#fim se status
}else{
	$status = 2;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome[0]."\n");
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"definido somente cereais\n");
}#fim se nome
if ($status == 2){
@casa = &colonizar('1','cam',$nome[0]);
if ($casa[0]){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	@acao = &extrair_nome('<a[^<>]+href="([^<>]+)">Melhorar\spara\sn.{1,2}vel\s\d+<\\\/a>');
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
	if ($acao[0]){
	$tempo = $atual[0]+$pausa[0];
	$status = 1;
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$acao[0]."\n");
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"melhorando construcao\n\n");
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$acao[0],$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	}else{
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',"verificar erro\n");
	$status = 0;
	}
}else{
$status = 0;
}
}#fim se status
if (($status != 1) && ($status != 2) && ($status != 3) && ($status != 4)){
$tempo = $atual[0]+$pausa[0];
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo,$tempo);
&gravar_log('./auto_col_arquivos/aaa_log.eafc',"sem materiais suficientes\n\n");
&ponto_ato($origem,$c_cookie,$c_escudo_x,$c_escudo_y,$nome[0]);
&mercado_ato($origem,$c_cookie,$nome[0]);
}#fim se status
}#fim se nome
}

sub mercado_ato {
my $origem = shift;
my $c_cookie = shift;
my $nome = shift;
my $conectar;
my $i;
my @acao;
my @casa;
my @linha;
my @parte;
my @cookie;
$i = &mod_agrupar('00',&ler_config('1','./auto_arquivos/config.eafc','mercado'));
if ($i == 1){
@acao=&mercado_cheio($nome);
if ($acao[0]){
@casa=&mercado_cami($nome);
if ($casa[0]){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
			print "$casa[0]--------------------mercado\n";			
$conectar = &cliente_pagina($origem,'80',@linha);
	if (!$conectar){
	die "nao foi possivel conectar\n";
	}#fim se conectar
	@casa = &extrair_nome('<td\sclass="mer">Mercadores\s(\d+\\\/\d+)<\\\/td>');
	if ($casa[0]){
		if ($casa[0] =~ /^(\d+)\\\/\d+/i){
		$casa[0] = $1;
			print "$casa[0]--------------------mercadores\n";			
			if ($casa[0]>1){
			@casa = &extrair_nome('<a href="([^<>]+)">Propostas existentes<\\\/a>');
			@casa = &string_expressao(@casa);
			@casa = &codigo_html(@casa);
				$i=0;
				do{
			if ($casa[0]){
#				print $nome.' - '.$casa[0]."------------mercado\n";
				&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome.' - '.$casa[0]."-------------mercado\n");
				@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
				@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
				$conectar = &cliente_pagina($origem,'80',@linha);
				if (!$conectar){
				die "nao foi possivel conectar\n";
				}#fim se conectar
					@parte = &extrair_tag('<table','<\\\/table>','<table','<\/table>');
					@linha = &quebrar_mercado($parte[0]);
					@linha = &quebrar_banco(@linha);
					&gravar_status('./auto_col_arquivos/u_mercado.csv',@linha);
				@casa = &mercado_lista($acao[0],$acao[1]);
				if ($casa[0]){
					@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
					@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
					$conectar = &cliente_pagina($origem,'80',@linha);
					if (!$conectar){
					die "nao foi possivel conectar\n";
					}#fim se conectar
					$i=-3;
				}else{
				@casa = &extrair_nome('<a href="([^<>]+)">&raquo;<\\\/a>');
				@casa = &string_expressao(@casa);
				@casa = &codigo_html(@casa);
				}#se casa
			}else{
print $nome." - nao achou lista de comercio------------\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome." - nao achou lista de comercio------------\n\n");
			}#se casa
				$i++;
				} while (($i>=0) && ($i<=8));	
			}#fim se <
}else{
print $nome." - nao possui mercadores suficientes------------\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome." - nao possui mercadores suficientes------------\n\n");
		}#fim se mercadores suficientes
	}#fim se
}else{
print $nome." - nao existe mercado------------\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome." - nao existe mercado------------\n\n");
}#se existe mercado
}#se mercado cheio
}#se config
}

sub ponto_ato {
my $origem = shift;
my $c_cookie = shift;
my $c_escudo_x = shift;
my $c_escudo_y = shift;
my $nome = shift;
my $conectar;
my $linha_ok;
my @casa;
my @form;
my @tot_tropas;
my @linha;
my @acao;
my @tags;
my @cookie;
@linha = &ler_config('1','./auto_arquivos/config.eafc','ponto');
if ($linha[0] >= 1){
@casa=&ponto_cami($nome);
if ($casa[0]){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
				print "$casa[0]--------------------ponto\n";			
$conectar = &cliente_pagina($origem,'80',@linha);
	if (!$conectar){
	die "nao foi possivel conectar\n";
	}#fim se conectar
	@casa = &ler_config('1','./auto_arquivos/config.eafc','nome_inimigo');
	@casa = &expressao_string(@casa);
if ($casa[0]){	
	$casa[0] = '('.$casa[0].')';
	@casa = &extrair_nome($casa[0]);
}else{
print "sem inimigo--------------\n";
}
if ($casa[0]){	
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome.' - '.$casa[0]."-------------inimigo\n");
print $nome.' - '.$casa[0]."--------------------inimigo\n";			
}
	@form = &extrair_nome('<a href="([^<>]+)">Enviar\sTropas<\\\/a>');
	@form = &string_expressao(@form);
	@form = &codigo_html(@form);
	@casa = &extrair_nome('<a href="([^<>]+)">Libertar<\\\/a>');
	@casa = &string_expressao(@casa);
	@casa = &codigo_html(@casa);
@linha = &ler_config('1','./auto_arquivos/config.eafc','ponto');
			if (($casa[0]) && ($linha[0] >= 2)){
				print $nome.' - '.$casa[0]."------------ponto\n";
				&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome.' - '.$casa[0]."-------------ponto\n");
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
				@linha = &mod_solicitar($origem,$casa[0],$cookie[0],'');
				$conectar = &cliente_pagina($origem,'80',@linha);
				if (!$conectar){
				die "nao foi possivel conectar\n";
				}#fim se conectar
			}#se casa
##############################################################################
	@casa = &ler_config('2','./auto_col_arquivos/col_caminhos.eafc',$c_escudo_x,$c_escudo_y);
@tot_tropas=&ponto_soldados($nome);
#print "----------$casa[0]\n";
#print "----------$casa[1]\n";
#print "----------$form[0]\n";
#print "----------$tot_tropas[0]\n";
if (($casa[0] ne 'nada') && ($casa[1] ne 'nada') && ($form[0]) && ($tot_tropas[0])){
if (($tot_tropas[0] >= 30) && ($tot_tropas[0] <= 1000)){
#	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@form = &sugar_form($origem,$form[0],$c_cookie,'','./auto_col_arquivos/col_caminhos.eafc');
if ($form[0]){
	@acao = &garimpar_tag('1','1','form','action',$form[0]);
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
	@tags = &garimpar_tag('0','2','input','name','value',$form[0]);
	@tot_tropas = &extrair_nome('<a[^<>]+document\\\.snd\\\.t2\\\.value=(\d+);[^<>]+>',$form[0]);
if (($tot_tropas[0]) && ($acao[0])){
if ($tot_tropas[0] =~ /(\d+)/i){
$tot_tropas[0] = $1;
if (($tot_tropas[0] >= 30) && ($tot_tropas[0] <= 1000)){
$linha_ok = &criar_linha_ok_tropas1($tot_tropas[0],$casa[0],$casa[1],@tags);
#	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@form = &sugar_form($origem,$acao[0],$c_cookie,$linha_ok,'./auto_col_arquivos/col_caminhos.eafc');
if ($form[0]){
	@acao = &garimpar_tag('1','1','form','action',$form[0]);
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
	@tags = &garimpar_tag('0','2','input','name','value',$form[0]);
$linha_ok = &criar_linha_ok_tropas2(@tags);
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$acao[0],$cookie[0],$linha_ok);
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
print $nome." - soldados enviados------------$tot_tropas[0]\n";
	&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome.': ('.$casa[0].','.$casa[1].")-------------$tot_tropas[0] soldados enviados\n");
}else{
print $nome." - nao possui form------------\n";
}#se form
	}else{
print $nome." - nao possui soldados para o enviar------------\n";
	}#se >= 30
}#fim se digito
}#se caminho
}else{
print $nome." - nao possui form------------\n";
}#se form
}#se >= 30
}#se nome_quartel
##############################################################################
}else{
print $nome." - nao existe ponto------------\n";
&gravar_log('./auto_col_arquivos/aaa_log.eafc',$nome." - nao existe ponto------------\n\n");
}#se existe ponto
}#se config
}

sub quartel_ato {
my $origem = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $fixo = shift;
my $ancoras = shift || '';
my $linha;
my $conectar;
my @acao;
my @tags;
my @form;
my @casa;
my @u_cookie;
my @cookie;
my @nome;
my @pagina = &ler_config('5','./auto_col_arquivos/endereco.eafc','pagina0','pagina1','pagina2','pagina3','pagina4');
if ($ancoras){
$pagina[1] = $pagina[1].'?'.$ancoras;
$pagina[2] = $pagina[2].'?'.$ancoras;
$pagina[3] = $pagina[3].'?'.$ancoras;
$pagina[4] = $pagina[4].'?'.$ancoras;
}#se ancoras
&sugar_nome('','./auto_col_arquivos/col_caminhos.eafc',$c_nome,$c_cookie,'',$origem,$pagina[1],$pagina[2],$pagina[3],$pagina[4]);
@nome = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome);
if ($nome[0] ne 'nada'){
@form=&quartel_cami($nome[0]);
if ($form[0]){
#	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@form = &sugar_form($origem,$form[0],$c_cookie,'','./auto_col_arquivos/col_caminhos.eafc');
if ($form[0]){
	@acao = &garimpar_tag('1','1','form','action',$form[0]);
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
	@tags = &garimpar_tag('0','2','input','name','value',$form[0]);
	@casa = &extrair_nome('<td.class="max"><a[^<>]+>([^<>]+)<\\\/a><\\\/td>',$form[0]);
##casa[0] = falange
##casa[1] = espadachim
if (($casa[1]) && ($acao[0])){
	@casa = &expressao_string(@casa);
if ($casa[1] =~ /(\d+)/i){
$casa[1] = $1;
if ($casa[1]>0){
print $nome[0]." - producao quartel------------$casa[1]\n";
if (($fixo > 0) && ($fixo <= $casa[1])){
$linha = &criar_linha_ok($fixo,@tags);
}else{
$linha = &criar_linha_ok($casa[1],@tags);
}
if ($fixo <= $casa[1]){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@casa = &mod_solicitar($origem,$acao[0],$cookie[0],$linha);
$conectar = &cliente_pagina($origem,'80',@casa);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
}else{
print $nome[0]." - numero do soldados menor que fixo------------\n";
}
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	}else{
print $nome[0]." - nao possui materiais para o quartel------------\n";
	}#se >0
}#fim se digito
}#se caminho
}else{
print $nome[0]." - nao possui form------------\n";
}#se form
}else{
print $nome[0]." - nao possui quartel ou menor que padrao------------\n";
}#se quartel
}else{
print "nome igual a nada------------\n";
}#se nome
}

sub fabrica_ato {
my $origem = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $ancoras = shift || '';
my $linha;
my $conectar;
my @acao;
my @tags;
my @form;
my @casa;
my @u_cookie;
my @cookie;
my @nome;
my @pagina = &ler_config('5','./auto_col_arquivos/endereco.eafc','pagina0','pagina1','pagina2','pagina3','pagina4');
if ($ancoras){
$pagina[1] = $pagina[1].'?'.$ancoras;
$pagina[2] = $pagina[2].'?'.$ancoras;
$pagina[3] = $pagina[3].'?'.$ancoras;
$pagina[4] = $pagina[4].'?'.$ancoras;
}
&sugar_nome('','./auto_col_arquivos/col_caminhos.eafc',$c_nome,$c_cookie,'',$origem,$pagina[1],$pagina[2],$pagina[3],$pagina[4]);
@nome = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_nome);
@form=&fabrica_cami($nome[0]);
if ($form[0]){
#	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@form = &sugar_form($origem,$form[0],$c_cookie,'','./auto_col_arquivos/col_caminhos.eafc');
@acao = ();
	@casa = &extrair_nome('Voc.{1,2} tem atualmente <b>(\d+)<\\\/b> armadilhas');
push(@acao,'total;'.$casa[0]."\n");
	@casa = &extrair_nome('<b>(\d+)<\\\/b> delas est.{1,2}o ocupadas');
push(@acao,'ocupadas;'.$casa[0]);
	&gravar_status('./auto_col_arquivos/arma_'.$nome[0].'.csv',@acao);
if ($form[0]){
	@acao = &garimpar_tag('1','1','form','action',$form[0]);
	@acao = &string_expressao(@acao);
	@acao = &codigo_html(@acao);
	@tags = &garimpar_tag('0','2','input','name','value',$form[0]);
	@casa = &extrair_nome('<td.class="max"><a[^<>]+>([^<>]+)<\\\/a><\\\/td>',$form[0]);
if (($casa[0]) && ($acao[0])){
	@casa = &expressao_string(@casa);
if ($casa[0] =~ /(\d+)/i){
$casa[0] = $1;
if ($casa[0]>0){
print $nome[0]." - producao fabrica------------$casa[0]\n";
$linha = &criar_linha_ok($casa[0],@tags);
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@casa = &mod_solicitar($origem,$acao[0],$cookie[0],$linha);
$conectar = &cliente_pagina($origem,'80',@casa);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie,$u_cookie[0]);
	}#fim se
	}else{
print $nome[0]." - nao possui materiais para a fabrica------------\n";
	}#se >0
}#fim se digito
}#se caminho
}else{
print $nome[0]." - nao possui form------------\n";
}#se form
}else{
print $nome[0]." - nao possui fabrica------------\n";
}#se quartel
}

sub ne_form {
my $antigo = shift;
my $novo = shift;
	$antigo =~ s/value="[^"]+"//ig;
	$novo =~ s/value="[^"]+"//ig;
	if ($antigo eq $novo){
	return 0;
	}else{
	return $novo;	
	}#fim se
}

sub sugar_form {
my $origem = shift;
my $caminho = shift;
my $c_cookie = shift;
my $linha_form = shift;
my $arquivo = shift;
my $conectar;
my @u_cookie;
my @linha;
my @cookie;
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$caminho,$cookie[0],$linha_form);
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	}#fim se
	@linha = &extrair_tag('<form','<\\\/form>','<form','<\/form>');
return @linha;
}

sub sugar_cookie {
my $arquivo = shift;
my $c_cookie = shift;
my $origem = shift;
my $caminho = shift;
my $linha = shift;
my $conectar;
my @parte;
my @linha;
my @u_cookie;
	if ($linha ne 'nada'){
	@linha = &mod_solicitar($origem,$caminho,'',$linha);
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	return $u_cookie[0];
	}#fim se
	}else{
	return 'sem linha';	
	}
}

sub sugar_nome {
my $banco = shift;
my $arquivo = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $recurso = shift;
my $origem = shift;
my $pagina1 = shift;
my $pagina2 = shift;
my $pagina3 = shift;
my $pagina4 = shift;
my $local;
my $conectar;
my @u_cookie;
my @nome;
my @parte;
my @linha;
my @cookie;
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$pagina2,$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	}#fim se
@nome = ();
@nome = &extrair_nome('<div[^<>]+class="village2">[^<>]*<h1>([^<>]+)<\\\/h1>');
if ($nome[0]){
if ($origem eq 's5.travian.com.br'){
$local = 's5';
}elsif ($origem eq 's3.travian.com.br'){
$local = 's3';
}elsif ($origem eq 's4.travian.com.br'){
$local = 's4';
}else{
$local = 'ss';
}
@linha = &extrair_nome('\?(newdid=\d+)');
@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/anco_'.$local.$nome[0].'.csv',@linha);
#######################
	&gravar_config('1',$arquivo,$c_nome,$local.$nome[0]);
}else{
	@nome = &extrair_nome('<a href="([^<>]+)">Continua[^<]+<\\\/a>');
if ($nome[0]){
	@nome = &string_expressao(@nome);
	@nome = &codigo_html(@nome);
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
				@linha = &mod_solicitar($origem,$nome[0],$cookie[0],'');
				$conectar = &cliente_pagina($origem,'80',@linha);
				if (!$conectar){
				die "nao foi possivel conectar\n";
				}#fim se conectar
print "continua encontrado\n";
}#se nome
	&gravar_config('1',$arquivo,$c_nome,'nada');
print "nome nao encontrado\n";
}
}

sub sugar_dados {
my $banco = shift;
my $arquivo = shift;
my $c_nome = shift;
my $c_cookie = shift;
my $recurso = shift;
my $origem = shift;
my $pagina1 = shift;
my $pagina2 = shift;
my $pagina3 = shift;
my $pagina4 = shift;
my $local;
my $conectar;
my $comparar;
my @u_cookie;
my @nome;
my @parte;
my @linha;
my @cookie;
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$pagina2,$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	}#fim se
@nome = ();
@nome = &extrair_nome('<div[^<>]+class="village2">[^<>]*<h1>([^<>]+)<\\\/h1>');
if ($nome[0]){
if ($origem eq 's5.travian.com.br'){
$local = 's5';
}elsif ($origem eq 's3.travian.com.br'){
$local = 's3';
}elsif ($origem eq 's4.travian.com.br'){
$local = 's4';
}else{
$local = 'ss';
}
#@linha = &extrair_nome('\?(newdid=\d+)');
#@linha = &quebrar_banco(@linha);
#	&gravar_status('./auto_col_arquivos/anco_'.$local.$nome[0].'.csv',@linha);
#######################
	&gravar_config('1',$arquivo,$c_nome,$local.$nome[0]);
	@linha = &garimpar_tag('1','2','area','title','href');
@linha = &preparar_cid($banco,$recurso,@linha);
@linha = &string_expressao(@linha);
@linha = &codigo_html(@linha);
@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/cid_'.$local.$nome[0].'.csv',@linha);
$comparar = './auto_col_arquivos/copia_cid_'.$local.$nome[0].'.csv';
if ( -e $comparar){
$comparar = &comparar_copia('./auto_col_arquivos/cid_'.$local.$nome[0].'.csv','./auto_col_arquivos/copia_cid_'.$local.$nome[0].'.csv');
}#fim se arquivo
&gravar_copia('./auto_col_arquivos/cid_'.$local.$nome[0].'.csv','./auto_col_arquivos/copia_cid_'.$local.$nome[0].'.csv');
# xxxxxxxxxxxxxxxxxx
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$pagina1,$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	}#fim se
@linha = ();
	push(@linha,&extrair_nome('<td.id="l4"[^<>]+>([^<>]+)<\\\/td>'));
	push(@linha,&extrair_nome('<td.id="l3"[^<>]+>([^<>]+)<\\\/td>'));
	push(@linha,&extrair_nome('<td.id="l2"[^<>]+>([^<>]+)<\\\/td>'));
	push(@linha,&extrair_nome('<td.id="l1"[^<>]+>([^<>]+)<\\\/td>'));
@linha = &preparar_mat(@linha);
@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/mat_'.$local.$nome[0].'.csv',@linha);
	@linha = &garimpar_tag('1','2','area','title','href');
@linha = &preparar_cam($banco,@linha);
@linha = &string_expressao(@linha);
@linha = &codigo_html(@linha);
@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/cam_'.$local.$nome[0].'.csv',@linha);
$comparar = './auto_col_arquivos/copia_cam_'.$local.$nome[0].'.csv';
if ( -e $comparar){
$comparar = &comparar_copia('./auto_col_arquivos/cam_'.$local.$nome[0].'.csv','./auto_col_arquivos/copia_cam_'.$local.$nome[0].'.csv');
}#se existe arquivo
&gravar_copia('./auto_col_arquivos/cam_'.$local.$nome[0].'.csv','./auto_col_arquivos/copia_cam_'.$local.$nome[0].'.csv');
# xxxxxxxxxxxxxxxxxx
	@parte = &extrair_tag('<table','<\\\/table>','<table','<\/table>');
	@linha = &quebrar_tabela($parte[0]);
	@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/ata_'.$local.$nome[0].'.csv',@linha);
	@linha = &quebrar_tabela($parte[1]);
	@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/pro_'.$local.$nome[0].'.csv',@linha);
	&ver_producao('./auto_col_arquivos/pro_'.$local.$nome[0].'.csv','./auto_col_arquivos/mat_'.$local.$nome[0].'.csv');
	@linha = &quebrar_tabela($parte[2]);
	@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/tro_'.$local.$nome[0].'.csv',@linha);
if ($parte[3]){
	@linha = &quebrar_tabela($parte[3]);
	@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/cons_'.$local.$nome[0].'.csv',@linha);
}#fim se
# xxxxxxxxxxxxxxxxxx
$pagina1 = &mod_agrupar('00',&ler_config('1','./auto_arquivos/config.eafc','q_dados'));
if ($pagina1 >= 1){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$pagina3,$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	}#fim se
	@parte = &extrair_tag('<table','<\\\/table>','<table','<\/table>');
	@linha = &quebrar_tabela($parte[0]);
	@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/cor_'.$local.$nome[0].'.csv',@linha);
}#fim se q_dados
# xxxxxxxxxxxxxxxxxx
if ($pagina1 >= 2){
	@cookie = &ler_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_cookie);
	@linha = &mod_solicitar($origem,$pagina4,$cookie[0],'');
$conectar = &cliente_pagina($origem,'80',@linha);
if (!$conectar){
die "nao foi possivel conectar\n";
}#fim se conectar
#########################################
	@u_cookie = &ler_status('./auto_arquivos/ultima.eafc');
	if (($u_cookie[0] ne '1') && ($c_cookie)){
	&gravar_config('1',$arquivo,$c_cookie,$u_cookie[0]);
	}#fim se
	@parte = &extrair_tag('<table','<\\\/table>','<table','<\/table>');
	@linha = &quebrar_tabela($parte[0]);
	@linha = &quebrar_banco(@linha);
	&gravar_status('./auto_col_arquivos/rel_'.$local.$nome[0].'.csv',@linha);
}#fim se q_dados
}else{
	&gravar_config('1',$arquivo,$c_nome,'nada');
print "nome nao encontrado\n";
}
}

sub preparar_mat {
my @linha = @_;
my $total = @linha;
my $i;
for ($i=0; $i<$total; $i++) {
if ($linha[$i] =~ /^(\d+)\\\/(\d+)/i){
$linha[$i] = $1.';'.$2;
}#fim if
}#fim for
return @linha;
}

sub preparar_cam {
my $banco = shift;
my @linha = @_;
my @mapa;
my $total;
my $nome;
my $nivel;
my $tempo;
my ($arma,$barr,$barr2,$cele,$comi,$comi2,$comi3,$esco,$ferr,$ferr2,$hero,$made,$made2,$merc,$prin,$resi,$quar,$acad,$cava,$defe,$pris,$pali,$pedr,$pala,$pont,$ofic) = &ler_config('26',$banco,'arma','barr','barr2','cele','comi','comi2','comi3','esco','ferr','ferr2','hero','made','made2','merc','prin','resi','quar','acad','cava','defe','pris','pali','pedr','pala','pont','ofic');
my $i;
my $b=0;
my @titulo;
my @caminho;
@titulo = &sub_array('2','1',@linha);
@caminho = &sub_array('2','2',@linha);
$total = @titulo;
for ($i=0; $i<$total; $i++) {
if ($titulo[$i] =~ /^(Bosque)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$made){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$made.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Campo de Cereal)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$comi){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$comi.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Mina de ferro)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$ferr){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$ferr.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Po.{1,2}o de barro)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$barr){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$barr.';'.$nome.';'.$nivel;
$b++;
}#fim elsif
}#fim for
return @mapa;
}

sub preparar_cid {
my $banco = shift;
my $recurso = shift;
my @linha = @_;
my $total = @linha;
my $nome;
my $nivel;
my $tempo;
my ($arma,$barr,$barr2,$cele,$comi,$comi2,$comi3,$esco,$ferr,$ferr2,$hero,$made,$made2,$merc,$prin,$resi,$quar,$acad,$cava,$defe,$pris,$pali,$pedr,$pala,$pont,$ofic) = &ler_config('26',$banco,'arma','barr','barr2','cele','comi','comi2','comi3','esco','ferr','ferr2','hero','made','made2','merc','prin','resi','quar','acad','cava','defe','pris','pali','pedr','pala','pont','ofic');
if ($recurso){
$arma = $recurso;
$cele = $recurso;
}
my $i;
my $b=0;
my @mapa;
my @titulo;
my @caminho;
@titulo = &sub_array('2','1',@linha);
@caminho = &sub_array('2','2',@linha);
$total = @titulo;
for ($i=0; $i<$total; $i++) {
if ($titulo[$i] =~ /^(Edif.{1,2}cio Principal)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$prin){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$prin.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Celeiro)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$cele){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$cele.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Armaz.{1,2}m)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$arma){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$arma.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Mercado)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$merc){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$merc.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Mans.{1,2}o do her.{1,2}i)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$hero){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$hero.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Esconderijo)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$esco){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$esco.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Resid.{1,2}ncia)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$resi){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$resi.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Quartel)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$quar){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$quar.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Academia)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$acad){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$acad.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Cavalaria)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$cava){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$cava.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Ferreiro)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$defe){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$defe.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(F.{1,2}brica de Armadilhas)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$pris){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$pris.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Pali.{1,2}ada)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$pali){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$pali.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Pedreiro)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$pedr){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$pedr.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Pal.{1,2}cio)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$pala){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$pala.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Serraria)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$made2){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$made2.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Alvenaria)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$barr2){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$barr2.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Fundi.{2,4}o)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$ferr2){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$ferr2.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Moinho)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$comi2){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$comi2.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Padaria)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$comi3){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$comi3.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(Ponto de Reuni.{2,4}o Militar)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$pont){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$pont.';'.$nome.';'.$nivel;
$b++;
}elsif ($titulo[$i] =~ /^(oficina)[^\d]+(\d+)$/i){
$nome = $1;
$nivel = $2;
if ($nivel<$ofic){
@linha = &preco($nome,$nivel);
}else{
@linha = (200000,200000,200000,200000);
}
$tempo = 10;
$mapa[$b] = $linha[0].';'.$linha[1].';'.$linha[2].';'.$linha[3].';'.$tempo.';'.$caminho[$i].';'.$ofic.';'.$nome.';'.$nivel;
$b++;
}#fim elsif
}#fim for
return @mapa;
}

sub preco {
my $nome = shift;
my $nivel = shift;
my $arquivo;
my @mapa;
if ($nome =~ /^Bosque$/i){
$arquivo = './banco_arquivos/made.csv';
}elsif ($nome =~ /^Campo de Cereal$/i){
$arquivo = './banco_arquivos/comi.csv';
}elsif ($nome =~ /^Mina de ferro$/i){
$arquivo = './banco_arquivos/ferr.csv';
}elsif ($nome =~ /^Po.{1,2}o de barro$/i){
$arquivo = './banco_arquivos/barr.csv';
}elsif ($nome =~ /^Edif.{1,2}cio Principal$/i){
$arquivo = './banco_arquivos/prin.csv';
}elsif ($nome =~ /^Celeiro$/i){
$arquivo = './banco_arquivos/cele.csv';
}elsif ($nome =~ /^Armaz.{1,2}m$/i){
$arquivo = './banco_arquivos/arma.csv';
}elsif ($nome =~ /^Mercado$/i){
$arquivo = './banco_arquivos/merc.csv';
}elsif ($nome =~ /^Mans.{1,2}o do her.{1,2}i$/i){
$arquivo = './banco_arquivos/hero.csv';
}elsif ($nome =~ /^Esconderijo$/i){
$arquivo = './banco_arquivos/esco.csv';
}elsif ($nome =~ /^Resid.{1,2}ncia$/i){
$arquivo = './banco_arquivos/resi.csv';
}elsif ($nome =~ /^Quartel$/i){
$arquivo = './banco_arquivos/quar.csv';
}elsif ($nome =~ /^Academia$/i){
$arquivo = './banco_arquivos/acad.csv';
}elsif ($nome =~ /^Cavalaria$/i){
$arquivo = './banco_arquivos/cava.csv';
}elsif ($nome =~ /^Ferreiro$/i){
$arquivo = './banco_arquivos/defe.csv';
}elsif ($nome =~ /^F.{1,2}brica de Armadilhas$/i){
$arquivo = './banco_arquivos/pris.csv';
}elsif ($nome =~ /^Pali.{1,2}ada$/i){
$arquivo = './banco_arquivos/pali.csv';
}elsif ($nome =~ /^Pedreiro$/i){
$arquivo = './banco_arquivos/pedr.csv';
}elsif ($nome =~ /^Pal.{1,2}cio$/i){
$arquivo = './banco_arquivos/pala.csv';
}elsif ($nome =~ /^Serraria$/i){
$arquivo = './banco_arquivos/made2.csv';
}elsif ($nome =~ /^Alvenaria$/i){
$arquivo = './banco_arquivos/barr2.csv';
}elsif ($nome =~ /^Fundi.{2,4}o$/i){
$arquivo = './banco_arquivos/ferr2.csv';
}elsif ($nome =~ /^Moinho$/i){
$arquivo = './banco_arquivos/comi2.csv';
}elsif ($nome =~ /^Padaria$/i){
$arquivo = './banco_arquivos/comi3.csv';
}elsif ($nome =~ /^Ponto de Reuni.{2,4}o Militar$/i){
$arquivo = './banco_arquivos/pont.csv';
}elsif ($nome =~ /^oficina$/i){
$arquivo = './banco_arquivos/ofic.csv';
}#fim se
@mapa = &ler_status($arquivo);
chomp(@mapa);
@mapa = split(/;/, $mapa[$nivel]);
return @mapa;
}

sub trans_tempo {
my @tempos = @_;
$tempos[0] = $tempos[0]*3600;
$tempos[1] = $tempos[1]*60;
@tempos = $tempos[0]+$tempos[1]+$tempos[2];
return $tempos[0];
}

sub quebrar_mercado {
my $cor1;
my $cor2;
my $parte=0;
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
			$pagina =~ s/<img[^<>]+madeira[^<>]+>/madeira;/ig;
			$pagina =~ s/<img[^<>]+barro[^<>]+>/barro;/ig;
			$pagina =~ s/<img[^<>]+ferro[^<>]+>/ferro;/ig;
			$pagina =~ s/<img[^<>]+cereal[^<>]+>/cereal;/ig;
			if ($pagina =~ /<a href="([^"]+)">Aceitar proposta<\\\/a>/ig){
			$parte++;
			}
			$pagina =~ s/<a href="([^"]+)">Aceitar proposta<\\\/a>/$1/ig;
			$pagina =~ s/[^<>]+insuficientes/nada/ig;
			$pagina =~ s/<\\\/td><td>/;/ig;
			$pagina =~ s/<[^<>]+>//ig;
			$pagina =~ s/^;//ig;
			$pagina =~ s/;$//ig;
			if ($parte == 1){
			push(@mapa,$pagina);
			$parte=0;
			}#fim se
			}#fim se cor
		}#fim se form
	}else{
	$pagina = 'nada';
	}#fim else
} while ($pagina ne 'nada');
return @mapa;
}

1;

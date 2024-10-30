## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;

sub abrir_html {
my $tempo = &log_tempo();
my $titulo = shift || 'EAFC';
my $mensagem = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt-br">
<head><title>';
if (defined($titulo)){
$mensagem = $mensagem.$titulo;
}#fim se
$mensagem = $mensagem.'</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="./css_arquivos/web.css" type="text/css" />
<link href="./imagem_arquivos/webico.ico" rel="shortcut icon" type="image/x-icon" />
<script src="./css_arquivos/web.js" type="text/javascript"></script>';
my	@acao = &ler_status('./auto_arquivos/col.eafc');
if ($acao[0]){
$mensagem = $mensagem.&recarga_js();
print 'atualizando - '.$tempo."\n";
}#fim se
$mensagem = $mensagem.'</head><body id="pag_web" name="pag_web" onload="iniciar()">';
return $mensagem;
}

sub abrir_saida {
my $titulo = shift || 'EAFC';
my $mensagem = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt-br">
<head><title>';
if (defined($titulo)){
$mensagem = $mensagem.$titulo;
}#fim se
$mensagem = $mensagem.'</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />';
$mensagem = $mensagem.&css_html();
$mensagem = $mensagem.'</head><body id="pag_web" name="pag_web">';
return $mensagem;
}

sub abrir_processo {
my $davez = shift;
my $titulo = shift || 'EAFC';
my $mensagem = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt-br">
<head><title>';
if (defined($titulo)){
$mensagem = $mensagem.$titulo;
}#fim se
$mensagem = $mensagem.'</title>
<link href="./imagem_arquivos/webico.ico" rel="shortcut icon" type="image/x-icon" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />';
$mensagem = $mensagem.&css_html();
$mensagem = $mensagem.&recarga_processo($davez);
$mensagem = $mensagem.'</head><body id="pag_web" name="pag_web">';
return $mensagem;
}

sub fechar_html {
my $mensagem = '</body></html>';
return $mensagem;
}

sub abrir_form {
my $metodo = shift || '';
my $mensagem = '<form action="'.$metodo.'" method="POST">';
return $mensagem;
}

sub abrir_div {
my $classe = shift || '';
my $mensagem = '<div id="'.$classe.'" name="'.$classe.'">';
return $mensagem;
}

sub abrir_div_g {
my $classe = shift || '';
my $mensagem = '<div class="'.$classe.'">';
return $mensagem;
}

sub fechar_form {
my $classe = shift || '';
my $mensagem = '<div class="formula9"><input class="formula9" type="submit" value="executar"></div></form><!-- '.$classe.' -->';
return $mensagem;
}

sub fechar_div {
my $classe = shift || '';
my $mensagem = '</div><!-- '.$classe.' -->';
return $mensagem;
}

sub dividir_br {
my $mensagem = "<br />\n";
return $mensagem;
}

sub dividir_hr {
my $classe = shift || 'linha';
my $mensagem = '<hr class="'.$classe.'" />';
return $mensagem;
}

sub imagem_html {
my $caminho = shift || '';
my $rotulo = shift || '';
my $classe = shift || '';
my $mensagem = '<div id="'.$classe.'" name="'.$classe.'"><img src="./imagem_arquivos/'.$caminho.'" alt="'.$rotulo.'" /></div><!-- '.$classe.' -->';
return $mensagem;
}

sub imagem_g {
my $caminho = shift || '';
my $rotulo = shift || '';
my $classe = shift || '';
my $mensagem = '<div class="'.$classe.'"><img src="./imagem_arquivos/'.$caminho.'" alt="'.$rotulo.'" /></div><!-- '.$classe.' -->';
return $mensagem;
}

sub anc_html {
my $caminho = shift || '';
my $rotulo = shift || '';
my $classe = shift || '';
my $mensagem = '<div id="'.$classe.'" name="'.$classe.'"><a href="'.$caminho.'">'.$rotulo.'</a></div><!-- '.$classe.' -->';
return $mensagem;
}

sub anc_g {
my $caminho = shift || '';
my $rotulo = shift || '';
my $classe = shift || '';
my $mensagem = '<div class="'.$classe.'"><a href="'.$caminho.'">'.$rotulo.'</a></div><!-- '.$classe.' -->';
return $mensagem;
}

sub anc_menu {
my $classe = shift || '';
my $neutro = shift || 20000;
$neutro = (($neutro-1)*2);
my @grupo = @_;
my $valor = @grupo;
my $mensagem = '<div id="'.$classe.'" name="'.$classe.'"><ul>';
for (my $i=0; $i<$valor; $i++) {
	if ($i == $neutro){
	$mensagem = $mensagem.'<li><div>';
	$i++;
	$mensagem = $mensagem.$grupo[$i].'</div></li>';
	}
	else{
	$mensagem = $mensagem.'<li><a href="'.$grupo[$i].'">';
	$i++;
	$mensagem = $mensagem.$grupo[$i].'</a></li>';
	}
}#fim for
$mensagem = $mensagem.'</ul></div><!-- '.$classe.' -->';
return $mensagem;
}

sub select_menu {
my $classe = shift || '';
my $neutro = shift || 20000;
$neutro = (($neutro-1)*2);
my @grupo = @_;
my $valor = @grupo;
my $mensagem = '<select id="'.$classe.'" name="'.$classe.'">';
for (my $i=0; $i<$valor; $i++) {
	if ($i == $neutro){
	$mensagem = $mensagem.'<option value="'.$grupo[$i].'" selected="selected">';
	$i++;
	$mensagem = $mensagem.$grupo[$i].'</option>';
	}
	else{
	$mensagem = $mensagem.'<option value="'.$grupo[$i].'">';
	$i++;
	$mensagem = $mensagem.$grupo[$i].'</option>';
	}
}#fim for
$mensagem = $mensagem.'</select>';
return $mensagem;
}

sub rotulo_html {
my $texto = shift;
my $classe = shift;
my $mensagem = '<div class="'.$classe.'">'.$texto.'</div>';
return $mensagem;
}

sub array_html {
my $coluna = shift || 1;
my $valor;
my $i;
my $b;
my $cores;
my @dados = @_;
my @titulo;
my $mensagem = '<table class="hash_titu" cellspacing="0">';
for ($i=0; $i<$coluna; $i++){
$titulo[$i] = shift(@dados);
}#fim for
$cores = 'hash_par';
$mensagem = $mensagem.'<tr>';
for ($i=0; $i<$coluna; $i++){
$mensagem = $mensagem.'<td class="hash_titu">'.$titulo[$i].'</td>';
}#fim for
$mensagem = $mensagem.'</tr>';
$valor = @dados;
for ($b=0; $b<$valor; $b++){
$mensagem = $mensagem.'<tr>';
for ($i=0; $i<$coluna; $i++){
$mensagem = $mensagem.'<td class="'.$cores.'">'.$dados[$b].'</td>';
$b++;
}#fim for
$b--;
$mensagem = $mensagem.'</tr>';
if ($cores eq 'hash_par'){
$cores = 'hash_impar';
}else{
$cores = 'hash_par';
}
}#fim for
$mensagem = $mensagem.'<tr>';
for ($i=0; $i<$coluna; $i++){
if ($i == $coluna-1){
$valor=$valor/$coluna;
$mensagem = $mensagem.'<td class="hash_total">total = '.$valor.'</td>';
}else{
$mensagem = $mensagem.'<td class="hash_total"></td>';
}#fim else
}#fim for
$mensagem = $mensagem.'</tr>';
$mensagem = $mensagem.'</table>';
return $mensagem;
}

1;

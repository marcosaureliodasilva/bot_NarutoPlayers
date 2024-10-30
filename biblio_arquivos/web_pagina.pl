## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;

sub buscar_html {
my $coluna = shift;
my $metodo = shift;
my $arquivo = shift;
my @mapa = @_;
my @ativo;
my @antes;
my $i;
for ($i=0; $i<$coluna; $i++){
$ativo[$i] = shift(@mapa);
}#fim for
for ($i=0; $i<$coluna; $i++){
$antes[$i] = &mod_agrupar('00',&ler_config('1',$arquivo,$mapa[$i]));
}#fim for
my $mensagem = '<form action="'.$metodo.'" method="POST">';
for ($i=0; $i<$coluna; $i++){
if ($ativo[$i] == 1){
$mensagem = $mensagem.'<div class="formula3">'.$mapa[$i].':</div>';
$mensagem = $mensagem.'<div class="formula4">';
$mensagem = $mensagem.'<input type="text" id="'.$mapa[$i].'" name="'.$mapa[$i].'" value="'.$antes[$i].'" class="emailc" maxlength="200" size="50" />';
$mensagem = $mensagem.'</div>';
}elsif ($ativo[$i] == 2){
$mensagem = $mensagem.'<input type="hidden" id="'.$mapa[$i].'" name="'.$mapa[$i].'" value="" />';
}else{
$mensagem = $mensagem.'<input type="hidden" id="'.$mapa[$i].'" name="'.$mapa[$i].'" value="'.$antes[$i].'" />';
}
}#fim for
$mensagem = $mensagem.'<div class="formula9"><input class="formula9" type="submit" value="executar"></div></form>';
return $mensagem;
}

sub simples_html {
my $coluna = shift;
my $metodo = shift;
my @mapa = @_;
my @ativo;
my @antes;
my $i;
for ($i=0; $i<$coluna; $i++){
$ativo[$i] = shift(@mapa);
}#fim for
my $mensagem = '<form action="'.$metodo.'" method="POST">';
for ($i=0; $i<$coluna; $i++){
if ($ativo[$i] == 1){
$mensagem = $mensagem.'<div class="formula3">'.$mapa[$i].':</div>';
$mensagem = $mensagem.'<div class="formula4">';
$mensagem = $mensagem.'<input type="text" id="'.$mapa[$i].'" name="'.$mapa[$i].'" value="" class="emailc" maxlength="200" size="50" />';
$mensagem = $mensagem.'</div>';
}else{
$mensagem = $mensagem.'<input type="hidden" id="'.$mapa[$i].'" name="'.$mapa[$i].'" value="" />';
}
}#fim for
$mensagem = $mensagem.'<div class="formula9"><input class="formula9" type="submit" value="executar"></div></form>';
return $mensagem;
}

sub menu_web {
my $neutro = shift || '';
my $mensagem = &abrir_div_g('p_espe1');
$mensagem = $mensagem.&abrir_div_g('p_espe2');
$mensagem = $mensagem.&abrir_div_g('p_espe3');
$mensagem = $mensagem.&anc_menu('menu_web',$neutro,'mod_inicio','inicio','mod_menu','menu','mod_config','config','mod_saida','sair');
$mensagem = $mensagem.&fechar_div('p_espe3');
$mensagem = $mensagem.&fechar_div('p_espe2');
$mensagem = $mensagem.&fechar_div('p_espe1');
return $mensagem;
}

sub imagem_encode {
my $mensagem = &imagem_html('barra01.gif','imagem','imagem');
return $mensagem;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub mod_inicio {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&imagem_encode());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web(1));
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_tes());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&fechar_div('formula1'));
push(@mensagem,&fechar_html());
@mensagem = mod_html_s(@mensagem);
return @mensagem;
}

sub mod_menu {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
my @arquivos;
@arquivos = &ler_status('./externos_arquivos/menu.eafc');
@arquivos = &duplicar_array(@arquivos);
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&imagem_encode());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina menu','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&abrir_form('r_menu'));
push(@mensagem,&select_menu('c_menu',1,@arquivos));
push(@mensagem,&fechar_form('r_menu'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web(2));
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_tes());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&fechar_div('formula1'));
push(@mensagem,&fechar_html());
@mensagem = mod_html_s(@mensagem);
return @mensagem;
}

sub mod_saida {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_saida());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&rotulo_html('adeus EAFC','mostrar6'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&fechar_div('formula1'));
push(@mensagem,&fechar_html());
@mensagem = mod_html_s(@mensagem);
return @mensagem;
}

sub mod_processo {
my $linha_g = shift || '';
my $linha_p = shift || '';
my $davez = shift;
my @mensagem;
push(@mensagem,&abrir_processo($davez));
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&rotulo_html('processando EAFC','mostrar6'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&fechar_div('formula1'));
push(@mensagem,&fechar_html());
@mensagem = mod_html_s(@mensagem);
return @mensagem;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub r_menu {
my $linha_g = shift || '';
my $linha_p = shift || '';
my $conectar;
my @mapa;
my @linha_pg;
my @mensagem;
@linha_pg = &ler_status('./auto_arquivos/metodo.eafc');
if ($linha_pg[0] eq 'post') {
@linha_pg = &dividir_get($linha_p);
}elsif ($linha_pg[0] eq 'get') {
@linha_pg = &dividir_get($linha_g);
}else {
die "erro no get ou post\n";
}
system('cat ./externos_arquivos/'.$linha_pg[1]);
@mensagem = &mod_menu($linha_g,$linha_p);
return @mensagem;
}

sub r_config {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @linha_pg;
my @mensagem;
@linha_pg = &ler_status('./auto_arquivos/metodo.eafc');
if ($linha_pg[0] eq 'post') {
@linha_pg = &dividir_get($linha_p);
}elsif ($linha_pg[0] eq 'get') {
@linha_pg = &dividir_get($linha_g);
}else {
die "erro no get ou post\n";
}
&gravar_config('1','./auto_arquivos/config.eafc',$linha_pg[0],$linha_pg[1]);
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina retornar config','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&array_html('1',$linha_pg[0].' gravado',$linha_pg[1]));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_tes());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&fechar_div('formula1'));
push(@mensagem,&fechar_html());
@mensagem = mod_html_s(@mensagem);
return @mensagem;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub extrair_imagem {
my $indice = shift;
if (extrair_css($indice)){
}elsif (extrair_js($indice)){
}elsif (extrair_ico($indice)){
}elsif (extrair_jpg($indice)){
}elsif (extrair_png($indice)){
}elsif (extrair_gif($indice)){
}else{
$indice = 0;
}
return $indice;
}

1;

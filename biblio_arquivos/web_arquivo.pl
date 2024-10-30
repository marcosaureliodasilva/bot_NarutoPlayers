## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub random_linhas {
my $entrada = shift;
my $saida = shift;
my @linhas = &ler_status($entrada);
my @s_linhas;
my $t_linhas;
my $conta;
my $rad;
my $vi;
my $bi=0;
$t_linhas = @linhas;
$conta = $t_linhas;
while ($conta > 0){
$rad = rand($t_linhas);
if ($linhas[$rad]){
if ($rad >= $t_linhas-1){
print $rad."-----------\n";
$linhas[$rad] = $linhas[$rad]."\n";
}
$s_linhas[$bi] = $linhas[$rad];
$bi++;
$linhas[$rad] = 0;
$conta--;
}#se
}#while
$bi--;
chomp($s_linhas[$bi]);
&gravar_status($saida,@s_linhas);
}

sub sql_string {
my @mensagem = @_;
my $total = @mensagem;
my $i;
for ($i=0; $i<$total; $i++){
#	print "$mensagem[$i]---------------\n";
	$mensagem[$i] =~ s/\'/\\\'/g;
#	print "$mensagem[$i]---------------\n";
}#fim for
return @mensagem;
}

sub codigo_html {
my @mensagem = @_;
my $total = @mensagem;
my $i;
for ($i=0; $i<$total; $i++){
#	print "$mensagem[$i]---------------\n";
	$mensagem[$i] =~ s/&amp;/&/ig;
	$mensagem[$i] =~ s/&#38;/&/ig;
#	print "$mensagem[$i]---------------\n";
}#fim for
return @mensagem;
}

sub expressao_string {
my @mensagem = @_;
my $total = @mensagem;
my $i;
for ($i=0; $i<$total; $i++){
#	print "$mensagem[$i]---------------\n";
	$mensagem[$i] =~ s/\\/\\\\/g;
	$mensagem[$i] =~ s/\//\\\//g;
	$mensagem[$i] =~ s/\^/\\\^/g;
	$mensagem[$i] =~ s/\./\\\./g;
	$mensagem[$i] =~ s/\$/\\\$/g;
	$mensagem[$i] =~ s/\|/\\\|/g;
	$mensagem[$i] =~ s/\*/\\\*/g;
	$mensagem[$i] =~ s/\+/\\\+/g;
	$mensagem[$i] =~ s/\?/\\\?/g;
	$mensagem[$i] =~ s/\(/\\\(/g;
	$mensagem[$i] =~ s/\)/\\\)/g;
	$mensagem[$i] =~ s/\[/\\\[/g;
	$mensagem[$i] =~ s/\]/\\\]/g;
	$mensagem[$i] =~ s/\{/\\\{/g;
	$mensagem[$i] =~ s/\}/\\\}/g;
#	print "$mensagem[$i]---------------\n";
}#fim for
return @mensagem;
}

sub string_expressao {
my @mensagem = @_;
my $total = @mensagem;
my $i;
for ($i=0; $i<$total; $i++){
#	print "$mensagem[$i]---------------\n";
	$mensagem[$i] =~ s/\\\\/\\/g;
	$mensagem[$i] =~ s/\\\//\//g;
	$mensagem[$i] =~ s/\\\^/\^/g;
	$mensagem[$i] =~ s/\\\./\./g;
	$mensagem[$i] =~ s/\\\$/\$/g;
	$mensagem[$i] =~ s/\\\|/\|/g;
	$mensagem[$i] =~ s/\\\*/\*/g;
	$mensagem[$i] =~ s/\\\+/\+/g;
	$mensagem[$i] =~ s/\\\?/\?/g;
	$mensagem[$i] =~ s/\\\(/\(/g;
	$mensagem[$i] =~ s/\\\)/\)/g;
	$mensagem[$i] =~ s/\\\[/\[/g;
	$mensagem[$i] =~ s/\\\]/\]/g;
	$mensagem[$i] =~ s/\\\{/\{/g;
	$mensagem[$i] =~ s/\\\}/\}/g;
#	print "$mensagem[$i]---------------\n";
}#fim for
return @mensagem;
}

sub mod_agrupar {
my $funcao = shift;
my	$fim_linha = substr($funcao,0,1);
my	$expressao = substr($funcao,1,1);
my @mensagem = @_;
my $total = @mensagem;
my $i;
for ($i=0; $i<$total; $i++){
	if ($fim_linha eq '1'){
	$mensagem[$i] =~ s/\r//g;
	}#fim se
	if ($expressao eq '1'){
	$mensagem[$i] =~ s/\n//g;
	}#fim se
}#fim for
	$i = join('',@mensagem);
return $i;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub gravar_log {
my $nome = shift;
my @parte = @_;
my $indice;
open(STATUS,">>".$nome) or die "não foi possivel abrir arquivo $nome\n";
foreach $indice (@parte){
if ($indice){
print STATUS $indice;
}#fim se
}#fim foreach
close(STATUS) or die "não foi possivel fechar arquivo\n";
}

sub gravar_status {
my $nome = shift;
my @parte = @_;
my $indice;
open(STATUS,">".$nome) or die "não foi possivel abrir arquivo $nome\n";
foreach $indice (@parte){
if ($indice){
print STATUS $indice;
}#fim se
}#fim foreach
close(STATUS) or die "não foi possivel fechar arquivo\n";
}

sub gravar_copia {
my $fonte = shift;
my $copia = shift;
my @banco;
@banco = &ler_status($fonte);
$fonte = @banco;
if ($fonte){
&gravar_status($copia,@banco);
}else{
print "arquivo vazio----------\n";
}#fim se
}

sub ler_status {
my $nome = shift;
my @linha;
my $i;
open(STATUS,$nome) or die "não foi possivel abrir arquivo $nome\n";
binmode(STATUS);
@linha = <STATUS>;
close(STATUS) or die "não foi possivel fechar arquivo\n";
$nome = @linha;
for ($i=0; $i<$nome; $i++){
$linha[$i] =~ s/\r//g;
}
return @linha;
}

sub ler_imagem {
my $nome = shift;
my @linha;
my $i;
open(STATUS,$nome) or die "não foi possivel abrir arquivo $nome\n";
binmode(STATUS);
@linha = <STATUS>;
close(STATUS) or die "não foi possivel fechar arquivo\n";
return @linha;
}

sub gravar_config {
my $coluna = shift;
my $nome = shift;
my @linha = @_;
my $i;
my $b;
my @chave;
my @indice;
my $total;
for ($b=0; $b<$coluna; $b++){
$chave[$b] = shift(@linha);
$indice[$b] = shift(@linha);
}#fim for
open(STATUS,$nome) or die "não foi possivel abrir arquivo $nome\n";
binmode(STATUS);
@linha = <STATUS>;
close(STATUS) or die "não foi possivel fechar arquivo\n";
$total = @linha;
for ($i=0; $i<$total; $i++){
$linha[$i] =~ s/\r//g;
}
for ($i=0; $i<$total; $i++){
for ($b=0; $b<$coluna; $b++){
if ($linha[$i] =~ /^$chave[$b]:\s/i){
$linha[$i] = $chave[$b].': '.$indice[$b]."\n";
}#fim se
}#fim for
}#fim for
open(STATUS,">".$nome) or die "não foi possivel abrir arquivo $nome\n";
foreach $i (@linha){
if ($i){
print STATUS $i;
}#fim se
}# fim foreach
close(STATUS) or die "não foi possivel fechar arquivo\n";
}

sub ler_config {
my $coluna = shift;
my $nome = shift;
my @linha = @_;
my $b;
my $i;
my $total;
my @chave;
my @indice;
for ($b=0; $b<$coluna; $b++){
$chave[$b] = shift(@linha);
}#fim for
open(STATUS,$nome) or die "não foi possivel abrir arquivo $nome\n";
binmode(STATUS);
@linha = <STATUS>;
close(STATUS) or die "não foi possivel fechar arquivo\n";
$total = @linha;
for ($i=0; $i<$total; $i++){
$linha[$i] =~ s/\r//g;
}
for ($i=0; $i<$total; $i++){
for ($b=0; $b<$coluna; $b++){
if ($linha[$i] =~ /^$chave[$b]:\s(.*)/i){
$indice[$b] = $1;
}#fim se
}#fim for
}#fim for
return @indice;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub pausar {
my $i;
my $b;
my $total = &mod_agrupar('00',&ler_config('1','./auto_arquivos/config.eafc','pausar'));
for ($i=0; $i<$total; $i++){
$b = $total-$i;
#print "conectando em $b\n";
sleep(1);
}#fim for
}

sub calcular_tempo {
my @tempos = localtime();
$tempos[3] = $tempos[3]*86400;
$tempos[2] = $tempos[2]*3600;
$tempos[1] = $tempos[1]*60;
@tempos = $tempos[3]+$tempos[2]+$tempos[1]+$tempos[0];
return $tempos[0];
}

sub log_tempo {
my @tempos = localtime();
@tempos = $tempos[2].';'.$tempos[1].';'.$tempos[0];
return $tempos[0];
}

sub gravar_tempo {
my $tempo = &calcular_tempo();
&gravar_status('./auto_arquivos/tempo.eafc',$tempo);
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub dist_analitica {
my $x1 = shift;
my $y1 = shift;
my $x2 = shift;
my $y2 = shift;
my $eixox;
my $eixoy;
my $resu;
$eixox = $x2 - $x1;
$eixoy = $y2 - $y1;
$eixox = $eixox**2;
$eixoy = $eixoy**2;
$resu = $eixox + $eixoy;
###$resu = int(sqrt($resu));
$resu = sqrt($resu);
return $resu;
}

sub array_console {
my $coluna = shift || 1;
my $espaco;
my $scompri=0;
my $valor;
my $i;
my $b;
my $e;
my $cores;
my @dados = @_;
my @titulo;
my @compri;
for ($i=0; $i<$coluna; $i++){
$compri[$i] = shift(@dados);
$scompri = $scompri+$compri[$i];
}#fim for
for ($i=0; $i<$coluna; $i++){
$titulo[$i] = shift(@dados);
}#fim for
for ($i=0; $i<$scompri; $i++){
print '-';
}#fim for
print "\n";
for ($i=0; $i<$coluna; $i++){
if ($i<$coluna-1){
$espaco = $compri[$i]-length($titulo[$i]);
print $titulo[$i];
for ($e=0; $e<$espaco; $e++){
print ' ';
}#fim for
}else{
print $titulo[$i]."\n";
}#fim se
}#fim for
for ($i=0; $i<$scompri; $i++){
print '-';
}#fim for
print "\n";
$valor = @dados;
for ($b=0; $b<$valor; $b++){
for ($i=0; $i<$coluna; $i++){
if ($i<$coluna-1){
$espaco = $compri[$i]-length($dados[$b]);
print $dados[$b];
for ($e=0; $e<$espaco; $e++){
print ' ';
}#fim for
}else{
print $dados[$b]."\n";
}#fim se
$b++;
}#fim for
$b--;
}#fim for
for ($i=0; $i<$scompri; $i++){
print '-';
}#fim for
print "\n";
}

sub duplicar_array {
my @dados = @_;
my $total = @dados;
my @saida;
my $vi;
my $mi=0;
for ($vi=0; $vi<$total; $vi++){
$saida[$mi] = $dados[$vi];
$mi++;
$saida[$mi] = $dados[$vi];
$mi++;
}#fim for
return @saida;
}

sub mostrar_array {
my $total = shift;
my @dados = @_;
my @titulo;
my $i;
for ($i=0; $i<$total; $i++){
$titulo[$i] = shift(@dados);
print "$titulo[$i]";
if ($i<($total-1)){
print ' --> ';
}else{
print "\n";
}#fim se
}#fim for
my $valor = @dados;
my $b;
for ($b=0; $b<$valor; $b++){
for ($i=0; $i<$total; $i++){
print "$dados[$b]";
if ($i<($total-1)){
print ' --> ';
}else{
print "\n";
}#fim se
$b++;
}#fim for
$b--;
}#fim for
print "total = $valor\n";
}

1;

## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;
use IO::Socket;
use Encode;
use Compress::Zlib;

sub cliente_pagina {
my $limite = 0;
my $host = shift;
my $port = shift;
my $anali = 1;
if ($port < 0){
$port = $port*-1;
$anali = 0;
}
my @mensagem = @_;
my @parte;
my @location;
my $u_cookie;
my $i;
my $cliente = &abrir_cliente($host,$port);
my $linha;
my $pagina;
		&gravar_status('./auto_arquivos/ultima.eafc','1');
		&gravar_status('./auto_arquivos/ultima2.eafc','1');
		&gravar_status('./auto_arquivos/ultima3.eafc','1');
		&gravar_status('./auto_arquivos/ultima4.eafc','1');
		&gravar_status('./auto_arquivos/ultima5.eafc','1');
		&gravar_status('./auto_arquivos/location.eafc','1');
if ($cliente){
binmode($cliente);
foreach $pagina (@mensagem) {
print $cliente $pagina;
}#fim foreach
@mensagem = ();
$linha = <$cliente>;
while (($linha =~ /\w+/i) && (&mod_agrupar('00',&ler_status('./auto_arquivos/respo.eafc')))){
if ($linha =~ /^Location:/i){
@location = &expressao_string($linha);
$linha = $location[0];
##die "nova linha-->$linha\n";
}
	 	if ($linha =~ /^http\/\d\.\d\s(\d\d\d)\s/i){
		&gravar_status('./auto_arquivos/respo.eafc',$1);
		print "$linha\n";
		}elsif ($linha =~ /^Transfer-Encoding:\s(\w+)/){
		&gravar_status('./auto_arquivos/transfer.eafc',$1);
		print "$linha\n";
		}elsif ($linha =~ /^Location:\s(.+)$/i){
		@location = $1;
		@location = &string_expressao(@location);
		&gravar_status('./auto_arquivos/location.eafc',$location[0]);
		print "$linha\n";
		}elsif ($linha =~ /^Set-Cookie:\s([^;]+);.+$/i){
		$u_cookie = $1;
	if (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima2.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima2.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima3.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima3.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima4.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima4.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima5.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima5.eafc',$u_cookie);
	}else{
	die "mais de 5 cookies\n";
	}#fim se
		print "$linha\n";
		}elsif ($linha =~ /^Set-Cookie:\s([^;]+)$/i){
		$u_cookie = $1;
		chomp($u_cookie);
	if (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima2.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima2.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima3.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima3.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima4.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima4.eafc',$u_cookie);
	}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/ultima5.eafc')) eq '1'){
	&gravar_status('./auto_arquivos/ultima5.eafc',$u_cookie);
	}else{
	die "mais de 5 cookies\n";
	}#fim se
		print "$linha\n";
		}elsif ($linha =~ /^Content-Length:\s+(\d+)/){
		&gravar_status('./auto_arquivos/compri_c.eafc',$1);
		print "$linha\n";
		}elsif ($linha =~ /^Content-Encoding:\s(\w+)/){
		&gravar_status('./auto_arquivos/zip.eafc',$1);
		print "$linha\n";
		}
$linha = <$cliente>;
}#fim while

if ((&mod_agrupar('00',&ler_status('./auto_arquivos/respo.eafc')) eq '200') && ($anali)){
###############################################################gzip
if (&mod_agrupar('00',&ler_status('./auto_arquivos/zip.eafc')) =~ /gzip/i){
				if (&mod_agrupar('00',&ler_status('./auto_arquivos/compri_c.eafc'))){
				read($cliente, $pagina, &mod_agrupar('00',&ler_status('./auto_arquivos/compri_c.eafc')));
				&gravar_status('./auto_arquivos/eafc.gz',$pagina);
				$pagina = gzopen('./auto_arquivos/eafc.gz',"rb");
				$i = 0;				
				while ($pagina->gzreadline($parte[$i]) > 0) {
				$i++;
				}#fim while
				$pagina->gzclose();
				foreach $linha (@parte){
				$linha = decode("utf8", $linha);
				$linha = encode("iso-8859-1", $linha);
				push(@mensagem,$linha);
				}#fim foreach
#print "---------------gzip - comprimento\n";
				}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/transfer.eafc')) =~ /chunked/i){
				$pagina = 1;
				$limite = 0;
				while ($pagina ne 'zero') {
				if (defined($linha)){
						if ($linha =~ /^[a-fA-F0-9]+/i){
						$linha =~ s/\r//g;
						$linha =~ s/\n//g;
						$linha =~ s/\s+//g;
						$pagina = hex($linha);
						if ($pagina == 0){
						$pagina = 'zero';
						}
#						print "$linha--------chunked--------$pagina\n";
						if ($pagina ne 'zero'){
						read($cliente, $linha, $pagina);
						&gravar_status('./auto_arquivos/eafc.gz',$linha);
						$pagina = 'zero';
						}#fim se
						}#fim se
				}else{
				$limite++;
				print "linha foi indefinida $limite\n";
				if ($limite >= 1000){
				$limite = &log_tempo();
				print "$limite\n";
				die "maior que 1000  - gzip $@\n";
				}
				}#fim se defined
				$linha = <$cliente>;
				}#fim while
				$pagina = gzopen('./auto_arquivos/eafc.gz',"rb");
				$i = 0;				
				while ($pagina->gzreadline($parte[$i]) > 0) {
				$i++;
				}#fim while
				$pagina->gzclose();
				foreach $linha (@parte){
				$linha = decode("utf8", $linha);
				$linha = encode("iso-8859-1", $linha);
				push(@mensagem,$linha);
				}#fim foreach
#print "---------------gzip - chunked\n";
				}else{
				read($cliente, $pagina, 100000);
				&gravar_status('./auto_arquivos/eafc.gz',$pagina);
				$pagina = gzopen('./auto_arquivos/eafc.gz',"rb");
				$i = 0;				
				while ($pagina->gzreadline($parte[$i]) > 0) {
				$i++;
				}#fim while
				$pagina->gzclose();
				foreach $linha (@parte){
				$linha = decode("utf8", $linha);
				$linha = encode("iso-8859-1", $linha);
				push(@mensagem,$linha);
				}#fim foreach
print "---------------gzip - 100000\n";
				}#fim else
###############################################################chunked
}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/transfer.eafc')) =~ /chunked/i){
				$pagina = 1;
				$limite = 0;
				while ($pagina ne 'zero') {
				if (defined($linha)){
						if ($linha =~ /^[a-fA-F0-9]+/i){
						$linha =~ s/\r//g;
						$linha =~ s/\n//g;
						$linha =~ s/\s+//g;
						$pagina = hex($linha);
						if ($pagina == 0){
						$pagina = 'zero';
						}
#						print "$linha--------chunked--------$pagina\n";
						if ($pagina ne 'zero'){
						read($cliente, $linha, $pagina);
						push(@mensagem,$linha);
						}#fim se
						}
				}else{
				$limite++;
#				print "linha foi indefinida $limite\n";
				if ($limite >= 1000){
				$limite = &log_tempo();
				print "$limite\n";
				die "maior que 1000 - chunked $@\n";
				}
				}#fim se defined
				$linha = <$cliente>;
				}#fim while
#print "---------------normal - chunked\n";
###############################################################comprimento
}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/compri_c.eafc'))){
				read($cliente, $pagina, &mod_agrupar('00',&ler_status('./auto_arquivos/compri_c.eafc')));
				push(@mensagem,$pagina);
}else{
				$limite = 0;
				while ($linha !~ /<\/html>/i) {
				push(@mensagem,$linha);
				$linha = <$cliente>;
				$limite++;
				if ($limite >= 10000){
				die "nao achou tag html\n";
				}
				}#fim while
				push(@mensagem,$linha);
#print "---------------normal\n";
}#fim else
close($cliente);
@mensagem = &expressao_string(@mensagem);
@parte = &ler_config('1','./auto_arquivos/config.eafc','utf8');
if ($parte[0] == 1){
$linha = @mensagem;
for ($i=0; $i<$linha; $i++){
$mensagem[$i] = decode("iso-8859-1", $mensagem[$i]);
$mensagem[$i] = encode("utf8", $mensagem[$i]);
}#fim for
}#fim se
$linha = &mod_agrupar('11',@mensagem);
if ($linha =~ /CAPTCHA/i){
&gravar_status('./auto_arquivos/unzip.eafc',@mensagem);
die "achou captcha-----------------\n";
}
$linha = length($linha);
if ($linha<200000){
&gravar_status('./auto_arquivos/unzip.eafc',@mensagem);
return 1;
}else{
print "pagina muito grande para processar-----------\n";
&gravar_status('./auto_arquivos/unzip.eafc',@mensagem);
return 0;
}#fim length
}elsif (!$anali){
	print "pagina sem analise-----------\n";
return 1;
}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/respo.eafc')) >= 400){
	print 'servidor respondeu com codigo '.&mod_agrupar('00',&ler_status('./auto_arquivos/respo.eafc'))."\n";
return 0;
}elsif (&mod_agrupar('00',&ler_status('./auto_arquivos/respo.eafc'))){
	print 'servidor respondeu com codigo '.&mod_agrupar('00',&ler_status('./auto_arquivos/respo.eafc'))."\n";
return 1;
}else{
	print "servidor nao respondeu\n";
return 0;
}#fim else
}else{
print "nao foi possivel conectar-----------\n";
return 0;
}#fim else
}

sub abrir_cliente {
my $host = shift || 'localhost';
my $port = shift || '80';
my $server;
my $vez=0;
my @tentativas = &ler_config('1','./auto_arquivos/config.eafc','tentativas');
while (!$server && $vez<$tentativas[0]){
$server = new IO::Socket::INET (
		PeerAddr => $host,
		PeerPort => $port,
		Proto 	=> 'tcp',
		Timeout  => 60
) or $server = &erro_cliente();
$vez++;
&pausar();
}#fim while
return $server;
}

sub erro_cliente {
print "erro: $@\n";
return 0;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#$hex = unpack("H*", pack("N", 3735928559));

sub hex_get {
my @parte = @_;
my $total = @parte;
my $i;
for ($i=0; $i<$total; $i++){
$parte[$i] =~ s/([^\w\s\.])/'%'.sprintf("%x", ord($1))/eg;
$parte[$i] =~ s/ /\+/g;
}#fim for
return @parte; 
}

sub formar_get1 {
my @parte = @_;
my @mapa;
my $total = @parte;
my $i;
my $b=0;
for ($i=0; $i<$total; $i++){
$mapa[$b] = $parte[$i];
$i++;
$mapa[$b] = $mapa[$b].'='.$parte[$i];
$b++;
}#fim for
return @mapa; 
}

sub formar_get2 {
my @parte = @_;
my $linha = join('&',@parte);
return $linha; 
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub limpar_html {
my $pagina = shift;
$pagina = &excluir_tag('<!--','-->','<!--','-->',$pagina);
$pagina = &excluir_tag('<script','<\\\/script>','<script','<\/script>',$pagina);
$pagina = &excluir_tag('<style','<\\\/style>','<style','<\/style>',$pagina);
return $pagina;
}

sub excluir_tag {
my $tag1 = shift;
my $tag2 = shift;
my $tag3 = shift;
my $tag4 = shift;
my $pagina = shift;
my	@lixo;
my $total;
my $i;
my $corde;
my $compri;
my $tcompri;
my $antes;
my $depois;
@lixo = &extrair_tag($tag1,$tag2,$tag3,$tag4,$pagina);
$total = @lixo;
for ($i=0; $i<$total; $i++){
$tcompri = length($pagina);
$compri = length($lixo[$i]);
$corde = index($pagina,"$lixo[$i]");
$antes = substr($pagina,0,$corde);
$depois = substr($pagina,$corde+$compri,$tcompri);
$pagina = $antes.$depois;
}#fim for
return $pagina;
}

sub extrair_tag {
my $abertura = shift;
my $fechamento = shift;
my $abertura2 = shift;
my $fechamento2 = shift;
my @mapa = @_;
my $i = @mapa;
my $linha;
my $pagina;
my $cor1;
my $cor2;
if ($i > 0){
$linha = &mod_agrupar('11',@mapa);
}else{
@mapa = &ler_status('./auto_arquivos/unzip.eafc');
$linha = &mod_agrupar('11',@mapa);
###limpar comentarios
$linha = &excluir_tag('<!--','-->','<!--','-->',$linha);
}
@mapa = ();
do {
	if ($linha =~ /$abertura/i){
	$cor1 = index($linha,"$abertura2");
	if ($linha =~ /$fechamento/i){
	$cor2 = index($linha,"$fechamento2",$cor1);
	$pagina = length($fechamento2);	
	$cor2 = $cor2+$pagina;
	if ($cor1 > -1 && $cor2 > -1 ){
	$pagina = substr($linha,$cor1,($cor2-$cor1));
	$linha =~ s/$abertura/<excluido/i;
	$linha =~ s/$fechamento/<\/excluido>/i;
#	$linha =~ s/$pagina/<excluido \/>/i;
#print "$pagina----------------------------------\n";
	push(@mapa,$pagina);
	}#fim se cor
	}#fim se form
	}else{
	$pagina = 'nada';
	}#fim else
} while ($pagina ne 'nada');
	return @mapa;
}

sub extrair_nome {
my $nome = shift;
my @mapa = @_;
my $linha;
my $i = @mapa;
if ($i > 0){
$linha = &mod_agrupar('11',@mapa);
}else{
@mapa = &ler_status('./auto_arquivos/unzip.eafc');
$linha = &mod_agrupar('11',@mapa);
}
#print "linha ----------------- $linha\n";
@mapa = ();
my $pagina;
do {
	if ($linha =~ /$nome/i){
	$pagina = $1;
	print "pagina ------------ $pagina\n";
	push(@mapa,$pagina);
	$linha =~ s/$nome/<excluido>/i;
	}else{
	$pagina = 'nada';
	}#fim else
} while ($pagina ne 'nada');
	return @mapa;
}

sub garimpar_ancora {
my @mapa = &ler_status('./auto_arquivos/unzip.eafc');
my $linha = &mod_agrupar('11',@mapa);
$linha = &limpar_html($linha);
@mapa = ();
my $pagina;
my @pagi;
my $host;
my $parte;
#	$linha =~ s/<area/<excluido/gi;
do {
	if ($linha =~ /<a([^<>]+)>/i){
	$pagina = $1;
		$linha =~ s/<a/<excluido/i;
		if ($pagina =~ /href="([^"]+)"/i){
		$pagina = $1;
		$host = &mod_agrupar('00',&ler_status('./auto_arquivos/host.eafc'));
		$pagina =~ s/^\\\///i;
		$pagina =~ s/\\\/$//i;
		$pagina =~ s/#.*//i;
			if (($pagina !~ /http:\\\/\\\//i) && ($pagina !~ /https:\\\/\\\//i) && ($pagina !~ /mailto:/i) && ($pagina !~ /javascript:/i)){
					if ($pagina =~ /^\\\.\\\.\\\//i){
					$pagina =~ s/^\\\.\\\.\\\///i;
					$host =~ /(^.+\/)[^\/]+\/$/i;
					$parte = $1;
					$pagina = $parte.$pagina;
					}elsif ($pagina =~ /^\\\.\\\//i){
					$pagina =~ s/^\\\.\\\///i;
					$pagina = $host.$pagina;
					}else{
					$pagina = $host.$pagina;
					}#fim else
			}#fim se http
			if (($pagina !~ /mailto:/i) && ($pagina !~ /javascript:/i)){
				if ($pagina){
				@pagi = &string_expressao($pagina);
				$pagina = $pagi[0];
				push(@mapa,$pagina);
				}#fim se
			}#fim mailto
		}#fim se href
	}else{
	$pagina = 'nada';
	}#fim else
} while ($pagina ne 'nada');
	return @mapa;
}

sub garimpar_meta {
my @mapa = &ler_status('./auto_arquivos/unzip.eafc');
my $linha = &mod_agrupar('11',@mapa);
$linha = &limpar_html($linha);
@mapa = ();
my $pagina;
my @pagi;
my $host;
my $parte;
do {
	if ($linha =~ /<meta([^<>]+)>/i){
	$pagina = $1;
		$linha =~ s/<meta/<excluido/i;
	print $pagina."-------------------meta\n";
		if ($pagina =~ /http-equiv="refresh".+content=".+url=([^"]+)"/i){
		$pagina = $1;
		$host = &mod_agrupar('00',&ler_status('./auto_arquivos/host.eafc'));
		$pagina =~ s/^\\\///i;
		$pagina =~ s/\\\/$//i;
		$pagina =~ s/#.+//i;
			if (($pagina !~ /http:\\\/\\\//i) && ($pagina !~ /https:\\\/\\\//i) && ($pagina !~ /mailto:/i) && ($pagina !~ /javascript:/i)){
					if ($pagina =~ /^\\\.\\\.\\\//i){
					$pagina =~ s/^\\\.\\\.\\\///i;
					$host =~ /(^.+\/)[^\/]+\/$/i;
					$parte = $1;
					$pagina = $parte.$pagina;
					}elsif ($pagina =~ /^\\\.\\\//i){
					$pagina =~ s/^\\\.\\\///i;
					$pagina = $host.$pagina;
					}else{
					$pagina = $host.$pagina;
					}#fim else
			}#fim se http
			if (($pagina !~ /mailto:/i) && ($pagina !~ /javascript:/i)){
				if ($pagina){
				@pagi = &string_expressao($pagina);
				$pagina = $pagi[0];
				push(@mapa,$pagina);
				}#fim se
			}#fim mailto
		}#fim se href
	}else{
	$pagina = 'nada';
	}#fim else
} while ($pagina ne 'nada');
	return @mapa;
}

sub extrair_host {
my @linha = @_;
my $total = @linha;
my $b = 0;
my @parte;
my $i;
for ($i=0; $i<$total; $i++){
	if ($linha[$i] !~ /\/$/){
	$linha[$i] = $linha[$i].'/';
	}#fim se
	if ($linha[$i] !~ /^http:\/\//i){
	$linha[$i] = 'http://'.$linha[$i];
	}#fim se
	if ($linha[$i] =~ /^http:\/\/(.+)\/$/i){
	$linha[$i] = $1;
	}#fim se
if ($linha[$i] !~ /\//i){
&gravar_status('./auto_arquivos/host.eafc','http://'.$linha[$i].'/');
$parte[$b] = $linha[$i];
$b++;
}else{
	if ($linha[$i] =~ /^(.+)\/[^\/]+$/i){
	&gravar_status('./auto_arquivos/host.eafc','http://'.$1.'/');
	}#fim se
	if ($linha[$i] =~ /^([^\/]+)\/(.+)$/i){
	$parte[$b] = $1;
	$b++;
	$parte[$b] = $2;
	$b++;
	}#fim se
}#fim else
}#fim for
	return @parte;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub mod_solicitar {
my $host = shift;
my $caminho = shift;
my $cookie = shift || '';
my $linha = shift || '';
my $ajax = shift || 0;
my @mensagem;
	if ($linha){
		if ($caminho){	
		push(@mensagem,'POST /'.$caminho." HTTP/1.1\n");
		print "----------------------------------------------------\n";
		print 'POST /'.$caminho." HTTP/1.1\n";
		}else{
		push(@mensagem,"POST / HTTP/1.1\n");
		print "----------------------------------------------------\n";
		print "POST / HTTP/1.1\n";
		}#fim se caminho
	}else{
		if ($caminho){	
		push(@mensagem,'GET /'.$caminho." HTTP/1.1\n");
		print "----------------------------------------------------\n";
		print 'GET /'.$caminho." HTTP/1.1\n";
		}else{
		push(@mensagem,"GET / HTTP/1.1\n");
		print "----------------------------------------------------\n";
		print "GET / HTTP/1.1\n";
		}#fim se caminho
	}#fim else linha
	push(@mensagem,'Host: '.$host."\n");
	print 'Host: '.$host."\n\n";
	push(@mensagem,"User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7\n");
	push(@mensagem,"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n");
	push(@mensagem,"Accept-Language: pt-br,pt;q=0.8,en-us;q=0.5,en;q=0.3\n");
#	push(@mensagem,"Accept-Encoding: gzip,deflate\n");
	push(@mensagem,"Accept-Encoding: none\n");
	push(@mensagem,"Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\n");
	push(@mensagem,"Keep-Alive: 300\n");
$host = length($linha);
	if (($cookie) && ($linha)){
	push(@mensagem,"Connection: keep-alive\n");
	push(@mensagem,'Cookie: '.$cookie."\n");
print 'cookie: '.$cookie."\n\n";
if ($ajax){
	push(@mensagem,"X-Requested-With: XMLHttpRequest\n");
}#se ajax
	push(@mensagem,"Content-Type: application/x-www-form-urlencoded\n");
	push(@mensagem,'Content-Length: '.$host."\n\n");
if ($linha ne '1'){
	push(@mensagem,$linha);
}
print 'linha: '.$linha."\n\n";
	}elsif ($cookie){
	push(@mensagem,"Connection: keep-alive\n");
	push(@mensagem,'Cookie: '.$cookie."\n");
	push(@mensagem,"Cache-Control: max-age=0\n\n");
print 'cookie: '.$cookie."\n\n";
	}elsif ($linha){
	push(@mensagem,"Connection: keep-alive\n");
	push(@mensagem,"Content-Type: application/x-www-form-urlencoded\n");
	push(@mensagem,'Content-Length: '.$host."\n\n");
if ($linha ne '1'){
	push(@mensagem,$linha);
}
print 'linha: '.$linha."\n\n";
	}else{
	push(@mensagem,"Connection: keep-alive\n\n");
	}#fim else
return @mensagem;
}

1;
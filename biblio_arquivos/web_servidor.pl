## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;
use IO::Socket;
use Encode;
use Digest::MD5 qw(md5 md5_hex md5_base64);

sub servidor_pagina {
my $limite = 0;
my $cliente;
my $linha;
my $pagina;
my $parte;
my	@auto;
my	@linhas;
my $server = &abrir_servidor();
do {
&gravar_tempo();
@auto = &ler_status('./auto_arquivos/col.eafc');
if ($auto[0]){
&ativar_auto();
}#fim se pagina
$cliente = $server->accept();
###$cliente->autoflush(1);
$linha = <$cliente>;
		@auto = &ler_status('./auto_arquivos/processo.eafc');
		if ($auto[0]){
		&zerar('1');
		}else{
		&zerar('0');
		}#fim se auto
		while ($linha =~ /\w+/){
#			print "$linha\n";
###if (defined($linha)){
			if ($linha =~ /GET\s\/(.*)\shttp\/\d\.\d/i){
#			print "----------------------------------------------------\n";
#			print "$linha\n";
					if ($auto[0]){
			&gravar_status('./auto_arquivos/metodo.eafc','get');
					}#se auto
			$parte = $1;
			$pagina = $parte;
					if ($pagina =~ /\?/){
					$pagina =~ s/.*\?//;
					if ($auto[0]){
					&gravar_status('./auto_arquivos/linha_get.eafc',$pagina);
					}#se auto
					$pagina = $parte;
					$pagina =~ s/\?.*//;
					&gravar_status('./auto_arquivos/status.eafc',$pagina);
					}elsif ($pagina =~ /\w+/){
					&gravar_status('./auto_arquivos/status.eafc',$pagina);
					if ($auto[0]){
					&gravar_status('./auto_arquivos/linha_get.eafc','');
					}#se auto
					}else {
					&gravar_status('./auto_arquivos/status.eafc','mod_inicio');
					if ($auto[0]){
					&gravar_status('./auto_arquivos/linha_get.eafc','');
					}#se auto
					}#fim se pagina
			}elsif ($linha =~ /POST\s\/(.*)\shttp\/\d\.\d/i){
					if ($auto[0]){
			&gravar_status('./auto_arquivos/metodo.eafc','post');
					}#se auto
			$parte = $1;
			$pagina = $parte;
					if ($pagina =~ /\w+/){
					&gravar_status('./auto_arquivos/status.eafc',$pagina);
					}
			}elsif ($linha =~ /^Content-Length:\s+(\d+).*$/){
			$pagina = $1;
			&gravar_status('./auto_arquivos/compri_s.eafc',$pagina);
			}elsif (($linha =~ /^If-None-Match:\s"(.+)"/i) && ($auto[0])){
			$pagina = $1;
			&gravar_status('./auto_arquivos/etag.eafc',$pagina);
			}elsif (($linha =~ /^If-Modified-Since:\s(.+GMT).*$/i) && ($auto[0])){
			$pagina = $1;
			&gravar_status('./auto_arquivos/data.eafc',$pagina);
			}#fim elsif get
#}else{
#$limite++;
#print "linha foi indefinida $limite\n";
#				if ($limite >= 10000){
#				die "maior que 10000 $@\n";
#				}
#}#fim se defined
		$linha = <$cliente>;
		}#fim while
		if (&mod_agrupar('00',&ler_status('./auto_arquivos/compri_s.eafc')) && (&mod_agrupar('00',&ler_status('./auto_arquivos/metodo.eafc')) eq 'post')){
		read($cliente, $pagina, &mod_agrupar('00',&ler_status('./auto_arquivos/compri_s.eafc')));
		if ($auto[0]){
		&gravar_status('./auto_arquivos/linha_post.eafc',$pagina);
		}#se auto
		}#fim se
		$pagina = &mod_agrupar('00',&ler_status('./auto_arquivos/status.eafc'));
		if ($pagina){
		if ($auto[0]){
		@auto = extrair_imagem($parte);
		if ((!$auto[0]) && ($pagina ne 'mod_saida')){
		&gravar_status('./auto_arquivos/processo.eafc','0');
		@linhas = &formar_html('mod_processo','','',$pagina,'');
		}else{
		&gravar_status('./auto_arquivos/processo.eafc','1');
		@linhas = &formar_html($pagina,&mod_agrupar('00',&ler_status('./auto_arquivos/linha_get.eafc')),&mod_agrupar('00',&ler_status('./auto_arquivos/linha_post.eafc')),&mod_agrupar('00',&ler_status('./auto_arquivos/etag.eafc')),&mod_agrupar('00',&ler_status('./auto_arquivos/data.eafc')));
		}#fim se
		}else{
		&gravar_status('./auto_arquivos/processo.eafc','1');
		@linhas = &formar_html($pagina,&mod_agrupar('00',&ler_status('./auto_arquivos/linha_get.eafc')),&mod_agrupar('00',&ler_status('./auto_arquivos/linha_post.eafc')),&mod_agrupar('00',&ler_status('./auto_arquivos/etag.eafc')),&mod_agrupar('00',&ler_status('./auto_arquivos/data.eafc')));
		}#fim se mod_processo
#			print "----------------------------------------------------\n";
#			print "@linhas";
		&enviar_pagina($cliente,@linhas);
		}#fim se pagina
} while (&mod_agrupar('00',&ler_status('./auto_arquivos/status.eafc')) ne 'mod_saida');
##	$cliente = '';
close($server);
}

sub abrir_servidor {
my $server;
my @porta = &ler_config('1','./auto_arquivos/config.eafc','porta');
while (!$server){
$server = new IO::Socket::INET (
     LocalAddr => 'localhost',
     LocalPort => $porta[0],
     Proto     => 'tcp',
     Type      => SOCK_STREAM,
     Listen    => SOMAXCONN,
     ReuseAddr	=> 1
) or die "erro: $@\n";
}#fim while
return $server;
}

sub enviar_pagina {
my $cliente = shift;
my @mensagem = @_;
my $pagina;
		foreach $pagina (@mensagem) {
#		$pagina = decode("iso-8859-1", $pagina);
#		$pagina = encode("utf8", $pagina);
		print $cliente $pagina;
		}#fim foreach
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub dividir_get {
my $linha = shift || '';
my @parte = split(/&/, $linha);
my $total = @parte;
my @mapa;
my $i;
my $b=0;
for ($i=0; $i<$total; $i++){
my ($key, $val) = split(/=/, $parte[$i]);
	$val =~ s/\+/ /g;
	$val =~ s/%([a-fA-F0-9]{2})/chr(hex($1))/eg;
#	$val =~ s/%(..)/chr(hex($1))/eg;
$mapa[$b] = $key;
$b++;
$mapa[$b] = $val;
$b++;
}#fim for
return @mapa; 
}

sub criar_etag {
my $parte = shift || '';
my $indice = length($parte);
my $resto = $indice % 2;
	if ($resto == 0){
	$indice = $indice/2;
	}
	else{
	$indice = ($indice-1)/2;
	}
$indice = substr($parte,$indice,10);
$indice = md5_hex($indice);
return $indice;
}

sub zerar {
my $auto = shift;
if ($auto eq '1'){
&gravar_status('./auto_arquivos/linha_get.eafc','');
&gravar_status('./auto_arquivos/linha_post.eafc','');
&gravar_status('./auto_arquivos/data.eafc','');
&gravar_status('./auto_arquivos/etag.eafc','');
&gravar_status('./auto_arquivos/metodo.eafc','');
}
&gravar_status('./auto_arquivos/compri_s.eafc','');
&gravar_status('./auto_arquivos/compri_c.eafc','');
&gravar_status('./auto_arquivos/host.eafc','');
&gravar_status('./auto_arquivos/respo.eafc','200');
&gravar_status('./auto_arquivos/status.eafc','');
&gravar_status('./auto_arquivos/transfer.eafc','');
&gravar_status('./auto_arquivos/ultima.eafc','1');
&gravar_status('./auto_arquivos/ultima2.eafc','1');
&gravar_status('./auto_arquivos/ultima3.eafc','1');
&gravar_status('./auto_arquivos/ultima4.eafc','1');
&gravar_status('./auto_arquivos/ultima5.eafc','1');
&gravar_status('./auto_arquivos/location.eafc','1');
&gravar_status('./auto_arquivos/zip.eafc','');
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub extrair_css {
my $linha = shift || '';
	if ($linha =~ /.+\.css$/i){
	return $linha;
	}#fim se
}

sub extrair_js {
my $linha = shift || '';
	if ($linha =~ /.+\.js$/i){
	return $linha;
	}#fim se
}

sub extrair_ico {
my $linha = shift || '';
	if ($linha =~ /.+\.ico$/i){
	return $linha;
	}#fim se
}

sub extrair_jpg {
my $linha = shift || '';
	if (($linha =~ /.+\.jpg$/i) || ($linha =~ /.+\.jpeg$/i)){
	return $linha;
	}#fim se
}

sub extrair_png {
my $linha = shift || '';
	if ($linha =~ /.+\.png$/i){
	return $linha;
	}#fim se
}

sub extrair_gif {
my $linha = shift || '';
	if ($linha =~ /.+\.gif$/i){
	return $linha;
	}#fim se
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub mod_responder {
my $parte = shift;
my $etag1 = shift || 'vazio';
my $data = shift || 'vazio';
my $etag2 = &criar_etag($parte);
my @data2 = &ler_config('1','./auto_arquivos/config.eafc','data_padrao');
my @mensagem;
	if ((($etag1 eq $etag2) && ($data eq $data2[0])) || (($etag1 eq 'vazio') && ($data eq $data2[0]))){
	push(@mensagem,"HTTP/1.1 304 Not Modified\n");
#print $data."\n";
#print $etag1."\n";
#print $etag2."\n";
#print "HTTP/1.1 304 Not Modified\n";
	push(@mensagem,"Date: Mon, 06 Apr 2009 22:15:08 GMT\n");
	push(@mensagem,"Server: Apache\n");
	push(@mensagem,'Etag: "'.$etag2.'"'."\n");
	push(@mensagem,"X-Cache: MISS from server\n");
	push(@mensagem,"Via: 1.1 server:3128 (squid/2.7.STABLE5)\n");
	push(@mensagem,"Connection: close\n");
	}
	else{
	push(@mensagem,"HTTP/1.1 200 OK\n");
#print $data."\n";
#print $etag1."\n";
#print $etag2."\n";
#print "HTTP/1.1 200 OK\n";
	push(@mensagem,"Date: Mon, 06 Apr 2009 22:15:08 GMT\n");
	push(@mensagem,"Server: Apache\n");
	push(@mensagem,'Last-Modified: '.$data2[0]."\n");
	push(@mensagem,'Etag: "'.$etag2.'"'."\n");
	push(@mensagem,"Accept-Ranges: bytes\n");
	push(@mensagem,"Age: 20000\n");
	push(@mensagem,"X-Cache: HIT from server\n");
	push(@mensagem,"Via: 1.1 server:3128 (squid/2.7.STABLE5)\n");
	push(@mensagem,"Connection: close\n");
	}
return @mensagem;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub mod_html_s {
my @mensagem = @_;
my $parte = &mod_agrupar('00',@mensagem);
	$parte = encode("utf8", $parte);
my $indice = length($parte);
		@mensagem = ();
	if (defined($indice)){
		push(@mensagem,"HTTP/1.1 200 OK\n");
#print "HTTP/1.1 200 OK\n";
		push(@mensagem,"Date: Mon, 06 Apr 2009 22:15:08 GMT\n");
		push(@mensagem,"Server: Apache\n");
		push(@mensagem,"X-Powered-By: PHP/5.2.5\n");
		push(@mensagem,"Vary: Accept-Encoding\n");
		push(@mensagem,"Content-Encoding: gzip,deflate\n");
		push(@mensagem,'Content-Length: '.$indice."\n");
		push(@mensagem,"X-Cache: MISS from server\n");
		push(@mensagem,"Via: 1.1 server:3128 (squid/2.7.STABLE5)\n");
		push(@mensagem,"Content-type: text/html\n");
		push(@mensagem,"Connection: close\n\n");
		push(@mensagem,$parte);
return @mensagem;
	}#fim se
}

sub mod_css_s {
my $indice = shift;
my $etag = shift || '';
my $data = shift || '';
my @mensagem;
my $parte = &mod_agrupar('00',&ler_status($indice));
	$parte = encode("utf8", $parte);
	$indice = length($parte);
if (defined($indice)){
		@mensagem = &mod_responder($parte,$etag,$data);
		push(@mensagem,"Vary: Accept-Encoding\n");
		push(@mensagem,"Content-Encoding: gzip,deflate\n");
		push(@mensagem,'Content-Length: '.$indice."\n");
		push(@mensagem,"Content-type: text/css\n\n");
		if ($mensagem[0] =~ /.+\s200\s.+/){
		push(@mensagem,$parte);
		}
return @mensagem;
}#fim se
}

sub mod_js_s {
my $indice = shift;
my $etag = shift || '';
my $data = shift || '';
my @mensagem;
my $parte = &mod_agrupar('00',&ler_status($indice));
	$parte = encode("utf8", $parte);
	$indice = length($parte);
if (defined($indice)){
		@mensagem = &mod_responder($parte,$etag,$data);
		push(@mensagem,"Vary: Accept-Encoding\n");
		push(@mensagem,"Content-Encoding: gzip,deflate\n");
		push(@mensagem,'Content-Length: '.$indice."\n");
		push(@mensagem,"Content-type: text/javascript\n\n");
		if ($mensagem[0] =~ /.+\s200\s.+/){
		push(@mensagem,$parte);
		}
return @mensagem;
}#fim se
}

sub mod_ico_s {
my $indice = shift;
my $etag = shift || '';
my $data = shift || '';
my @mensagem;
my $parte = &mod_agrupar('00',&ler_imagem($indice));
	$parte = encode("iso-8859-1", $parte);
	$indice = length($parte);
if (defined($indice)){
		@mensagem = &mod_responder($parte,$etag,$data);
		push(@mensagem,'Content-Length: '.$indice."\n");
		push(@mensagem,"Content-type: image/x-icon\n\n");
		if ($mensagem[0] =~ /.+\s200\s.+/){
		push(@mensagem,$parte);
		}
return @mensagem;
}#fim se
}

sub mod_jpg_s {
my $indice = shift;
my $etag = shift || '';
my $data = shift || '';
my @mensagem;
my $parte = &mod_agrupar('00',&ler_imagem($indice));
	$parte = encode("iso-8859-1", $parte);
	$indice = length($parte);
if (defined($indice)){
		@mensagem = &mod_responder($parte,$etag,$data);
		push(@mensagem,'Content-Length: '.$indice."\n");
		push(@mensagem,"Content-type: image/jpeg\n\n");
		if ($mensagem[0] =~ /.+\s200\s.+/){
		push(@mensagem,$parte);
		}
return @mensagem;
}#fim se
}

sub mod_png_s {
my $indice = shift;
my $etag = shift || '';
my $data = shift || '';
my @mensagem;
my $parte = &mod_agrupar('00',&ler_imagem($indice));
	$parte = encode("iso-8859-1", $parte);
	$indice = length($parte);
if (defined($indice)){
		@mensagem = &mod_responder($parte,$etag,$data);
		push(@mensagem,'Content-Length: '.$indice."\n");
		push(@mensagem,"Content-type: image/png\n\n");
		if ($mensagem[0] =~ /.+\s200\s.+/){
		push(@mensagem,$parte);
		}
return @mensagem;
}#fim se
}

sub mod_gif_s {
my $indice = shift;
my $etag = shift || '';
my $data = shift || '';
my @mensagem;
my $parte = &mod_agrupar('00',&ler_imagem($indice));
	$parte = encode("iso-8859-1", $parte);
	$indice = length($parte);
if (defined($indice)){
		@mensagem = &mod_responder($parte,$etag,$data);
		push(@mensagem,'Content-Length: '.$indice."\n");
		push(@mensagem,"Content-type: image/gif\n\n");
		if ($mensagem[0] =~ /.+\s200\s.+/){
		push(@mensagem,$parte);
		}
return @mensagem;
}#fim se
}

1;

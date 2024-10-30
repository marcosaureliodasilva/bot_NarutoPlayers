## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use warnings;
use strict;

sub sem_linha_col {
my $acao = shift;
my $titulo = shift;
my $mensagem = '<form action="'.$acao.'" method="POST">
	<div class="formula9">executar a&#231;&#227;o:</div>
   <div class="formula9"><input class="formula9" type="submit" value="'.$titulo.'"></div>
</form>';
return $mensagem;
}

sub menu_web_col {
my $neutro = shift || '';
my $mensagem = &abrir_div_g('p_espe1');
$mensagem = $mensagem.&abrir_div_g('p_espe2');
$mensagem = $mensagem.&abrir_div_g('p_espe3');
$mensagem = $mensagem.&anc_menu('menu_web',$neutro,'mod_cookie','cookie','mod_dados','dados','mod_resto','resto','mod_colonia','colonia','mod_tempo','tempo');
$mensagem = $mensagem.&fechar_div('p_espe3');
$mensagem = $mensagem.&fechar_div('p_espe2');
$mensagem = $mensagem.&fechar_div('p_espe1');
$neutro = &mod_agrupar('00',&ler_config('1','./auto_arquivos/config.eafc','acesso'));
if ($neutro ne 'escola'){
$mensagem = ' ';
}
return $mensagem;
}

sub menu_web_tes {
my $neutro = shift || '';
my $mensagem = &abrir_div_g('p_espe1');
$mensagem = $mensagem.&abrir_div_g('p_espe2');
$mensagem = $mensagem.&abrir_div_g('p_espe3');
$mensagem = $mensagem.&anc_menu('menu_web',$neutro,'mod_forms','forms','mod_opcoes','op&#231;&#245;es');
$mensagem = $mensagem.&fechar_div('p_espe3');
$mensagem = $mensagem.&fechar_div('p_espe2');
$mensagem = $mensagem.&fechar_div('p_espe1');
$neutro = &mod_agrupar('00',&ler_config('1','./auto_arquivos/config.eafc','acesso'));
if ($neutro ne 'escola'){
$mensagem = ' ';
}
return $mensagem;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub formar_html {
my $indice = shift || '';
my $linha_g = shift || '';
my $linha_p = shift || '';
my $etag = shift || '';
my $data = shift || '';
my @mensagem;
if ($indice eq 'mod_inicio'){
@mensagem = &mod_inicio($linha_g,$linha_p);
}elsif ($indice eq 'mod_processo'){
@mensagem = &mod_processo($linha_g,$linha_p,$etag);
}elsif ($indice eq 'mod_menu'){
@mensagem = &mod_menu($linha_g,$linha_p);
}elsif ($indice eq 'r_menu'){
@mensagem = &r_menu($linha_g,$linha_p);
}elsif ($indice eq 'mod_forms'){
@mensagem = &mod_forms($linha_g,$linha_p);
}elsif ($indice eq 'r_forms'){
@mensagem = &r_forms($linha_g,$linha_p);
}elsif ($indice eq 'mod_opcoes'){
@mensagem = &mod_opcoes($linha_g,$linha_p);
}elsif ($indice eq 'r_opcoes'){
@mensagem = &r_opcoes($linha_g,$linha_p);
}elsif ($indice eq 'mod_config'){
@mensagem = &mod_config($linha_g,$linha_p);
}elsif ($indice eq 'r_config'){
@mensagem = &r_config($linha_g,$linha_p);
}elsif ($indice eq 'mod_cookie'){
@mensagem = &mod_cookie($linha_g,$linha_p);
}elsif ($indice eq 'r_cookie'){
@mensagem = &r_cookie($linha_g,$linha_p);
}elsif ($indice eq 'mod_tempo'){
@mensagem = &mod_tempo($linha_g,$linha_p);
}elsif ($indice eq 'r_tempo'){
@mensagem = &r_tempo($linha_g,$linha_p);
}elsif ($indice eq 'mod_dados'){
@mensagem = &mod_dados($linha_g,$linha_p);
}elsif ($indice eq 'r_dados'){
@mensagem = &r_dados($linha_g,$linha_p);
}elsif ($indice eq 'mod_resto'){
@mensagem = &mod_resto($linha_g,$linha_p);
}elsif ($indice eq 'r_resto'){
@mensagem = &r_resto($linha_g,$linha_p);
}elsif ($indice eq 'mod_colonia'){
	my	@acao = &ler_status('./auto_arquivos/col.eafc');
	if ($acao[0]){
	@mensagem = &mod_colonia_off($linha_g,$linha_p);
	}else{
	@mensagem = &mod_colonia_on($linha_g,$linha_p);
	}
}elsif ($indice eq 'r_colonia'){
@mensagem = &r_colonia($linha_g,$linha_p);
}elsif ($indice eq 'r_ini_colonia'){
@mensagem = &r_ini_colonia($linha_g,$linha_p);
}elsif ($indice eq 'r_descolonia'){
@mensagem = &r_descolonia($linha_g,$linha_p);
}elsif ($indice eq 'mod_saida'){
@mensagem = &mod_saida($linha_g,$linha_p);
}elsif (extrair_css($indice)){
@mensagem = &mod_css_s($indice,$etag,$data);
}elsif (extrair_js($indice)){
@mensagem = &mod_js_s($indice,$etag,$data);
}elsif (extrair_ico($indice)){
@mensagem = &mod_ico_s($indice,$etag,$data);
}elsif (extrair_jpg($indice)){
@mensagem = &mod_jpg_s($indice,$etag,$data);
}elsif (extrair_png($indice)){
@mensagem = &mod_png_s($indice,$etag,$data);
}elsif (extrair_gif($indice)){
@mensagem = &mod_gif_s($indice,$etag,$data);
}else{
print 'erro de status: ';
print "$indice\n";
}#fim else
return @mensagem;
}

sub mod_config {
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
push(@mensagem,&rotulo_html('pagina config','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'data_padrao'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'q_dados'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'mercado'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'ponto'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'tentativas'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'pausar'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'reconectar'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'t_reload'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'p_reload'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'nome_mercado'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'nome_inimigo'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'nome_fome'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'utf8'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'porta'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('1','r_config','./auto_arquivos/config.eafc',1,'acesso'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web(3));
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

sub mod_cookie {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina cookie','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c1_nome','c1_tempo','c1_cookie','c1_linha','c1_form','c1_origem','c1_recurso','c1_login','c1_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c2_nome','c2_tempo','c2_cookie','c2_linha','c2_form','c2_origem','c2_recurso','c2_login','c2_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c3_nome','c3_tempo','c3_cookie','c3_linha','c3_form','c3_origem','c3_recurso','c3_login','c3_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c4_nome','c4_tempo','c4_cookie','c4_linha','c4_form','c4_origem','c4_recurso','c4_login','c4_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c5_nome','c5_tempo','c5_cookie','c5_linha','c5_form','c5_origem','c5_recurso','c5_login','c5_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c6_nome','c6_tempo','c6_cookie','c6_linha','c6_form','c6_origem','c6_recurso','c6_login','c6_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c7_nome','c7_tempo','c7_cookie','c7_linha','c7_form','c7_origem','c7_recurso','c7_login','c7_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c8_nome','c8_tempo','c8_cookie','c8_linha','c8_form','c8_origem','c8_recurso','c8_login','c8_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c9_nome','c9_tempo','c9_cookie','c9_linha','c9_form','c9_origem','c9_recurso','c9_login','c9_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c10_nome','c10_tempo','c10_cookie','c10_linha','c10_form','c10_origem','c10_recurso','c10_login','c10_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c11_nome','c11_tempo','c11_cookie','c11_linha','c11_form','c11_origem','c11_recurso','c11_login','c11_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c12_nome','c12_tempo','c12_cookie','c12_linha','c12_form','c12_origem','c12_recurso','c12_login','c12_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c13_nome','c13_tempo','c13_cookie','c13_linha','c13_form','c13_origem','c13_recurso','c13_login','c13_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c14_nome','c14_tempo','c14_cookie','c14_linha','c14_form','c14_origem','c14_recurso','c14_login','c14_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c15_nome','c15_tempo','c15_cookie','c15_linha','c15_form','c15_origem','c15_recurso','c15_login','c15_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c16_nome','c16_tempo','c16_cookie','c16_linha','c16_form','c16_origem','c16_recurso','c16_login','c16_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c17_nome','c17_tempo','c17_cookie','c17_linha','c17_form','c17_origem','c17_recurso','c17_login','c17_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c18_nome','c18_tempo','c18_cookie','c18_linha','c18_form','c18_origem','c18_recurso','c18_login','c18_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c19_nome','c19_tempo','c19_cookie','c19_linha','c19_form','c19_origem','c19_recurso','c19_login','c19_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c20_nome','c20_tempo','c20_cookie','c20_linha','c20_form','c20_origem','c20_recurso','c20_login','c20_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c21_nome','c21_tempo','c21_cookie','c21_linha','c21_form','c21_origem','c21_recurso','c21_login','c21_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c22_nome','c22_tempo','c22_cookie','c22_linha','c22_form','c22_origem','c22_recurso','c22_login','c22_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c23_nome','c23_tempo','c23_cookie','c23_linha','c23_form','c23_origem','c23_recurso','c23_login','c23_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c24_nome','c24_tempo','c24_cookie','c24_linha','c24_form','c24_origem','c24_recurso','c24_login','c24_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c25_nome','c25_tempo','c25_cookie','c25_linha','c25_form','c25_origem','c25_recurso','c25_login','c25_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c26_nome','c26_tempo','c26_cookie','c26_linha','c26_form','c26_origem','c26_recurso','c26_login','c26_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c27_nome','c27_tempo','c27_cookie','c27_linha','c27_form','c27_origem','c27_recurso','c27_login','c27_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c28_nome','c28_tempo','c28_cookie','c28_linha','c28_form','c28_origem','c28_recurso','c28_login','c28_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c29_nome','c29_tempo','c29_cookie','c29_linha','c29_form','c29_origem','c29_recurso','c29_login','c29_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c30_nome','c30_tempo','c30_cookie','c30_linha','c30_form','c30_origem','c30_recurso','c30_login','c30_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c31_nome','c31_tempo','c31_cookie','c31_linha','c31_form','c31_origem','c31_recurso','c31_login','c31_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c32_nome','c32_tempo','c32_cookie','c32_linha','c32_form','c32_origem','c32_recurso','c32_login','c32_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c33_nome','c33_tempo','c33_cookie','c33_linha','c33_form','c33_origem','c33_recurso','c33_login','c33_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c34_nome','c34_tempo','c34_cookie','c34_linha','c34_form','c34_origem','c34_recurso','c34_login','c34_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c35_nome','c35_tempo','c35_cookie','c35_linha','c35_form','c35_origem','c35_recurso','c35_login','c35_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c36_nome','c36_tempo','c36_cookie','c36_linha','c36_form','c36_origem','c36_recurso','c36_login','c36_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c37_nome','c37_tempo','c37_cookie','c37_linha','c37_form','c37_origem','c37_recurso','c37_login','c37_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c38_nome','c38_tempo','c38_cookie','c38_linha','c38_form','c38_origem','c38_recurso','c38_login','c38_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c39_nome','c39_tempo','c39_cookie','c39_linha','c39_form','c39_origem','c39_recurso','c39_login','c39_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_cookie','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c40_nome','c40_tempo','c40_cookie','c40_linha','c40_form','c40_origem','c40_recurso','c40_login','c40_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col(1));
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

sub mod_tempo {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina tempo','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c1_nome','c1_tempo','c1_cookie','c1_linha','c1_form','c1_origem','c1_recurso','c1_login','c1_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c2_nome','c2_tempo','c2_cookie','c2_linha','c2_form','c2_origem','c2_recurso','c2_login','c2_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c3_nome','c3_tempo','c3_cookie','c3_linha','c3_form','c3_origem','c3_recurso','c3_login','c3_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c4_nome','c4_tempo','c4_cookie','c4_linha','c4_form','c4_origem','c4_recurso','c4_login','c4_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c5_nome','c5_tempo','c5_cookie','c5_linha','c5_form','c5_origem','c5_recurso','c5_login','c5_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c6_nome','c6_tempo','c6_cookie','c6_linha','c6_form','c6_origem','c6_recurso','c6_login','c6_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c7_nome','c7_tempo','c7_cookie','c7_linha','c7_form','c7_origem','c7_recurso','c7_login','c7_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c8_nome','c8_tempo','c8_cookie','c8_linha','c8_form','c8_origem','c8_recurso','c8_login','c8_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c9_nome','c9_tempo','c9_cookie','c9_linha','c9_form','c9_origem','c9_recurso','c9_login','c9_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c10_nome','c10_tempo','c10_cookie','c10_linha','c10_form','c10_origem','c10_recurso','c10_login','c10_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c11_nome','c11_tempo','c11_cookie','c11_linha','c11_form','c11_origem','c11_recurso','c11_login','c11_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c12_nome','c12_tempo','c12_cookie','c12_linha','c12_form','c12_origem','c12_recurso','c12_login','c12_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c13_nome','c13_tempo','c13_cookie','c13_linha','c13_form','c13_origem','c13_recurso','c13_login','c13_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c14_nome','c14_tempo','c14_cookie','c14_linha','c14_form','c14_origem','c14_recurso','c14_login','c14_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c15_nome','c15_tempo','c15_cookie','c15_linha','c15_form','c15_origem','c15_recurso','c15_login','c15_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c16_nome','c16_tempo','c16_cookie','c16_linha','c16_form','c16_origem','c16_recurso','c16_login','c16_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c17_nome','c17_tempo','c17_cookie','c17_linha','c17_form','c17_origem','c17_recurso','c17_login','c17_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c18_nome','c18_tempo','c18_cookie','c18_linha','c18_form','c18_origem','c18_recurso','c18_login','c18_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c19_nome','c19_tempo','c19_cookie','c19_linha','c19_form','c19_origem','c19_recurso','c19_login','c19_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c20_nome','c20_tempo','c20_cookie','c20_linha','c20_form','c20_origem','c20_recurso','c20_login','c20_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c21_nome','c21_tempo','c21_cookie','c21_linha','c21_form','c21_origem','c21_recurso','c21_login','c21_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c22_nome','c22_tempo','c22_cookie','c22_linha','c22_form','c22_origem','c22_recurso','c22_login','c22_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c23_nome','c23_tempo','c23_cookie','c23_linha','c23_form','c23_origem','c23_recurso','c23_login','c23_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c24_nome','c24_tempo','c24_cookie','c24_linha','c24_form','c24_origem','c24_recurso','c24_login','c24_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c25_nome','c25_tempo','c25_cookie','c25_linha','c25_form','c25_origem','c25_recurso','c25_login','c25_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c26_nome','c26_tempo','c26_cookie','c26_linha','c26_form','c26_origem','c26_recurso','c26_login','c26_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c27_nome','c27_tempo','c27_cookie','c27_linha','c27_form','c27_origem','c27_recurso','c27_login','c27_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c28_nome','c28_tempo','c28_cookie','c28_linha','c28_form','c28_origem','c28_recurso','c28_login','c28_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c29_nome','c29_tempo','c29_cookie','c29_linha','c29_form','c29_origem','c29_recurso','c29_login','c29_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c30_nome','c30_tempo','c30_cookie','c30_linha','c30_form','c30_origem','c30_recurso','c30_login','c30_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c31_nome','c31_tempo','c31_cookie','c31_linha','c31_form','c31_origem','c31_recurso','c31_login','c31_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c32_nome','c32_tempo','c32_cookie','c32_linha','c32_form','c32_origem','c32_recurso','c32_login','c32_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c33_nome','c33_tempo','c33_cookie','c33_linha','c33_form','c33_origem','c33_recurso','c33_login','c33_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c34_nome','c34_tempo','c34_cookie','c34_linha','c34_form','c34_origem','c34_recurso','c34_login','c34_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c35_nome','c35_tempo','c35_cookie','c35_linha','c35_form','c35_origem','c35_recurso','c35_login','c35_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c36_nome','c36_tempo','c36_cookie','c36_linha','c36_form','c36_origem','c36_recurso','c36_login','c36_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c37_nome','c37_tempo','c37_cookie','c37_linha','c37_form','c37_origem','c37_recurso','c37_login','c37_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c38_nome','c38_tempo','c38_cookie','c38_linha','c38_form','c38_origem','c38_recurso','c38_login','c38_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c39_nome','c39_tempo','c39_cookie','c39_linha','c39_form','c39_origem','c39_recurso','c39_login','c39_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('9','r_tempo','./auto_col_arquivos/col_caminhos.eafc',1,0,0,0,2,1,0,1,0,'c40_nome','c40_tempo','c40_cookie','c40_linha','c40_form','c40_origem','c40_recurso','c40_login','c40_senha'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col(5));
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

sub mod_dados {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina dados','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&sem_linha_col('r_dados','todos os cookies'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col(2));
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

sub mod_resto {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina resto','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&sem_linha_col('r_resto','todos os restos'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col(3));
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

sub mod_colonia_on {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina colonia','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&sem_linha_col('r_colonia','ligar colonia'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col(4));
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

sub mod_colonia_off {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina descolonia','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&sem_linha_col('r_descolonia','desligar colonia'));
push(@mensagem,&fechar_div('formula2'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&abrir_div_g('formula2a'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web_col(4));
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

sub mod_forms {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina forms','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('2','r_forms','./auto_arquivos/caminhos.eafc',1,1,'caminho1','c1_cookie'));
push(@mensagem,&fechar_div('formula2'));
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
push(@mensagem,&menu_web_tes(1));
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&fechar_div('formula1'));
push(@mensagem,&fechar_html());
@mensagem = mod_html_s(@mensagem);
return @mensagem;
}

sub mod_opcoes {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina op&#231;&#245;es','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&abrir_div_g('formula2'));
push(@mensagem,&buscar_html('2','r_opcoes','./auto_arquivos/caminhos.eafc',1,1,'caminho1','c1_cookie'));
push(@mensagem,&fechar_div('formula2'));
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
push(@mensagem,&menu_web_tes(2));
push(@mensagem,&fechar_div('formula2a'));
push(@mensagem,&fechar_div('formula1'));
push(@mensagem,&fechar_html());
@mensagem = mod_html_s(@mensagem);
return @mensagem;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub r_cookie {
my $linha_g = shift || '';
my $linha_p = shift || '';
my $total;
my @tags;
my @mensagem;
my @cookie;
my @pagina = &ler_config('5','./auto_col_arquivos/endereco.eafc','pagina0','pagina1','pagina2','pagina3','pagina4');
my @linha_pg;
@linha_pg = &ler_status('./auto_arquivos/metodo.eafc');
if ($linha_pg[0] eq 'post') {
@linha_pg = &dividir_get($linha_p);
}elsif ($linha_pg[0] eq 'get') {
@linha_pg = &dividir_get($linha_g);
}else {
die "erro no get ou post\n";
}
my @atual;
@cookie = &sugar_cookie_naruto('./auto_col_arquivos/col_caminhos.eafc',$linha_pg[0],$linha_pg[4],$pagina[0],$pagina[1],'');
####c_nome,c_cookie,c_origem
@cookie = &ler_config('3','./auto_col_arquivos/col_caminhos.eafc',$linha_pg[0],$linha_pg[4],$linha_pg[10]);
@atual = &sugar_form($pagina[0],$cookie[0],$linha_pg[4],'','./auto_col_arquivos/col_caminhos.eafc');
if ($atual[0]) {
	@tags = &garimpar_tag('0','2','input','name','value',$atual[0]);
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$linha_pg[8],$atual[0]);
##login,senha,origem
$total = &criar_linha_naruto($linha_pg[15],$linha_pg[17],$linha_pg[11],@tags);
print $total."\n";
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$linha_pg[6],$total);
@cookie = &sugar_cookie_naruto2('./auto_col_arquivos/col_caminhos.eafc',$linha_pg[0],$linha_pg[4],$linha_pg[11],$pagina[1],$total);
&sugar_nome_naruto('./auto_col_arquivos/col_caminhos.eafc',$linha_pg[0],$linha_pg[4],$linha_pg[10]);
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$linha_pg[2],'1');
}#fim se
@mensagem = &mod_cookie($linha_g,$linha_p);
return @mensagem;
}

sub r_tempo {
my $linha_g = shift || '';
my $linha_p = shift || '';
my @mensagem;
my @linha_pg;
@linha_pg = &ler_status('./auto_arquivos/metodo.eafc');
if ($linha_pg[0] eq 'post') {
@linha_pg = &dividir_get($linha_p);
}elsif ($linha_pg[0] eq 'get') {
@linha_pg = &dividir_get($linha_g);
}else {
die "erro no get ou post\n";
}
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$linha_pg[2],'1');
@mensagem = &mod_tempo($linha_g,$linha_p);
return @mensagem;
}

sub r_dados {
my $linha_g = shift || '';
my $linha_p = shift || '';
my $total;
my @mensagem;
my @cookie;
my @pagina = &ler_config('5','./auto_col_arquivos/endereco.eafc','pagina0','pagina1','pagina2','pagina3','pagina4');
my @c_nome = ('c1_nome','c2_nome','c3_nome','c4_nome','c5_nome','c6_nome','c7_nome','c8_nome','c9_nome','c10_nome','c11_nome','c12_nome','c13_nome','c14_nome','c15_nome','c16_nome','c17_nome','c18_nome','c19_nome','c20_nome','c21_nome','c22_nome','c23_nome','c24_nome','c25_nome','c26_nome','c27_nome','c28_nome','c29_nome','c30_nome','c31_nome','c32_nome','c33_nome','c34_nome','c35_nome','c36_nome','c37_nome','c38_nome','c39_nome','c40_nome');
my @c_cookie = ('c1_cookie','c2_cookie','c3_cookie','c4_cookie','c5_cookie','c6_cookie','c7_cookie','c8_cookie','c9_cookie','c10_cookie','c11_cookie','c12_cookie','c13_cookie','c14_cookie','c15_cookie','c16_cookie','c17_cookie','c18_cookie','c19_cookie','c20_cookie','c21_cookie','c22_cookie','c23_cookie','c24_cookie','c25_cookie','c26_cookie','c27_cookie','c28_cookie','c29_cookie','c30_cookie','c31_cookie','c32_cookie','c33_cookie','c34_cookie','c35_cookie','c36_cookie','c37_cookie','c38_cookie','c39_cookie','c40_cookie');
my @c_form = ('c1_form','c2_form','c3_form','c4_form','c5_form','c6_form','c7_form','c8_form','c9_form','c10_form','c11_form','c12_form','c13_form','c14_form','c15_form','c16_form','c17_form','c18_form','c19_form','c20_form','c21_form','c22_form','c23_form','c24_form','c25_form','c26_form','c27_form','c28_form','c29_form','c30_form','c31_form','c32_form','c33_form','c34_form','c35_form','c36_form','c37_form','c38_form','c39_form','c40_form');
my @c_linha = ('c1_linha','c2_linha','c3_linha','c4_linha','c5_linha','c6_linha','c7_linha','c8_linha','c9_linha','c10_linha','c11_linha','c12_linha','c13_linha','c14_linha','c15_linha','c16_linha','c17_linha','c18_linha','c19_linha','c20_linha','c21_linha','c22_linha','c23_linha','c24_linha','c25_linha','c26_linha','c27_linha','c28_linha','c29_linha','c30_linha','c31_linha','c32_linha','c33_linha','c34_linha','c35_linha','c36_linha','c37_linha','c38_linha','c39_linha','c40_linha');
my @c_tempo = ('c1_tempo','c2_tempo','c3_tempo','c4_tempo','c5_tempo','c6_tempo','c7_tempo','c8_tempo','c9_tempo','c10_tempo','c11_tempo','c12_tempo','c13_tempo','c14_tempo','c15_tempo','c16_tempo','c17_tempo','c18_tempo','c19_tempo','c20_tempo','c21_tempo','c22_tempo','c23_tempo','c24_tempo','c25_tempo','c26_tempo','c27_tempo','c28_tempo','c29_tempo','c30_tempo','c31_tempo','c32_tempo','c33_tempo','c34_tempo','c35_tempo','c36_tempo','c37_tempo','c38_tempo','c39_tempo','c40_tempo');
my @c_origem = ('c1_origem','c2_origem','c3_origem','c4_origem','c5_origem','c6_origem','c7_origem','c8_origem','c9_origem','c10_origem','c11_origem','c12_origem','c13_origem','c14_origem','c15_origem','c16_origem','c17_origem','c18_origem','c19_origem','c20_origem','c21_origem','c22_origem','c23_origem','c24_origem','c25_origem','c26_origem','c27_origem','c28_origem','c29_origem','c30_origem','c31_origem','c32_origem','c33_origem','c34_origem','c35_origem','c36_origem','c37_origem','c38_origem','c39_origem','c40_origem');
my @origem = &ler_config('40','./auto_col_arquivos/col_caminhos.eafc','c1_origem','c2_origem','c3_origem','c4_origem','c5_origem','c6_origem','c7_origem','c8_origem','c9_origem','c10_origem','c11_origem','c12_origem','c13_origem','c14_origem','c15_origem','c16_origem','c17_origem','c18_origem','c19_origem','c20_origem','c21_origem','c22_origem','c23_origem','c24_origem','c25_origem','c26_origem','c27_origem','c28_origem','c29_origem','c30_origem','c31_origem','c32_origem','c33_origem','c34_origem','c35_origem','c36_origem','c37_origem','c38_origem','c39_origem','c40_origem');
my @login = &ler_config('40','./auto_col_arquivos/col_caminhos.eafc','c1_login','c2_login','c3_login','c4_login','c5_login','c6_login','c7_login','c8_login','c9_login','c10_login','c11_login','c12_login','c13_login','c14_login','c15_login','c16_login','c17_login','c18_login','c19_login','c20_login','c21_login','c22_login','c23_login','c24_login','c25_login','c26_login','c27_login','c28_login','c29_login','c30_login','c31_login','c32_login','c33_login','c34_login','c35_login','c36_login','c37_login','c38_login','c39_login','c40_login');
my @senha = &ler_config('40','./auto_col_arquivos/col_caminhos.eafc','c1_senha','c2_senha','c3_senha','c4_senha','c5_senha','c6_senha','c7_senha','c8_senha','c9_senha','c10_senha','c11_senha','c12_senha','c13_senha','c14_senha','c15_senha','c16_senha','c17_senha','c18_senha','c19_senha','c20_senha','c21_senha','c22_senha','c23_senha','c24_senha','c25_senha','c26_senha','c27_senha','c28_senha','c29_senha','c30_senha','c31_senha','c32_senha','c33_senha','c34_senha','c35_senha','c36_senha','c37_senha','c38_senha','c39_senha','c40_senha');
my @atual;
my @tags;
	for ($b=1; $b<=5; $b++){
@cookie = &sugar_cookie_naruto('./auto_col_arquivos/col_caminhos.eafc',$c_nome[$b],$c_cookie[$b],$pagina[0],$pagina[1],'');
####c_nome,c_cookie,c_origem
@cookie = &ler_config('3','./auto_col_arquivos/col_caminhos.eafc',$c_nome[$b],$c_cookie[$b],$c_origem[$b]);
@atual = &sugar_form($pagina[0],$cookie[0],$c_cookie[$b],'','./auto_col_arquivos/col_caminhos.eafc');
if ($atual[0]) {
	@tags = &garimpar_tag('0','2','input','name','value',$atual[0]);
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_form[$b],$atual[0]);
##login,senha,origem
$total = &criar_linha_naruto($login[$b],$senha[$b],$origem[$b],@tags);
print $total."\n";
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_linha[$b],$total);
@cookie = &sugar_cookie_naruto2('./auto_col_arquivos/col_caminhos.eafc',$c_nome[$b],$c_cookie[$b],$origem[$b],$pagina[1],$total);
&sugar_nome_naruto('./auto_col_arquivos/col_caminhos.eafc',$c_nome[$b],$c_cookie[$b],$c_origem[$b]);
&gravar_config('1','./auto_col_arquivos/col_caminhos.eafc',$c_tempo[$b],'1');
}#fim se
	}#fim for
@mensagem = &mod_dados($linha_g,$linha_p);
return @mensagem;
}

sub r_resto {
my $linha_g = shift || '';
my $linha_p = shift || '';
my $total;
my $fixo = 7;
my @mensagem;
my @pagina = &ler_config('5','./auto_col_arquivos/endereco.eafc','pagina0','pagina1','pagina2','pagina3','pagina4');
my @c_nome = ('c1_nome','c2_nome','c3_nome','c4_nome','c5_nome','c6_nome','c7_nome','c8_nome','c9_nome','c10_nome','c11_nome','c12_nome','c13_nome','c14_nome','c15_nome','c16_nome','c17_nome','c18_nome','c19_nome','c20_nome','c21_nome','c22_nome','c23_nome','c24_nome','c25_nome','c26_nome','c27_nome','c28_nome','c29_nome','c30_nome','c31_nome','c32_nome','c33_nome','c34_nome','c35_nome','c36_nome','c37_nome','c38_nome','c39_nome','c40_nome');
my @c_cookie = ('c1_cookie','c2_cookie','c3_cookie','c4_cookie','c5_cookie','c6_cookie','c7_cookie','c8_cookie','c9_cookie','c10_cookie','c11_cookie','c12_cookie','c13_cookie','c14_cookie','c15_cookie','c16_cookie','c17_cookie','c18_cookie','c19_cookie','c20_cookie','c21_cookie','c22_cookie','c23_cookie','c24_cookie','c25_cookie','c26_cookie','c27_cookie','c28_cookie','c29_cookie','c30_cookie','c31_cookie','c32_cookie','c33_cookie','c34_cookie','c35_cookie','c36_cookie','c37_cookie','c38_cookie','c39_cookie','c40_cookie');
my @origem = &ler_config('40','./auto_col_arquivos/col_caminhos.eafc','c1_origem','c2_origem','c3_origem','c4_origem','c5_origem','c6_origem','c7_origem','c8_origem','c9_origem','c10_origem','c11_origem','c12_origem','c13_origem','c14_origem','c15_origem','c16_origem','c17_origem','c18_origem','c19_origem','c20_origem','c21_origem','c22_origem','c23_origem','c24_origem','c25_origem','c26_origem','c27_origem','c28_origem','c29_origem','c30_origem','c31_origem','c32_origem','c33_origem','c34_origem','c35_origem','c36_origem','c37_origem','c38_origem','c39_origem','c40_origem');
my @atual;
#######################################################################################################
######grandev
&quartel_sub($origem[0],$c_nome[0],$c_cookie[0],$fixo);
######odemo
&quartel_sub($origem[1],$c_nome[1],$c_cookie[1],$fixo);
######bneves
&quartel_sub($origem[2],$c_nome[2],$c_cookie[2],$fixo);
######salesiano
&quartel_sub($origem[3],$c_nome[3],$c_cookie[3],$fixo);
######britoes
&quartel_sub($origem[4],$c_nome[4],$c_cookie[4],$fixo);
######ronda
&quartel_sub($origem[5],$c_nome[5],$c_cookie[5],$fixo);
######castelo
##&quartel_sub($origem[6],$c_nome[6],$c_cookie[6],$fixo);
######melis
&quartel_sub($origem[7],$c_nome[7],$c_cookie[7],$fixo);
######jabuti
&quartel_sub($origem[8],$c_nome[8],$c_cookie[8],$fixo);
#####################################clava
######limonada
&quartel_sub($origem[10],$c_nome[10],$c_cookie[10],$fixo);
######jarofa
&quartel_sub($origem[11],$c_nome[11],$c_cookie[11],$fixo);
######sfantastico
&quartel_sub($origem[12],$c_nome[12],$c_cookie[12],$fixo);
######maran
&quartel_sub($origem[13],$c_nome[13],$c_cookie[13],$fixo);
##########################################souzi
######gmar
&quartel_sub($origem[15],$c_nome[15],$c_cookie[15],$fixo);
######nico1
&quartel_sub($origem[16],$c_nome[16],$c_cookie[16],$fixo);
######dodo9
&quartel_sub($origem[17],$c_nome[17],$c_cookie[17],$fixo);
######carro
&quartel_sub($origem[18],$c_nome[18],$c_cookie[18],$fixo);
######memel
&quartel_sub($origem[19],$c_nome[19],$c_cookie[19],$fixo);
#######################################################################################################
@mensagem = &mod_resto($linha_g,$linha_p);
return @mensagem;
}

sub r_colonia {
my $linha_g = shift || '';
my $linha_p = shift || '';
&gravar_status('./auto_arquivos/col.eafc','1');
my @mensagem;
@mensagem = &mod_colonia_off($linha_g,$linha_p);
return @mensagem;
}

sub r_descolonia {
my $linha_g = shift || '';
my $linha_p = shift || '';
&gravar_status('./auto_arquivos/col.eafc','0');
my @mensagem;
@mensagem = &mod_colonia_on($linha_g,$linha_p);
return @mensagem;
}

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

sub r_forms {
my $linha_g = shift || '';
my $linha_p = shift || '';
my $i;
my @parte;
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
&gravar_config('2','./auto_arquivos/caminhos.eafc',$linha_pg[0],$linha_pg[1],$linha_pg[2],$linha_pg[3]);
	@parte = &extrair_host($linha_pg[1]);
	@linha_pg = &sugar_form($parte[0],$parte[1],$linha_pg[2],'','./auto_arquivos/caminhos.eafc');
@mensagem = ();
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina retornar forms','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
$linha_p = @linha_pg;
	for ($i=0; $i<$linha_p; $i++){
#push(@mensagem,&abrir_div_g('formula2'));
#push(@mensagem,$linha_pg[$i]);
#push(@mensagem,&fechar_div('formula2'));
	@parte = &garimpar_tag('1','1','form','action',$linha_pg[$i]);
	push(@mensagem,&array_html('1','form action',@parte));
	@parte = &garimpar_tag('1','1','form','name',$linha_pg[$i]);
	push(@mensagem,&array_html('1','form name',@parte));
	@parte = &garimpar_tag('1','2','input','name','type',$linha_pg[$i]);
	push(@mensagem,&array_html('2','nome','tipo',@parte));
	@parte = &garimpar_tag('0','2','input','name','value',$linha_pg[$i]);
	push(@mensagem,&array_html('2','nome','valor',@parte));
	@parte = &garimpar_tag('1','1','select','name',$linha_pg[$i]);
	push(@mensagem,&array_html('1','select name',@parte));
	@parte = &garimpar_tag('1','1','textarea','name',$linha_pg[$i]);
	push(@mensagem,&array_html('1','textarea name',@parte));
	push(@mensagem,&dividir_br());
	}#fim for
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
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

sub r_opcoes {
my $linha_g = shift || '';
my $linha_p = shift || '';
my $conectar;
my @parte;
my @linha_pg;
my @mensagem;
my @nome = &ler_config('12','./auto_col_arquivos/col_caminhos.eafc','c1_nome','c2_nome','c3_nome','c4_nome','c5_nome','c6_nome','c7_nome','c8_nome','c9_nome','c10_nome','c11_nome','c12_nome');
@linha_pg = &ler_status('./auto_arquivos/metodo.eafc');
if ($linha_pg[0] eq 'post') {
@linha_pg = &dividir_get($linha_p);
}elsif ($linha_pg[0] eq 'get') {
@linha_pg = &dividir_get($linha_g);
}else {
die "erro no get ou post\n";
}
&gravar_config('1','./auto_arquivos/caminhos.eafc',$linha_pg[0],$linha_pg[1]);
	@parte = &extrair_host($linha_pg[1]);
	@linha_pg = &mod_solicitar($parte[0],$parte[1],$linha_pg[3],'');
$conectar = &cliente_pagina($parte[0],'80',@linha_pg);
if ($conectar){
	@mensagem = &ler_status('./auto_arquivos/ultima.eafc');
	if ($mensagem[0]){
	&gravar_config('1','./auto_arquivos/caminhos.eafc',$linha_pg[2],$mensagem[0]);
	}#fim se
@linha_pg = &garimpar_tag('1','2','area','title','href');
}else{
@linha_pg = 'n&#227;o foi possível conectar ou pagina n&#227;o existe';
}#fim se conectar
@mensagem = ();
push(@mensagem,&abrir_html());
push(@mensagem,&abrir_div_g('formula1'));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&rotulo_html('pagina retornar op&#231;&#245;es','mostrar5'));
push(@mensagem,&dividir_hr());
push(@mensagem,&dividir_br());
push(@mensagem,&array_html('1','referencia',@linha_pg));
push(@mensagem,&dividir_br());
push(@mensagem,&dividir_hr());
push(@mensagem,&menu_web());
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

1;

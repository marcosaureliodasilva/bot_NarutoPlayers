## criado por marcos aurelio em 20/03/2009
## projeto para Escola Agrotecnica Federal do Crato - Curso Técnico de Informática

use strict;

sub recarga_js {
my @pausa = &ler_config('2','./auto_arquivos/config.eafc','t_reload','p_reload');
my $mensagem = '<script type="text/javascript">
recarga('.$pausa[0].');
function recarga(temp){
tempo=parseFloat(temp);
if (tempo > 0){
setTimeout("recarga(tempo)",1000);
window.status=tempo;
tempo--;
}else{
document.location.href="'.$pausa[1].'";
}
}//xxxxxxxxxxxxxxxxxxx
</script>';
return $mensagem;
}

sub recarga_processo {
my $davez = shift;
my @pausa = (1,$davez);
my $mensagem = '<script type="text/javascript">
recarga('.$pausa[0].');
function recarga(temp){
tempo=parseFloat(temp);
if (tempo > 0){
setTimeout("recarga(tempo)",1000);
window.status=tempo;
tempo--;
}else{
document.location.href="'.$pausa[1].'";
}
}//xxxxxxxxxxxxxxxxxxx
</script>';
return $mensagem;
}

sub css_html {
my $mensagem = '<style type="text/css">
<!--
* {
margin:0;
padding:0;
margin-left:auto;
margin-right:auto;
}
body#pag_web {
background-color:#ffffff;
text-align:center;
}
div.mostrar3 {
font-family:Arial, Helvetica, sans-serif; 
font-size:12pt; 
color:#3333cc;
}
div.mostrar4 {
font-family:Arial, Helvetica, sans-serif; 
font-size:14pt; 
color:#33cccc;
}
div.mostrar5 {
font-family:Arial, Helvetica, sans-serif; 
font-size:16pt; 
color:#3300cc;
}
div.mostrar5a {
font-family:Arial, Helvetica, sans-serif; 
font-size:16pt; 
color:#ff0000;
}
div.mostrar6 {
font-family:Arial, Helvetica, sans-serif; 
font-size:24pt; 
color:#ff0000;
}
div.formula1 {
clear:both;
margin-left:auto;
margin-right:auto;
width:750px; 
height:auto;
}
div.formula2 {
clear:left;
float:left;
padding-top:30px;
padding-bottom:30px;
width:100%; 
height:auto;
background-color:#cccccc; 
border:2pt solid black;
}
-->
</style>';
return $mensagem;
}

1;

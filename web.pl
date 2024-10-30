#!/usr/bin/perl -w

use warnings;
use strict;

require './biblio_arquivos/web_pagina.pl';
require './biblio_arquivos/web_pagina_ext.pl';
require './biblio_arquivos/web_servidor.pl';
require './biblio_arquivos/web_cliente.pl';
require './biblio_arquivos/web_arquivo.pl';
require './col_arquivos/web_outros.pl';
require './col_arquivos/web_col.pl';
require './col_arquivos/web_col_ext.pl';
require './col_arquivos/web_naruto.pl';
require './css_arquivos/web_css.pl';

&gravar_status('./auto_arquivos/col.eafc','0');
&gravar_status('./auto_col_arquivos/tcampos.eafc','1');
&gravar_status('./auto_arquivos/processo.eafc','1');
&servidor_pagina();

exit();

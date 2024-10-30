// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
function iniciar(){
anunci="mande-nos um e-mail com sugestões ou críticas para -> marco-zero@ig.com.br";
compri=anunci.length;
nespaco=compri-1;
posi=1;
comeco=0;
//letreiro();
todos_cores();
tipos=locatipo_nume(0,0);
if (tipos=="text" || tipos=="password"){
focar_nume(0,0);
}
}//xxxxxxxxxxxxxxxxxxx
function letreiro(){
espaco="";
for (rec=1;rec<=nespaco;rec++){
espaco=espaco+" ";
}//para
letrado=espaco+anunci.substring(comeco,posi);
window.status=letrado;
if (posi<compri){
posi++;
}//se
nespaco--;
if (nespaco<=0){
comeco++;
}//se
if (comeco==compri){
nespaco=compri-1;
posi=1;
comeco=0;
}//se
setTimeout("letreiro()",150)
}//xxxxxxxxxxxxxxxxxxx
function pegadia(isto){
data= new Date();
var nudata= data.getDate();
if (nudata < 10) {
nudata= "0"+nudata;
}
isto.value= nudata;
}//xxxxxxxxxxxxxxxxxxx
function pegames(isto){
data= new Date();
var nudata= data.getMonth()+1;
if (nudata < 10) {
nudata= "0"+nudata;
}
isto.value= nudata;
}//xxxxxxxxxxxxxxxxxxx
function pegaano(isto){
data= new Date();
isto.value= data.getFullYear();
}//xxxxxxxxxxxxxxxxxxx
function voltar(){
history.back();
}//xxxxxxxxxxxxxxxxxxx
function voltar_p(caminho){
self.location.href=caminho;
}//xxxxxxxxxxxxxxxxxxx
function autoc_nume(formu,elemento){
var contar=document.forms[formu];
if (contar!=undefined) {
contar=document.forms[formu].elements[elemento];
if (contar!=undefined) {
document.forms[formu].elements[elemento].click();
}
}
}//xxxxxxxxxxxxxxxxxxx
function relato(formu,elemento){
var caminho=document.getElementById(elemento).value;
document.getElementById(formu).action=caminho;
}//xxxxxxxxxxxxxxxxxxx
function focar_nume(formu,elemento) {
var contar=document.forms[formu];
if (contar!=undefined) {
contar=document.forms[formu].elements[elemento];
if (contar!=undefined) {
document.forms[formu].elements[elemento].focus();
}
}
}//xxxxxxxxxxxxxxxxxxx
function locatipo_nume(formu,elemento){
var contar=document.forms[formu];
if (contar!=undefined) {
contar=document.forms[formu].elements[elemento];
if (contar!=undefined) {
var tipo=document.forms[formu].elements[elemento].type;
return tipo;
}
}
}//xxxxxxxxxxxxxxxxxxx
function locatipo_nome(elemento){
var tipo = document.getElementById(elemento).type;
return tipo;
}//xxxxxxxxxxxxxxxxxxx
function locavalo_nome(elemento){
var tipo = document.getElementById(elemento).value;
return tipo;
}//xxxxxxxxxxxxxxxxxxx
function v_cpf(elemento,isto){
var valido=isto.value;
if (vali_cpf(valido)==true && valido!=""){
document.getElementById(elemento).value="";
}
else{
document.getElementById(elemento).value=" CPF ERRADO";
}
}//xxxxxxxxxxxxxxxxxxx
function v_cnpj(elemento,isto){
var valido=isto.value;
if (vali_cnpj(valido)==true && valido!=""){
document.getElementById(elemento).value="";
}
else{
document.getElementById(elemento).value=" CNPJ ERRADO";
}
}//xxxxxxxxxxxxxxxxxxx
function v_data(elemento,isto){
var valido=isto.value;
if (vali_data(valido)==true){
document.getElementById(elemento).value="";
}
else{
document.getElementById(elemento).value="DATA ERRADA";
}
}//xxxxxxxxxxxxxxxxxxx
function Dvcpf(strCpf){
	var peso=11;
	var soma=0;
	if(strCpf.length==9)
	{
		peso=10;
	}
	for(i=0; i<strCpf.length; i++)
	{
		soma += parseInt(strCpf.substring(i,i+1)) * (peso--);
	}
	// resto divisao por 11
	soma = soma % 11;
	if(soma<2)
	{
		soma=0;
	}
	else
	{
		soma = 11 - soma;
	}
	return soma;
}//xxxxxxxxxxxxxxxxxxx
function Dvcnpj(strCnpj){
	var peso=6;
	var soma=0;
	if(strCnpj.length==12)
	{
		peso=5;
	}
	for(i=0; i<strCnpj.length; i++)
	{
		soma += parseInt(strCnpj.substring(i,i+1)) * (peso--);
	if (peso == 1){
		peso=9;
	}
	}
	// resto divisao por 11
	soma = soma % 11;
	if(soma<2)
	{
		soma=0;
	}
	else
	{
		soma = 11 - soma;
	}
	return soma;
}//xxxxxxxxxxxxxxxxxxx
function vali_cpf(strCpf)
{
	var cpfSemDigito = strCpf.substring(0,strCpf.length-2);
	var dv1Cpf = strCpf.substring(strCpf.length-2,strCpf.length-1);
	var dv2Cpf = strCpf.substring(strCpf.length-1,strCpf.length);
	var dv1 = Dvcpf(cpfSemDigito);
	var dv2 = Dvcpf(cpfSemDigito+""+dv1);
	if(dv1Cpf==dv1 && dv2Cpf==dv2)
	{
		return true;
	}
	else
	{
		return false;
	}
}//xxxxxxxxxxxxxxxxxxx
function vali_cnpj(strCnpj)
{
	var cnpjSemDigito = strCnpj.substring(0,strCnpj.length-2);
	var dv1Cnpj = strCnpj.substring(strCnpj.length-2,strCnpj.length-1);
	var dv2Cnpj = strCnpj.substring(strCnpj.length-1,strCnpj.length);
	var dv1 = Dvcnpj(cnpjSemDigito);
	var dv2 = Dvcnpj(cnpjSemDigito+""+dv1);
	if(dv1Cnpj==dv1 && dv2Cnpj==dv2)
	{
		return true;
	}
	else
	{
		return false;
	}
}//xxxxxxxxxxxxxxxxxxx
function vali_dia(ndata)
{
	var ndia = ndata.substring(0,2);
	if(ndia<=31)
	{
		return true;
	}
	else
	{
		return false;
	}
}//xxxxxxxxxxxxxxxxxxx
function vali_mes(ndata)
{
	var nmes = ndata.substring(0,2);
	if(nmes<=12)
	{
		return true;
	}
	else
	{
		return false;
	}
}//xxxxxxxxxxxxxxxxxxx
function vali_ano(ndata)
{
	var nano = ndata.substring(0,4);
	if(nano>=1900 && nano<=2090)
	{
		return true;
	}
	else
	{
		return false;
	}
}//xxxxxxxxxxxxxxxxxxx
function mudacor(formu,elemento){
var contar=document.forms[formu];
if (contar!=undefined) {
contar=document.forms[formu].elements[elemento];
if (contar!=undefined) {
var tipo=document.forms[formu].elements[elemento].type;
return tipo;
}
}
}//xxxxxxxxxxxxxxxxxxx

function fundo_cores(elemento,cor){
document.getElementById(elemento).style.backgroundColor=cor;
}//xxxxxxxxxxxxxxxxxxx
function campo_cores(elemento,cor){
var tipo = locatipo_nome(elemento);
var valor = locavalo_nome(elemento);
if (tipo=="text" && valor=="nada"){
fundo_cores(elemento,cor);
}
}//xxxxxxxxxxxxxxxxxxx
function todos_cores(){
campo_cores("c1_nome","#ff7700");
campo_cores("c2_nome","#ff7700");
campo_cores("c3_nome","#ff7700");
campo_cores("c4_nome","#ff7700");
campo_cores("c5_nome","#ff7700");
campo_cores("c6_nome","#ff7700");
campo_cores("c7_nome","#ff7700");
campo_cores("c8_nome","#ff7700");
campo_cores("c9_nome","#ff7700");
campo_cores("c10_nome","#ff7700");
campo_cores("c11_nome","#ff7700");
campo_cores("c12_nome","#ff7700");
campo_cores("c13_nome","#ff7700");
campo_cores("c14_nome","#ff7700");
campo_cores("c15_nome","#ff7700");
campo_cores("c16_nome","#ff7700");
campo_cores("c17_nome","#ff7700");
campo_cores("c18_nome","#ff7700");
campo_cores("c19_nome","#ff7700");
campo_cores("c20_nome","#ff7700");
campo_cores("c21_nome","#ff7700");
campo_cores("c22_nome","#ff7700");
campo_cores("c23_nome","#ff7700");
campo_cores("c24_nome","#ff7700");
campo_cores("c25_nome","#ff7700");
campo_cores("c26_nome","#ff7700");
campo_cores("c27_nome","#ff7700");
campo_cores("c28_nome","#ff7700");
campo_cores("c29_nome","#ff7700");
campo_cores("c30_nome","#ff7700");
campo_cores("c31_nome","#ff7700");
campo_cores("c32_nome","#ff7700");
campo_cores("c33_nome","#ff7700");
campo_cores("c34_nome","#ff7700");
campo_cores("c35_nome","#ff7700");
campo_cores("c36_nome","#ff7700");
campo_cores("c37_nome","#ff7700");
campo_cores("c38_nome","#ff7700");
campo_cores("c39_nome","#ff7700");
campo_cores("c40_nome","#ff7700");
}//xxxxxxxxxxxxxxxxxxx

#!/bin/bash
# Fabio S. Schmidt <fabio@improve.inf.br>
# Script para SemalessRPD conforme publicado em http://respirandolinux.wordpress.com/2012/02/20/executar-aplicacoes-windows-atraves-de-seamless-rpd/
#Altere as variáveis conforme o seu ambiente, no script o executável do RDESKTOP está em /usr/local/bin/rdesktop, o servidor remoto possui IP #192.168.70.43, o usuário para conexão é REMOTO e a senha 123456. No lado do Windows, o aplicativo foi descompactado no diretório c:\seamlessrdp.

#Variaveis
BIN=”/usr/local/bin/rdesktop”
HOST=”192.168.70.43″
USUARIO=”remoto”
SENHA=”123456″
KEYMAP=”pt-br”
SOCKETRDP=”$HOME/.rdesktop/seamless.socket”;
SHELLRDP=”C:\seamlessrdp\seamlessrdpshell.exe”

#Exigir argumento, aplicativo windows que deve ser executado
#ex.: notepad, calc, “c:\arquivos de programas\internet explorer\iexplore.exe”
if [ -z "$1" ]
then
echo “Utilize $0 <aplicativo>”
exit
fi

#Controlar sessoes rpd
#Utiliza o compartilhamento de conexoes que permite executar varias aplicacoes
#ou varias sessoes da mesma simultaneamente
processosrdp=`pgrep -U $USER -x rdesktop | wc -l`;
#se nao existir nenhuma sessao inicia a conexao rpd master
if [ $processosrdp -eq 0 ]
then
$BIN -A -s “$SHELLRDP $1″ $HOST -u $USUARIO -p $SENHA -k $KEYMAP
# se existir alguma sessao utiliza o compartilhamento de conexao
else
$BIN -M $SOCKETRDP -l “$1″
fi

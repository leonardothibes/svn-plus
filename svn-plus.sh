#!/bin/bash

VERSION=0.1.0
COMMAND=help
SVN=/usr/bin/svn

if [ ! -f ${SVN} ]; then
	echo "Comando \"svn\" não encontrado!"
	exit 1
fi

if [ ! -z $1 ]; then
	COMMAND=$1
fi

##
# Controla o fluxo do app.
# 
# @param $1 Ação a ser executada[tag|branch]
# @param $2 Nome da tag/branch
# @param $3 Flag de deleçao
## 
controller()
{
	ACTION=$1
	NAME=$2
	REMOVE=$3

	if [[ ${ACTION} != 'tag' && ${ACTION} != 'branch' ]]; then
		echo "Ação inválida: ${ACTION}"
		exit 1
	fi

	if [ -z ${NAME} ]; then
		list ${ACTION}
		exit 0
	fi
}

##
# Extrai a URL do repositório do retorno do svn-info
# 
# @param $1 Define se é tag ou branch
##
url()
{
	svn info

	# if [ $1 == 'tag']; then

	# echo "http://svn.local"
} 

##
# Lista tags ou branches
# 
# @param $1 Define se é tag ou branch
## 
list()
{
	URL=$(url $1)

	echo "svn ls ${URL}"
}

##
# Exibe a mensagem de HELP.
##
help()
{
	echo "Ferramenta de gerenciamento de TAGS e BRANCHES do Subversion (${VERSION})"
	echo "Uso: svn-plus [tag|branch] [options]"
	echo ""
	echo "Subcomandos disponíveis:"
	echo ""
	echo "  tag:"
	echo "    tag (sem algumentos)              Lista todas as tags"
	echo "    tag [nome-da-tag]                 Cria uma nova tag"
	echo "    tag [nome-da-tag] --remove        Remove uma tag"
	echo ""
	echo "  branch:"
	echo "    branch (sem algumentos)           Lista todos os branchs"
	echo "    branch [nome-do-branch]           Cria um novo branch"
	echo "    branch [nome-do-branch] --remove  Remove um branch"
	echo ""
	echo "Para informações adicionais, veja https://bitbucket.org/lidercap/svn-plus/"
}

eval controller ${COMMAND} $2 $3
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

	# Determinando ação
	if [[ ${ACTION} != 'tag' && ${ACTION} != 'branch' ]]; then
		echo "Ação inválida: ${ACTION}"
		exit 1
	fi
	# Determinando ação

	# Listando
	if [ -z ${NAME} ]; then
		list ${ACTION}
		exit 0
	fi
	# Listando
	
	# Criando
	if [ -z ${REMOVE} ]; then
		create ${ACTION} ${NAME}
		exit 0
	fi
	# Criando
	
	# Removendo
	if [[ ! -z ${REMOVE} && ${REMOVE} == '--remove' ]]; then
		remove ${ACTION} ${NAME}
		exit 0
	fi
	# Removendo
	
	# Deu ruim
	echo "Arguments inválidos!"
	exit 1
	# Deu ruim
}

##
# Extrai a URL do repositório do retorno do svn-info
# 
# @param $1 Define se é tag ou branch
# @return String
##
url()
{
	URL=$(svn info | grep 'URL: http' | sed -e 's/URL:\ //g')
	REL=$(svn info | grep 'Relative URL:' | sed -e 's/Relative URL: ^//g')
	URL=$(echo ${URL} | sed -e "s,${REL},,g")

	if [ $1 == 'tag' ]; then
		URL=${URL}/tags
	else
		URL=${URL}/branches
	fi

	echo ${URL}
} 

##
# Lista tags ou branches
# 
# @param $1 Define se é tag ou branch
## 
list()
{
	URL=$(url $1)
	svn ls ${URL} | sed -e 's,/,,g'
}

##
# Cria tags ou branches
# 
# @param $1 Define se é tag ou branch
# @param $2 Nome da tag ou branch a ser criada.
##
create()
{
	echo "Criando $1 $2"
}

##
# Deleta tags ou branches
# 
# @param $1 Define se é tag ou branch
# @param $2 Nome da tag ou branch a ser deletada.
##
remove()
{
	echo "Deletando $1 $2"
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
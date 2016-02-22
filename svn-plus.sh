#!/bin/bash

VERSION=0.3.0
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
# @param $3 Flag de remoção
##
controller()
{
	ACTION=$1
	NAME=$2
	REMOVE=$3

	# Determinando ação
	if [[
        ${ACTION} != 'tag' &&
        ${ACTION} != 'branch' &&
        ${ACTION} != 'switch' &&
        ${ACTION} != 'merge' &&
        ${ACTION} != 'help'
    ]]; then
		echo "Ação inválida: ${ACTION}"
		exit 1
	fi
	# Determinando ação

    # Help
    if [ ${ACTION} == 'help' ]; then
        help
        exit 0
    fi
    # Help

    # Switch
    if [ ${ACTION} == 'switch' ]; then
        switch ${NAME}
        exit 0
    fi
    # Switch

    # Merge
    if [ ${ACTION} == 'merge' ]; then
        merge ${NAME}
        exit 0
    fi
    # Merge

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

	if [ ! -z $1 ]; then
		if [ $1 == 'tag' ]; then
			URL=${URL}/tags
		else
			URL=${URL}/branches
		fi
	fi

	echo ${URL}
}

##
# Extrai da URL do repositório o nome do branch atual.
#
# @return String
##
branch()
{
    echo $(svn info | grep 'Relative URL:' | sed -e 's/Relative URL: ^//g' | sed -e "s,/,,g")
}

##
# Lista tags ou branches
#
# @param $1 Define se é tag ou branch
##
list()
{
    if [ ${1} == 'branch' ]; then
        echo '[ BRANCHES ]'
    else
        echo '[ TAGS ]'
    fi

	URL=$(url $1)
	svn ls ${URL} | sed -e 's,/,,g' | sort -V

    if [ ${1} == 'branch' ]; then
        echo 'trunk'
        CURRENT=$(branch branch)
        echo "[ current: ${CURRENT} ]" | sed -e 's/branches//g'
    fi
}

##
# Cria tags ou branches
#
# @param $1 Define se é tag ou branch
# @param $2 Nome da tag ou branch a ser criada.
##
create()
{
	TRUNK=$(url)/trunk
	BRANCH=$(url $1)/${2}

	svn copy ${TRUNK} ${BRANCH}
}

##
# Deleta tags ou branches
#
# @param $1 Define se é tag ou branch
# @param $2 Nome da tag ou branch a ser deletada.
##
remove()
{
	BRANCH=$(url $1)/${2}
	svn rm ${BRANCH}
}

##
# Altera o branch corrente
#
# @param $1 Nome do branch
##
switch()
{
    if [ -z $1 ]; then
        echo 'Informe um branch para mudar!'
        exit 1
    fi

    URL=$(url branch)/$1
    if [ $1 == 'trunk' ]; then
        URL=$(url)/trunk
    fi

    svn switch ${URL}
}

##
# Merge de um branch com o branch corrente.
#
# @param $1 Nome do branch de origem do código.
##
merge()
{
    if [ -z $1 ]; then
        echo 'Informe um branch para fazer merge!'
        exit 1
    fi

    URL=$(url branch)/$1
    if [ $1 == 'trunk' ]; then
        URL=$(url)/trunk
    fi

    svn merge --reintegrate ${URL} .
}

##
# Exibe a mensagem de HELP.
##
help()
{
    clear
	echo "Ferramenta de gerenciamento de TAGS e BRANCHES do Subversion (${VERSION})"
	echo "Uso: svn-plus [subcommand] [options]"
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
    echo "  switch:"
    echo "    switch [nome-do-branch]           Altera o branch corrente"
    echo ""
    echo "  merge:"
    echo "    merge [nome-do-branch]           Merge de branches"
    echo ""
    echo "  help:"
	echo "    Exibe esta mensagem de help"
    echo ""
	echo "Para mais informações, visite https://bitbucket.org/lidercap/svn-plus/"
}

eval controller ${COMMAND} $2 $3

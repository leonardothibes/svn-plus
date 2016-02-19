#!/bin/bash

VERSION=0.1.0

BOLD=\033[1m
ENDBOLD=\033[0m

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

help
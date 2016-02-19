SVN TAG
=======

Utilitário para suprir a deficiência como a qual o Subversion lida com *tags* e *branches*.

TAGS
----

##### Listando as tags

```
svn-plus tag
```

##### Criando uma tag

```
svn-plus tag [nome-da-tag]
```

##### Deletando uma tag

```
svn-plus tag [nome-da-tag] --remove
```

BRANCHES
--------

##### Listando os branches

```
svn-plus branch
```

##### Criando um branch

```
svn-plus branch [nome-da-branch]
```

##### Deletando um branch

```
svn-plus branch [nome-da-branch] --remove
```

Observações Gerais
------------------

 * Todos os comandos devem ser executados na raiz do projeto que se quer controlar.
 * O script herda a autenticação do ambiente.

Responsáveis técnicos
---------------------

 * **Fernando Villaça <fvillaca@lidercap.com.br>**
 * **Leonardo Thibes  <lthibes@lidercap.com.br>**

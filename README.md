SVN TAG
=======

Utilitário para suprir a deficiência com do Subversion em lidar com *tags* e *branches*.

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

##### Mudando de branch

```
svn-plus switch [nome-da-branch]
```

##### Merge de branches

```
svn-plus merge [nome-da-branch]
```

Observações Gerais
------------------

 * Todos os comandos devem ser executados na raiz do projeto que se quer controlar.
 * O script herda a autenticação do ambiente.

Responsáveis técnicos
---------------------

 * **Leonardo Thibes  <lthibes@lidercap.com.br>**

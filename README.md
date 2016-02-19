SVN TAG
=======

Utilitário para suprir a deficiência como a qual o Subversion lida com *tags* e *branches*.

TAGS
----

Todos os comandos devem ser executados na raiz do projeto que se quer controlar.

##### Listando as tags

```
svn-tag list
```

##### Criando uma tag

```
svn-tag [nome-da-tag]
```

##### Deletando uma tag

```
svn-tag [nome-da-tag] --remove
```

Observações Gerais
------------------

 * O script herda a autenticação do ambiente.

Responsáveis técnicos
---------------------

 * **Fernando Villaça <fvillaca@lidercap.com.br>**
 * **Leonardo Thibes  <lthibes@lidercap.com.br>**

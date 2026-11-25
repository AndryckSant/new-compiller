# Trabalho P1 - Compiladores

Este repositório destina-se ao trabalho da disciplina de Compiladores. A solução consiste na especificação e implementação de um analisador léxico e sintático para uma linguagem fictícia.


## Objetivo

Especificar uma linguagem fictícia e implementar seus analisadores léxico e sintático utilizando, respectivamente, JFlex e CUP.

Os analisadores deverão ser executados sobre arquivos-fonte da linguagem criada. A entrega deve conter:

1. Especificação da gramática em BNF ou BNF estendida;
2. Arquivo de especificação do JFlex;
3. Arquivo de especificação do CUP;
4. Três códigos-fonte corretos;
5. Três códigos-fonte contendo erros de sintaxe.

## Características da linguagem

A linguagem deverá possuir os seguintes elementos:

- Tipos de dados:
  - inteiro;
  - real;
  - caracter;
  - string.
- Declaração de variáveis;
- Atribuição de variáveis;
- Expressões aritméticas;
- Expressões lógicas;
- Identificadores de início e fim de bloco de comandos;
- Comandos:
  - `printf`;
  - `scanf`;
  - `if else`;
  - `for`;
  - `while`.

As regras da linguagem devem ser documentadas em uma gramática formal escrita em BNF ou BNF estendida.

## Analisador léxico

O analisador léxico deverá ser especificado com JFlex. Deve reconhecer, entre outros, os seguintes elementos da linguagem:

- palavras reservadas;
- identificadores;
- tipos de dados;
- números inteiros e reais;
- literais caracter e string;
- operadores aritméticos e lógicos;
- operadores de atribuição e relacionais;
- delimitadores de blocos;
- separadores e pontuação.

## Analisador sintático

O analisador sintático deverá ser especificado com CUP e deve verificar se os arquivos-fonte respeitam a gramática definida.

Para os códigos com erros de sintaxe, devem ser exibidas mensagens específicas sempre que possível, incluindo o número da linha em que o erro foi detectado no arquivo-fonte.

## Casos de teste

### Códigos corretos

Preparar três arquivos-fonte válidos, com uma cobertura representativa das funcionalidades da linguagem, como declarações, atribuições, expressões aritméticas e lógicas e comandos de controle de fluxo.

### Códigos com erros

Preparar três arquivos-fonte contendo erros de sintaxe. Os casos devem permitir a demonstração de mensagens de erro específicas e da identificação da linha do erro.

Exemplos de situações a serem testadas:

- falta de ponto e vírgula;
- ausência de parênteses ou chaves;
- atribuição ou declaração mal formada;
- uso incorreto de `if`, `for` ou `while`;
- expressão incompleta.
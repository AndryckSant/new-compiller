# Trabalho P1 - Compiladores

Este repositorio contem a especificacao e a implementacao de um analisador
lexico e sintatico para a linguagem ficticia Zimbro.

## Objetivo

Especificar as regras formais da linguagem Zimbro e implementar os analisadores
responsaveis por reconhecer e validar seus programas-fonte.

O projeto utiliza JFlex para a analise lexica e CUP para a analise sintatica.

## Documentacao

- [Especificacao formal da linguagem Zimbro](Docs/Linguagem-Zimbro.md)

## Arquivos principais

- `zimbro.flex`: especificacao do analisador lexico;
- `zimbro.cup`: especificacao da gramatica sintatica;
- `src/`: analisadores gerados em Java;
- `Examples/`: exemplos validos e arquivos contendo erros.

## Entrega

A entrega contem:

1. a especificacao da gramatica em BNF;
2. o arquivo de especificacao JFlex;
3. o arquivo de especificacao CUP;
4. tres codigos-fonte validos;
5. tres codigos-fonte com erros lexicos ou sintaticos.

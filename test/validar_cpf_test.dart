// 1 - escreva o teste antes
// 2 - codifique somente o necessário para cobrir o teste
// 3 - não escreva mais testes antes de codificar

import 'package:app_veterinaria/entidade/pedido.dart';
import 'package:app_veterinaria/entidade/validar_cpf.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String cpf = "";
  var validarCpf = ValidarCPF();
  test('CPF não pode ser vazio',
      () => {expect(() => validarCpf.ehVazio(cpf), throwsException)});

  cpf = "48.794.848.90";
  test(
      'CPF cant be bigger than 14 characters',
      () => {
            expect(() => validarCpf.isCPFvalidAsQuantityOfNubers(cpf),
                throwsException)
          });

  cpf = "1.486.794.848.90";

  test('CPF need an valid format',
      () => expect(() => validarCpf.isCorrectFormat(cpf), throwsException));

  test('CPF sem mascara e sem dígito deve possuir 9 caracteres', () {
    String cpf = '123.456.789-99';
    var validarCPF = ValidarCPF();
    List<int> listaNumeroCpf = validarCpf.gerarListaNumero(cpf);
    expect(listaNumeroCpf.length, 9);
  });

  test('Validar se o primeiro numero digitado é valido', () {
    var validarCpf = ValidarCPF();
    expect(validarCpf.validateFirstDigit('48679484890'), throwsException);
  });

  test('Varifica que o segundo numero é valido', () {
    String cpf = '48679484890';
    () => expect(() => validarCpf.validateSecondDigit(cpf), throwsException);
  });

  test('verify that cant create order with invalid cpf', () {
    () => expect(() => Pedido(CPF: '111'), throwsException);
  });

  // test('verify that can create an order with 3 itens', () {
  //   var pedido = Pedido(CPF: '264.310.820-52');

  //   pedido.addIten(nomeProduto: "coca-cola", quantidade: 2, precoUnidade: 6.5);
  //   pedido.addIten(nomeProduto: "fanta", quantidade: 1, precoUnidade: 6);
  //   pedido.addIten(nomeProduto: "chokito", quantidade: 2, precoUnidade: 6.5);
  //   expect(pedido.contarItem(), 3);
  // });
}

//CLEAN CODE TECHNIQUES
// 1. Keep It Simple
// 2. Understand Your Code
// 3. Comments Are Your New Best Friends
// 4. Don’t Repeat Yourself (DRY)
// 5. Indent Your Code
// 6. Naming Convention
// 7. Explore
// 8. Use Your Brain
// 9. Test Runs
// 10. Practice Your Art


//https://www.codingdojo.com/blog/clean-code-techniques

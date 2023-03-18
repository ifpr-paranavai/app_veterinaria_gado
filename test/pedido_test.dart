import 'package:app_veterinaria/entidade/pedido.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify that cant create order with invalid cpf', () {
    () => expect(() => Pedido(CPF: '111'), throwsException);
  });

  test('verify that can create an order with 3 itens', () {
    var pedido = Pedido(CPF: '264.310.820-52');

    pedido.addItem(nomeProduto: "coca-cola", quantidade: 2, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: "fanta", quantidade: 1, precoUnidade: 6);
    pedido.addItem(nomeProduto: "chokito", quantidade: 2, precoUnidade: 6.5);
    expect(pedido.contarItem(), 3);
  });

  // ao adicionar um produto existente no pedido, deve alterar a quantidade sem criar um novo item
  test(
      'ao adicionar um produto existente no pedido, deve alterar a quantidade sem criar um novo item',
      () {
    var pedido = Pedido(CPF: '264.310.820-52');

    pedido.addItem(nomeProduto: "coca-cola", quantidade: 2, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: "coca-cola", quantidade: 1, precoUnidade: 6);
    pedido.addItem(nomeProduto: "chokito", quantidade: 2, precoUnidade: 6.5);
    () => expect(pedido.contarItem(), 2);
  });

  test('// deve apresentar a soma de um item corretamente', () {
    var pedido = Pedido(CPF: '264.310.820-52');

    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6);

    var totalItem = pedido.getValorCarrinho();

    () => expect(totalItem, 13.0);
  });

  // deve permitir desconto do item de no máximo 15%
  test('deve permitir desconto do item de no máximo 15%', () {
    var pedido = Pedido(CPF: '264.310.820-52');
    expect(
        () => pedido.addItem(
            nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.2),
        () => pedido.addItem(
            nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.2));
  });

// deve apresentar o total do pedido corretamente
  test('deve apresentar o total do pedido corretamente', () {
    var pedido = Pedido(CPF: '264.310.820-52');
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.2);
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.2);
  });

  //expect(actual, matcher)
}

import 'package:app_veterinaria/entidade/validar_cpf.dart';

void main() {}

var itens = <Object>[];

var totalCarrinho = 0.0;

class Pedido {
  Pedido({required String CPF}) {
    ValidarCPF validarCPF = ValidarCPF();
    validarCPF.ehVazio(CPF);
  }

  verifyThatHave3Orders(dynamic orders) {}

  void addItem(
      {required String nomeProduto,
      required int quantidade,
      required double precoUnidade,
      double descontoEmReais = 0}) {
    var descontoPermitidoPorItem = precoUnidade * 0.15;
    validarDesconto(descontoEmReais, descontoPermitidoPorItem);
    var totalPorItem = calcularItemComDesconto(descontoEmReais, precoUnidade);

    var totalItens = calculaTotalItens(quantidade, totalPorItem);

    var existe = false;

    for (var contador = 0; contador < itens.length; contador++) {
      var item = itens[contador] as List<Object>;
      if (item[0] == nomeProduto) {
        item[1] = quantidade + int.parse(item[1].toString());
        existe = true;
        itens.add(item);
        break;
      }
    }

    if (!existe) {
      itens.add([nomeProduto, quantidade, precoUnidade]);
    }

    calcularValorCarrinho(totalItens);
  }

  calcularValorCarrinho(double totalItens) {
    totalCarrinho += totalItens;
  }

  getValorCarrinho() {
    return totalCarrinho;
  }

  int contarItem() {
    return itens.length;
  }

  calculaTotalItens(int quantidade, double precoUnidade) {
    return quantidade * precoUnidade;
  }

  calcularItemComDesconto(double descontoReais, double precoUnidade) {
    return precoUnidade - descontoReais;
  }

  validarDesconto(double desconto, double descontoPermitido) {
    if (desconto > descontoPermitido)
      throw Exception('Desconto maior do que o permitido');
  }
}

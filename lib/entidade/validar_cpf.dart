class ValidarCPF {
  bool ehVazio(String cpf) {
    if (cpf.isEmpty) throw Exception('CPF não pode ser vazio');
    return true;
  }

  bool isCPFvalidAsQuantityOfNubers(String cpf) {
    if (cpf.length != 14)
      throw Exception('CPF cant be begger than 14 characters');
    return true;
  }

  bool isCorrectFormat(String cpf) {
    var regExp = RegExp(r'\d{3}\.\d{3}.\d{3}\-\d{2}');
    if (!regExp.hasMatch(cpf))
      throw Exception('CPF need an valid format like ###.###.###-##');
    return true;
  }

  List<int> gerarListaNumero(String cpf) {
    ehVazio(cpf);
    cpf = cpf.replaceAll('.', '').replaceAll('-', '');
    cpf = cpf.substring(0, 9);
    List<int> listaNumeros =
        cpf.split('').map<int>((e) => int.parse(e)).toList();
    return listaNumeros;
  }

  bool validateFirstDigit(String cpf) {
    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (i + 1);
    }
    int validatorDigit = (soma % 11) % 10;

    if (validatorDigit != int.parse(cpf[9])) {
      throw Exception("primerio numero invalido");
    }
    return true;
  }

  bool validateSecondDigit(String cpf) {
    int soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * i;
    }
    int validatorDigit = (soma % 11) % 10;
    if (validatorDigit != int.parse(cpf[10]))
      throw Exception("Segundo numero invalido");

    return true;
  }

  bool isValidCNPJ(String cnpj) {
    // Remove any non-numeric characters from the input
    cnpj = cnpj.replaceAll(RegExp(r'[^\d]'), '');

    if (cnpj.length != 14) {
      return false;
    }

    var sum = 0;
    for (var i = 0; i < 12; i++) {
      sum += int.parse(cnpj[i]) * (5 - i % 4);
    }
    var firstVerificationDigit = (sum % 11 < 2) ? 0 : (11 - sum % 11);

    sum = 0;
    for (var i = 0; i < 13; i++) {
      sum += int.parse(cnpj[i]) * (6 - i % 5);
    }
    var secondVerificationDigit = (sum % 11 < 2) ? 0 : (11 - sum % 11);

    // Check the verification digits against the
    return (int.parse(cnpj[12]) == firstVerificationDigit &&
        int.parse(cnpj[13]) == secondVerificationDigit);
  }
}

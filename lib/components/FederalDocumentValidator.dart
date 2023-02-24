class FederalDocumentValidator {
  String cpfValidator(String document) {
    var temp,
        temp2,
        temp3,
        temp4,
        temp5,
        temp6,
        temp7,
        temp8,
        temp9,
        temp10,
        temp11,
        temp12,
        temp13,
        temp14,
        temp15;

    temp = document.replaceAll('.', '');
    temp2 = temp.replaceAll('-', '');
    temp3 = temp2.split('');

    temp4 = true;
    for (int c = 0; c < temp3.length - 1; c++) {
      if (temp3[c] == temp3[c + 1]) {
        temp4 = false;
      } else {
        temp4 = true;
        break;
      }
    }
    if (!temp4) {
      return 'Documento invalido';
    } else {
      temp5 = temp2.substring(0, 9).split('').map(int.parse).toList();
      temp6 = 0;
      temp7 = 10;
      temp8 = 0;
      for (var n in temp5) {
        temp8 = temp7 * n + temp8;
        temp7--;
      }
      temp9 = 11 - (temp8 % 11);
      if (temp9 > 9) {
        temp9 = 0;
      } else {
        temp9 = temp9;
      }
      temp10 = int.parse(document.substring(12, 13));
      if (temp9 != temp10) {
        return 'Documento invalido';
      } else {
        temp11 = temp2.substring(0, 10).split('').map(int.parse).toList();
        temp12 = 11;
        temp13 = 0;
        for (var n in temp11) {
          temp13 = temp12 * n + temp13;
          temp12--;
        }
        temp14 = 11 - (temp13 % 11);
        if (temp14 > 9) {
          temp14 = 0;
        } else {
          temp14 = temp14;
        }
        temp15 = int.parse(document.substring(13, 14));
        if (temp14 != temp15) return 'Documento invalido';

        return 'validado';
      }
    }
  }

  String lenghtValidator(String documente) {
    if (documente.length == 14) {
      return cpfValidator(formatValidator(documente));
    } else if (documente.length == 18) {
      return formatValidatorCNPJ(documente);
    } else
      return 'Documento inválido';
  }

  String formatValidator(String documente) {
    if (!documente.contains('.')) return 'Documento sem pontos';

    if (!documente.contains('-')) return 'Documento sem traço';

    return documente;
  }

  String formatValidatorCNPJ(String documente) {
    formatValidator(documente);

    if (!documente.contains('/')) return 'Documento inválido';

    return documente;
  }

  String validatorNumberCpf(String document) {
    cpfValidator(document);

    return document;
  }
}

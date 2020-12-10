void main() {
  List<String> pacientes = [
    'Rodrigo Rahman|35',
    'Guilheme Rahman|10',
    'João Rahman|20',
    'Joaquin Rahman|25',
    'Luan Rahman|23'
  ];

  //exercicio4(pacientes);
  // print("Exercício 5:");
  // exercicio5(pacientes);
  // print("Exercício 6:");
  exercicio6(pacientes);
}

void exercicio4(List<String> values) {
  for (String item in values) {
    var value = item.split("|");

    print("${value[0]} tem ${value[1]}");
  }
}

void exercicio5(List<String> values) {
  values.removeRange(values.length - 2, values.length);

  for (String item in values) {
    var value = item.split("|");

    print("${value[0]} tem ${value[1]}");
  }
}

void exercicio6(List<String> values) {

  values.removeWhere((item) => int.parse(item.split("|")[1]) < 17);

  for (String item in values) {
    var value = item.split("|");

    print("${value[0]} tem ${value[1]}");
  }
}

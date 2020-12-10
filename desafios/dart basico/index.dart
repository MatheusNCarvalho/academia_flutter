void main() {
  var pacientes = [
    'Rodrigo Rahman|35|desenvolvedor|SP',
    'Manoel Silva|12|estudante|MG',
    'Joaquim Rahman|18|estudante|SP',
    'Fernando Verne|35|estudante|MG',
    'Gustavo Silva|40|estudante|MG',
    'Sandra Silva|40|estudante|MG',
    'Regina Verne|35|estudante|MG',
    'João Rahman|55|Jornalista|SP',
  ];

  pacientes.removeWhere((item) => int.parse(item.split("|")[1]) < 20);

  Map<String, List<String>> resultados = {};

  pacientes.forEach((item) {
    var sobrenome = item.split("|")[0].split(" ")[1];

    if (!resultados.containsKey(sobrenome)) {
      var valores =
          pacientes.where((item) => item.contains(sobrenome)).toList();
      resultados[sobrenome] = valores;
    }
  });

  resultados.forEach((key, value) {
    if (key.isEmpty) {
      return;
    }
    print("Familia ${key}: ");
    for (var item in value) {
      var informacoes = item.split("|");

      print(
        "${informacoes[0]}, Idade: ${informacoes[1]}, Profissão: ${informacoes[2]}, Estado: ${informacoes[3]}",
      );
    }
  });
}

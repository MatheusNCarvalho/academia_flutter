void main() {
  var pessoas = [
    'Rodrigo Rahman|35|Masculino',
    'Jose|56|Masculino',
    'Joaquim|84|Masculino',
    'Rodrigo Rahman|35|Masculino',
    'Maria|88|Feminino',
    'Helena|24|Feminino',
    'Leonardo|5|Masculino',
    'Laura Maria|29|Feminino',
    'Joaquim|72|Masculino',
    'Helena|24|Feminino',
    'Guilherme|15|Masculino',
    'Manuela|85|Masculino',
    'Leonardo|5|Masculino',
    'Helena|24|Feminino',
    'Laura|29|Feminino',
  ];

  print("Baseado na lista acima.");
  print("");

  pessoas = exercio1(pessoas);
  exercio2(pessoas);
  exercio3(pessoas);
  exercio4(pessoas);
}

List<String> exercio1(List<String> pessoas) {
  var items = pessoas.toList();
  print("1 - Remover os duplicados");

  Set<String> pessoasNaoDuplicadas = Set<String>();
  items.forEach((value) {
    pessoasNaoDuplicadas.add(value);
  });

  print(pessoasNaoDuplicadas);
  print("");
  return pessoasNaoDuplicadas.toList();
}

void exercio2(List<String> pessoas) {
  var items = pessoas.toList();
  print("2 - Me mostre a quantidade de pessoas do sexo Masculino e Feminino");

  var quantidadeMasculina =
      filtrarListaDePessoasPorSexo(items, 'Masculino').length;
  var quantidadeFeminino =
      filtrarListaDePessoasPorSexo(items, 'Feminino').length;
  var messagem =
      'Existem ${quantidadeMasculina} pessoas do sexo Mascuino e $quantidadeFeminino do sexo Feminino';

  print(messagem);

  print("");
}

void exercio3(List<String> pessoas) {
  var items = pessoas.toList();
  print("3 - Filtrar e deixar a lista somente com pessoas maiores de 18 anos");
  items.removeWhere((item) => int.parse(item.split("|")[1]) < 18);
  print(items);

  print("");
  print(
      "3.1 - Mostre a quantidade de pessoas com mais de 18 anos também separado por sexo");
  var quantidadeMasculina =
      filtrarListaDePessoasPorSexo(items, 'Masculino').length;
  var quantidadeFeminino =
      filtrarListaDePessoasPorSexo(items, 'Feminino').length;
  var messagem =
      'Existem ${quantidadeMasculina} pessoas do sexo Mascuino e $quantidadeFeminino do sexo Feminino, maiores de 18 anos';

  print(messagem);

  print("");
}

void exercio4(List<String> pessoas) {
  print("4 - Encontre a pessoa mais velha.");
  pessoas.sort((primeiro, segundo) {
    var idadeRegistroUm = int.parse(primeiro.split("|")[1]);
    var idadeRegistroDois = int.parse(segundo.split("|")[1]);

    return idadeRegistroDois.compareTo(idadeRegistroUm);
  });
  print(pessoas.first);
}

List<String> filtrarListaDePessoasPorSexo(List<String> pessoas, String sexo) {
  return pessoas.where((item) => montarFuncaoPorSexo(item, sexo)).toList();
}

bool montarFuncaoPorSexo(String item, String sexo) {
  return item.split('|')[2].toLowerCase() == sexo.toLowerCase();
}

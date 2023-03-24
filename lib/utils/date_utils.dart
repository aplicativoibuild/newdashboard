bool isToday(DateTime b) {
  DateTime a = DateTime.now();
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

bool isYesterday(DateTime b) {
  DateTime a = DateTime.now().add(Duration(days: -1));
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

String formatData(DateTime data) {
  return '${semana[data.weekday - 1]}, ${data.day.toString().padLeft(2, "0")} de ${meses[data.month - 1]} ';
}

String formatDuration(Duration dt) {
  return '${dt.inMinutes.toString().padLeft(2, "0")}:${dt.inSeconds.toString().padLeft(2, "0")}';
}

String formatDataPadrao(DateTime data) {
  return '${data.day.toString().padLeft(2, "0")}/${data.month.toString().padLeft(2, "0")}/${data.year.toString().padLeft(4, "0")}';
}

String formatDataProxima(DateTime data) {
  if (isToday(data)) return 'Hoje';
  if (isYesterday(data)) return 'Ontem';
  if (DateTime.now().difference(data).inDays < 7)
    return semana[data.weekday - 1];
  return ' ${data.day.toString().padLeft(2, "0")}/${data.month.toString().padLeft(2, "0")} ';
}

String formatHora(DateTime dt) {
  return '${dt.hour.toString().padLeft(2, "0")}:${dt.minute.toString().padLeft(2, "0")}';
}

DateTime onlyDate(DateTime dt) {
  return DateTime(dt.year, dt.month, dt.day);
}

List<String> meses = [
  "Janeiro",
  "Fevereiro",
  "Março",
  "Abril",
  "Maio",
  "Junho",
  "Julho",
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro",
];

List<String> semana = [
  "Segunda",
  "Terça",
  "Quarta",
  "Quinta",
  "Sexta",
  "Sábado",
  "Domingo",
];

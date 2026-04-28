import '../../features/measurement/domain/entities/measurement.dart';

class WeeklyTriple {
  final DateTime weekStart;
  final double min;
  final double avg;
  final double max;
  final int count;

  const WeeklyTriple({
    required this.weekStart,
    required this.min,
    required this.avg,
    required this.max,
    required this.count,
  });
}

class WeeklyBloodPressureSummary {
  final DateTime weekStart;
  final double systolicMin;
  final double systolicAvg;
  final double systolicMax;
  final double diastolicMin;
  final double diastolicAvg;
  final double diastolicMax;
  final int count;

  const WeeklyBloodPressureSummary({
    required this.weekStart,
    required this.systolicMin,
    required this.systolicAvg,
    required this.systolicMax,
    required this.diastolicMin,
    required this.diastolicAvg,
    required this.diastolicMax,
    required this.count,
  });
}

DateTime _weekStartOf(DateTime dt) {
  final day = DateTime(dt.year, dt.month, dt.day);
  return day.subtract(Duration(days: day.weekday - 1));
}

List<WeeklyTriple> weeklySugarAggregates(List<Measurement> list) {
  final grouped = <DateTime, List<double>>{};
  for (final m in list) {
    final weekStart = _weekStartOf(m.dateTime);
    grouped.putIfAbsent(weekStart, () => <double>[]).add(m.value1);
  }

  final weeks = grouped.keys.toList()..sort((a, b) => a.compareTo(b));
  return weeks.map((weekStart) {
    final values = grouped[weekStart]!;
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final avg = values.reduce((a, b) => a + b) / values.length;
    return WeeklyTriple(
      weekStart: weekStart,
      min: min,
      avg: avg,
      max: max,
      count: values.length,
    );
  }).toList();
}

List<WeeklyBloodPressureSummary> weeklyBloodPressureAggregates(
  List<Measurement> list,
) {
  final grouped = <DateTime, List<Measurement>>{};
  for (final m in list) {
    final weekStart = _weekStartOf(m.dateTime);
    grouped.putIfAbsent(weekStart, () => <Measurement>[]).add(m);
  }

  final weeks = grouped.keys.toList()..sort((a, b) => a.compareTo(b));
  return weeks.map((weekStart) {
    final items = grouped[weekStart]!;
    final sys = items.map((e) => e.value1).toList();
    final dia = items.map((e) => e.value2 ?? 0).toList();

    final sysMin = sys.reduce((a, b) => a < b ? a : b);
    final sysMax = sys.reduce((a, b) => a > b ? a : b);
    final diaMin = dia.reduce((a, b) => a < b ? a : b);
    final diaMax = dia.reduce((a, b) => a > b ? a : b);

    return WeeklyBloodPressureSummary(
      weekStart: weekStart,
      systolicMin: sysMin,
      systolicAvg: sys.reduce((a, b) => a + b) / sys.length,
      systolicMax: sysMax,
      diastolicMin: diaMin,
      diastolicAvg: dia.reduce((a, b) => a + b) / dia.length,
      diastolicMax: diaMax,
      count: items.length,
    );
  }).toList();
}

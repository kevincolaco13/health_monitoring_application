import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CreateGraph extends StatelessWidget {
  final String name;
  final double value;
  final String range;
  final List effects;
  final List prevention;

  const CreateGraph({
    Key? key,
    required this.value,
    required this.range,
    required this.name,
    required this.effects,
    required this.prevention,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List highOrLowList = getHighorLow(value, range);
    String highOrLow = highOrLowList[0];
    double rangeGraph = highOrLowList[1];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 400,
            child: SfCartesianChart(
              title: ChartTitle(text: name),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: <ColumnSeries<MedicalAttribute, String>>[
                ColumnSeries<MedicalAttribute, String>(
                  dataSource: <MedicalAttribute>[
                    MedicalAttribute('Current $name', value),
                    MedicalAttribute('Normal $name', rangeGraph),
                  ],
                  xValueMapper: (MedicalAttribute level, _) => level.attribute,
                  yValueMapper: (MedicalAttribute level, _) => level.level,
                )
              ],
            ),
          ),
          const SizedBox(height: 26),
          Text(
            '$highOrLow $name can lead to',
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView(
            shrinkWrap: true,
            children: effects
                .map((item) => ListTile(
                      title: Text(item),
                      leading: const Icon(Icons.arrow_circle_right_outlined),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Prevention',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView(
            shrinkWrap: true,
            children: prevention
                .map((item) => ListTile(
                      title: Text(item),
                      leading: const Icon(Icons.arrow_circle_right_outlined),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class MedicalAttribute {
  final String attribute;
  final double level;

  MedicalAttribute(this.attribute, this.level);
}

List getHighorLow(value, range) {
  List<String> rangeValues = range.split(" ");
  double lowerRange = double.parse(rangeValues[0]);
  double higherRange = double.parse(rangeValues[1]);

  if (value < lowerRange) {
    return ["Low", lowerRange];
  } else if (value > higherRange) {
    return ["High", higherRange];
  } else {
    return ["", 0];
  }
}

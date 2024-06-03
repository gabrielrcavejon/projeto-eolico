import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/energia_controller.dart';
import '../model/energia_model.dart';

class GraficoVolts extends StatefulWidget {
  const GraficoVolts({super.key, required this.title});

  final String title;

  @override
  GraficoVoltsState createState() => GraficoVoltsState();
}

class GraficoVoltsState extends State<GraficoVolts> {
  List<Energia> chartData = [Energia(segundos: 0, volts: 0, flagLigado: true)];

  @override
  void initState() {
    startGraph();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
        ),
        series: <LineSeries<Energia, int>>[
          LineSeries<Energia, int>(
            animationDuration: 200,
            dataSource: chartData,
            color:
                chartData.last.flagLigado == true ? Colors.amber : Colors.red,
            xValueMapper: (Energia energia, _) => energia.segundos,
            yValueMapper: (Energia energia, _) => energia.volts,
          ),
        ],
        primaryXAxis: const NumericAxis(
          autoScrollingDelta: 20,
          autoScrollingMode: AutoScrollingMode.end,
          majorGridLines: MajorGridLines(width: 1),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          title: AxisTitle(text: 'Tempo (Segundos)'),
        ),
        primaryYAxis: const NumericAxis(
          axisLine: AxisLine(width: 1),
          majorTickLines: MajorTickLines(size: 0),
          title: AxisTitle(text: 'Quantidade de volts'),
        ),
      ),
    );
  }

  Future<void> updateDataSource(Timer timer) async {
    int tempo = timer.tick;
    Energia energia = Energia(flagLigado: true);
    final energ = await fetchEnergiaTempoReal();
    energia = Energia(
      segundos: tempo,
      volts: energ.flagLigado == true ? energ.volts : 0.0,
      flagLigado: energ.flagLigado,
    );
    setState(() {
      chartData.add(energia);
    });
  }

  Future<void> startGraph() async {
    int segundos = 1;
    List<Energia> energList = await fetchEnergiaInicio();
    setState(() {
      for (var element in energList) {
        element.segundos = segundos;
        element.flagLigado = true;
        segundos++;
      }
      chartData = energList;
    });
  }
}

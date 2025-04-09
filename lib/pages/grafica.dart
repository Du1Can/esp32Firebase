import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../datatype/data.dart';

enum FilterType { temperatura, humedad }

class Grafica extends StatefulWidget {
  @override
  _MyGrafica createState() {
    return _MyGrafica();
  }
}

class _MyGrafica extends State<Grafica> {
  List<Data> valores = <Data>[];
  FilterType tipoDeFiltro = FilterType.temperatura;
  DateTime fechInicio = DateTime.now().subtract(Duration(days: 1));
  DateTime fechFin = DateTime.now();

  late TextEditingController controllerInicio;
  late TextEditingController controllerFin;

  @override
  void initState() {
    super.initState();
    controllerInicio = TextEditingController(text: "${fechInicio.toLocal()}".split(' ')[0]);
    controllerFin = TextEditingController(text: "${fechFin.toLocal()}".split(' ')[0]);
    getDatos();
  }

  Future<void> getDatos() async {
    DateTime inicioCompleto = DateTime(fechInicio.year, fechInicio.month, fechInicio.day, 0, 0, 0);
    DateTime finCompleto = DateTime(fechFin.year, fechFin.month, fechFin.day, 23, 59, 59);

    try {
      var snapshots = await FirebaseFirestore.instance
          .collection('variablesTH')
          .where('fecha', isGreaterThanOrEqualTo: inicioCompleto)
          .where('fecha', isLessThanOrEqualTo: finCompleto)
          .orderBy('fecha', descending: false)
          .get();

      print("Documentos encontrados: ${snapshots.docs.length}");

      List<Data> dataList = snapshots.docs.map((e) {
        Map<String, dynamic> map = e.data();
        Timestamp timestamp = map['fecha'];
        DateTime fecha = timestamp.toDate();
        double value = tipoDeFiltro == FilterType.temperatura
            ? map['temperatura']?.toDouble() ?? 0
            : map['humedad']?.toDouble() ?? 0;

        return Data(fecha, value, value);
      }).toList();

      setState(() {
        valores = dataList;
      });

      if (dataList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No hay datos en el rango seleccionado")),
        );
      }
    } catch (e) {
      print("Error al obtener datos: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar datos")),
      );
    }
  }


  Future<void> selecFecha(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? fechInicio : fechFin,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          fechInicio = pickedDate;
          controllerInicio.text = "${fechInicio.toLocal()}".split(' ')[0];
        } else {
          fechFin = pickedDate;
          controllerFin.text = "${fechFin.toLocal()}".split(' ')[0];
        }
      });
      await getDatos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Gráfico de Línea'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selecFecha(context, true);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Fecha Inicio",
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(color: Colors.black),
                        controller: controllerInicio,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => selecFecha(context, false),
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Fecha Final",
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(color: Colors.black),
                        controller: controllerFin,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.green),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<FilterType>(
                    value: tipoDeFiltro,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(height: 2, color: Colors.black),
                    onChanged: (FilterType? newValue) {
                      setState(() {
                        tipoDeFiltro = newValue!;
                      });
                      getDatos();
                    },
                    items: const <DropdownMenuItem<FilterType>>[
                      DropdownMenuItem(
                        value: FilterType.humedad,
                        child: Row(
                          children: [
                            Icon(Icons.water_drop, color: Colors.blue),
                            SizedBox(width: 8),
                            Text("Humedad", style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: FilterType.temperatura,
                        child: Row(
                          children: [
                            Icon(Icons.thermostat, color: Colors.orange),
                            SizedBox(width: 8),
                            Text("Temperatura", style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Gráfico o mensaje vacío
            valores.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('No hay datos disponibles',
                    style: TextStyle(color: Colors.grey)),
              ),
            )
                : Expanded(
              child: SfCartesianChart(
                backgroundColor: Colors.white,
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: NumericAxis(),
                legend: Legend(isVisible: true, textStyle: TextStyle(color: Colors.black)),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<Data, DateTime>>[
                  LineSeries<Data, DateTime>(
                    dataSource: valores,
                    xValueMapper: (Data d, _) => d.fecha,
                    yValueMapper: (Data d, _) => d.temperatura,
                    name: tipoDeFiltro == FilterType.temperatura ? 'Temperatura' : 'Humedad',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    color: tipoDeFiltro == FilterType.temperatura
                        ? Colors.orangeAccent
                        : Colors.lightBlueAccent,
                    width: 3,
                    markerSettings: MarkerSettings(isVisible: true, color: Colors.green),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
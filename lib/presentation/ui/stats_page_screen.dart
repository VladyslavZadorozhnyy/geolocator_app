import 'package:flutter/material.dart';

import 'package:charts_flutter_new/flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/location_action.dart';
import '../qubits/history_cubit.dart';
import 'abs_page_screen.dart';

class StatsPageScreen extends AbsPageScreen {
  const StatsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, List<LocationAction>?>(
      builder: (context, state) {
        if (state == null) {
          context.read<HistoryCubit>().requestLocationsHistory();
          return buildLoadingScreen(context);
        } else if (state.isEmpty) {
          return buildEmptyScreen(context);
        }

        Map<int, int> groupedState = {};
        for (var element in state) {
          if (!groupedState.keys.contains(element.timeConsumed)) {
            groupedState[element.timeConsumed] = 1;
          } else {
            groupedState[element.timeConsumed] = (groupedState[element.timeConsumed]! + 1);
          }
        }

        List<Series<MapEntry<int, int>, String>> series = [
          Series(
              id: "-",
              data: groupedState.entries.toList(),
              domainFn: (MapEntry<int, int> series, _) => "${series.key}",
              measureFn: (MapEntry<int, int> series, _) => series.value,
              colorFn: (MapEntry<int, int> series, _) => Color.fromHex(code: '#008080')
          ),
        ];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              'Needed time (ms) for calls graph',
              style: defaultTextStyle,
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: BarChart(
                series,
                animate: true,
              ),
            )
          ],
        );
      },
    );
  }
}
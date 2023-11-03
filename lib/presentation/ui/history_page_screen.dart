import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_locator_app/domain/entities/location_action.dart';
import 'package:geo_locator_app/presentation/qubits/history_cubit.dart';

import 'abs_page_screen.dart';

class HistoryPageScreen extends AbsPageScreen {
  const HistoryPageScreen({super.key});

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

        return SizedBox(
          width: 200,
          height: 200,
          child: ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                      "${state[index].timeConsumed}ms "
                          "| lat: ${state[index].value?.latitude} "
                          "| lon: ${state[index].value?.longitude}"
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
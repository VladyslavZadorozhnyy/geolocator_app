import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_locator_app/domain/entities/location_action.dart';
import 'package:geo_locator_app/presentation/qubits/history_cubit.dart';
import 'package:geo_locator_app/presentation/qubits/states/location_state.dart';
import 'package:geo_locator_app/presentation/ui/abs_page_screen.dart';

import '../qubits/location_qubit.dart';
import '../qubits/states/abs_state.dart';

class HomePageScreen extends AbsPageScreen {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState<LocationAction>>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return buildLoadingScreen(context);
          case Status.failed:
            return _buildSuccessScreen(context, state, state.errorMessage);
          case Status.success:
            String message = 'Longitude:\n'
                '${state.data?.value?.longitude ?? "-"}\n'
                'Latitude:\n'
                '${state.data?.value?.latitude ?? "-"}\n'
                'Time consumed:\n'
                '${state.data?.timeConsumed.toDouble() ?? "-"} ms';
            return _buildSuccessScreen(context, state, message);
          default:
            String message = "Push button to receive data";
            return _buildSuccessScreen(context, state, message);
        }
      },
    );
  }

  Widget _buildSuccessScreen(BuildContext context, LocationState state, String message) {
    Size screenSize = MediaQuery.of(context).size;
    context.read<HistoryCubit>().requestLocationsHistory();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height * 0.65,
          color: Colors.yellow,
          child: Center(
              child: Text(
                message,
                style: defaultTextStyle,
            ),
          ),
        ),
        const SizedBox(
          width: double.infinity,
          height: 10,
        ),
        MaterialButton(
          color: Colors.teal,
          height: 60,
          minWidth: 200,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          onPressed: () async { await context.read<LocationCubit>().requestLocation(); },
          child: Text(
            'Retrieve location',
            style: defaultTextStyle,
          ),
        ),
      ],
    );
  }
}
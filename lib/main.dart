import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_locator_app/presentation/qubits/history_cubit.dart';
import 'package:geo_locator_app/presentation/qubits/location_qubit.dart';
import 'package:geo_locator_app/presentation/ui/history_page_screen.dart';
import 'package:geo_locator_app/presentation/ui/stats_page_screen.dart';
import 'package:geo_locator_app/presentation/ui/home_page_screen.dart';

void main() {
  runApp(const GeoLocatorApp());
}

class GeoLocatorApp extends StatelessWidget {
  const GeoLocatorApp({super.key});

  static const List<Tab> tabIconsList = [
    Tab(icon: Icon(Icons.location_on)),
    Tab(icon: Icon(Icons.history)),
    Tab(icon: Icon(Icons.query_stats)),
  ];

  static const String appName = "Geolocator";
  static const Color primaryColor = Color(0xFFC90C0C);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (BuildContext context) => LocationCubit(),
        ),
        BlocProvider<HistoryCubit>(
          create: (BuildContext context) => HistoryCubit(),
        ),
      ],
      child: MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: primaryColor,
          appBarTheme: const AppBarTheme(color: primaryColor),
        ),
          home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(appName),
                bottom: const TabBar(tabs: tabIconsList),
              ),
              body: const TabBarView(
                children: [
                  HomePageScreen(),
                  HistoryPageScreen(),
                  StatsPageScreen(),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
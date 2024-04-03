import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/location/location_bloc.dart';
import 'package:foodie/blocs/location_permission/location_permission_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';
import 'package:foodie/screens/main/detailed_restaurant_screen.dart';
import 'package:foodie/screens/main/favorites_screen.dart';
import 'package:foodie/screens/main/home_screen.dart';
import 'package:foodie/screens/main/location_permission_screen.dart';
import 'package:foodie/screens/main/locations_screen.dart';
import 'package:foodie/screens/main/profile_screen.dart';
import 'package:foodie/widgets/bottom_navigation_bar.dart';
import 'package:uni_links/uni_links.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    const HomeScreen(),
    LocationsScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(create: (context) => LocationBloc()
            // ..add(
            //   InitLocation(),
            // ),
            ),
        BlocProvider<MainBloc>(
          create: (context) => MainBloc()
            ..add(
              InitMain(),
            ),
        ),
        BlocProvider<LocationPermissionBloc>(
          create: (context) => LocationPermissionBloc()
            ..add(
              CheckPermissionEvent(),
            ),
        ),
      ],
      child: BlocBuilder<MainBloc, MainState>(builder: (context, mainState) {
        if (mainState.state == MainStateEnum.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        BlocProvider.of<LocationPermissionBloc>(context)
            .stream
            .listen((permissionState) {
          if (permissionState.state == LocationPermissionStateEnum.granted) {
            BlocProvider.of<MainBloc>(context).add(GetLocation());
          }
        });
        if (mainState.state == MainStateEnum.loaded) {
          return BlocBuilder<LocationPermissionBloc, LocationPermissionState>(
            builder: (context, locationState) {
              return Scaffold(
                body: locationState.state ==
                            LocationPermissionStateEnum.granted ||
                        mainState.pageIndex == 3
                    ? _pages[mainState.pageIndex]
                    : const LocationPermissionScreen(),
                bottomNavigationBar: const BtmNavBar(),
              );
            },
          );
        }
        return Container();
      }),
    );
  }

  Future<void> initUniLinks() async {
    try {
      uriLinkStream.listen((Uri? uri) {
        handleDeepLink(uri);
      }, onError: (err) {
        debugPrint("Error listening to deep link: $err");
      });

      final initialUri = await getInitialUri();
      if (initialUri != null) {
        handleDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint('Error initializing uni_links: $e');
    }
  }

  void handleDeepLink(Uri? uri) {
    if (uri != null && uri.scheme == 'foodie' && uri.host == 'restaurant') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailedRestaurantScreen(id: uri.pathSegments.last),
        ),
      );
    }
  }
}

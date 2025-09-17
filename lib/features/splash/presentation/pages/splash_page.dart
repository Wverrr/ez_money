import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import '../bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        FlutterNativeSplash.remove();
        // context.read<EstimationBloc>().add(GetEstimationEvent());

        if (state is SplashGoToOnboarding) {
          context.pushReplacementNamed('boarding');
        } else if (state is SplashGoToHome) {
          context.pushReplacementNamed('home');
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

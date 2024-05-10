import 'dart:io';
import 'package:branch/bloc_observer.dart';
import 'package:branch/features/home/logic/cubit.dart';
import 'package:branch/features/home/logic/states.dart';
import 'package:branch/features/home/ui/main_page.dart';
import 'package:branch/core/themes/theme.dart';
import 'package:branch/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(500, 1197));
  }
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getBranches(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          final orientation = MediaQuery.of(context).orientation;
          cubit.getDesignSize(orientation: orientation);
          return ScreenUtilInit(
            designSize: cubit.designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: mainTheme,
                home: const MainPage(),
              );
            },
          );
        },
      ),
    );
  }
}

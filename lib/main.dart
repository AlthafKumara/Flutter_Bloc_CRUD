import 'package:crud_clean_bloc/configs/injector/injector_conf.dart';
import 'package:crud_clean_bloc/routes/app_routes_conf.dart';
import 'package:crud_clean_bloc/routes/app_routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // =================== SUPABASE ===========================
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // =================== HIVE ===========================
  await Hive.initFlutter();

  // =================== INJECTOR ===========================
  configureDepedencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp.router(
        routerConfig: AppRoutesConf().router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

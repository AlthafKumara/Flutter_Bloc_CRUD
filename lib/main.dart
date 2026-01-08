import 'features/library/data/models/get_books_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'configs/injector/injector_conf.dart';
import 'routes/app_routes_conf.dart';

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
  Hive.registerAdapter(GetBooksModelAdapter());

  // =================== INJECTOR ===========================
  configureDepedencies();

  // =================== RUN APP ===========================
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

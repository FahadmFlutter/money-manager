import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/Add%20Transaction/screen_add_transaction.dart';
import 'package:money_manager/Models/Category/category_model.dart';
import 'package:money_manager/Models/Transactions/transaction_model.dart';
import 'package:money_manager/Screens/Home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const ScreenHome(),
      routes: {
        ScreenAddTransaction.routerName: (context) => const ScreenAddTransaction(),
      },
    );
  }
}

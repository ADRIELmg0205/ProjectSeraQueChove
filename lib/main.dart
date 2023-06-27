import 'package:flutter/material.dart';
import 'package:sera_que_chove/controllers/cidade_controller.dart';
import 'package:sera_que_chove/widgets/sera_que_chove.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.dotenv.load(fileName: '.env');
  await CidadeController.instancia.inicializarDB();
  await CidadeController.instancia.inicializarCidade();
  runApp(SeraQueChove());
}

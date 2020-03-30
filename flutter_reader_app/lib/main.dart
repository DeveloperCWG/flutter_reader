import 'package:flutter/material.dart';
import 'package:flutter_reader_app/utils/cupertino_localizations_delegate.dart';
import 'my_pages/app_tab_content.dart';
import 'package:flutter_reader_app/static_constant/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(MultiProvider(
    providers: MyConstant.vmMainSetBindList,
    child: MyApp(),
  ));
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.router.generator,
      title: 'Material App',
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      localizationsDelegates: [
        //此处
        CupertinoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //此处
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      locale: const Locale('zh'),
      home: AppTabContent(),
    );
  }
}
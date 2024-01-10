import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/features/auth/view/signin_screen.dart';
import 'package:rental_app/features/terms_and_conditions/views/term_and_conditions_screen.dart';
import 'package:rental_app/routes/route_manager.dart';
import 'package:rental_app/utils/constants/app_constants.dart';
import 'package:rental_app/utils/thems/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commons/common_imports/common_libs.dart';
import 'core/shared_prefs_service/shared_prefs_service.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/main_menu/views/main_menu_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  bool isNewUser = true;

  @override
  void initState() {
    super.initState();
    initiallize();
    FlutterNativeSplash.remove();
  }

  initiallize()async{
    final sharedPreferences = await SharedPreferences.getInstance();
    ISharefPrefsController sharedPrefController = ISharefPrefsController(
        sharedPreferences: await SharedPreferences.getInstance());
    String? val = sharedPrefController.getUserStatus();
    if(val != null){
      isNewUser = false;
    }else{
      isNewUser = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //screenUtil package to make design responsive
    return ScreenUtilInit(
      designSize: const Size(AppConstants.screenWidget, AppConstants.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (BuildContext context,Widget? child){
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor: Theme.of(context).platform == TargetPlatform.iOS?0.9:1
              ),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'barber_app',
          theme: lightThemeData(context),
          themeMode: ThemeMode.light,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: ref.watch(userStateStreamProvider).when(
              data: (user) {
                if (user != null) {
                  return  const MainMenuScreen();
                } else {
                  // String? val = ref.read(sharedPrefsCtr).getUserStatus();
                  if(!isNewUser){
                    return const SignInScreen();
                  }else{
                    return const TermsAndConditionScreen();
                  }
                }
              },
              error: (error, st) => const TermsAndConditionScreen(),
              loading: () => const TermsAndConditionScreen()),
        );
      },
    );
  }
}



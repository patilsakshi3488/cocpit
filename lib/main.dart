import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/theme_service.dart';
import 'services/secure_storage.dart';

import 'views/home_screen.dart';
import 'views/jobs_screen.dart';
import 'views/create_post_screen.dart';
import 'views/events_screen.dart';
import 'views/profile/profile_screen.dart';
import 'views/notification_screen.dart';
import 'views/signin_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: Consumer<ThemeService>(
        builder: (context, themeService, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeService.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: const _RootDecider(),
            routes: {
              '/feed': (_) => const HomeScreen(),
              '/jobs': (_) => const JobsScreen(),
              '/add': (_) => const CreatePostScreen(),
              '/events': (_) => EventsScreen(),
              '/profile': (_) => const ProfileScreen(),
              '/notifications': (_) => const NotificationScreen(),
            },
          );
        },
      ),
    );
  }
}

/// TEMP auth decision (NO Firebase)
class _RootDecider extends StatelessWidget {
  const _RootDecider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SecureStorage.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final token = snapshot.data;

        if (token != null && token.isNotEmpty) {
          return const HomeScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}

import 'package:diyabetansiyon/core/constants/app_constants.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/features/analysis/presentation/screens/analysis_screen.dart';
import 'package:diyabetansiyon/features/measurement/data/models/measurement_hive_model.dart';
import 'package:diyabetansiyon/features/measurement/presentation/screens/measurement_screen.dart';
import 'package:diyabetansiyon/features/profile/data/models/user_profile_hive_model.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/active_profile_provider.dart';
import 'package:diyabetansiyon/features/profile/presentation/screens/profile_list_screen.dart';
import 'package:diyabetansiyon/features/records/presentation/screens/records_screen.dart';
import 'package:diyabetansiyon/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> _initHive() async {
  try {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProfileHiveModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MeasurementHiveModelAdapter());
    }

    // Eski veri formatı ile uyumsuzluk durumunda box'ı sil ve yeniden oluştur
    try {
      await Hive.openBox<UserProfileHiveModel>(AppConstants.profileBoxName);
    } catch (e) {
      debugPrint('Profile box open error, deleting and recreating: $e');
      await Hive.deleteBoxFromDisk(AppConstants.profileBoxName);
      await Hive.openBox<UserProfileHiveModel>(AppConstants.profileBoxName);
    }

    try {
      await Hive.openBox<MeasurementHiveModel>(AppConstants.measurementsBoxName);
    } catch (e) {
      debugPrint('Measurements box open error, deleting and recreating: $e');
      await Hive.deleteBoxFromDisk(AppConstants.measurementsBoxName);
      await Hive.openBox<MeasurementHiveModel>(AppConstants.measurementsBoxName);
    }

    await Hive.openBox(AppConstants.settingsBoxName); // Ayarlar için ayrı kutu
  } catch (e) {
    debugPrint('Hive init error: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr', null);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await _initHive();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(activeProfileProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DiyabeTansiyon',
      theme: AppTheme.lightTheme,
      locale: const Locale('tr', 'TR'),
      supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Burası en kritik nokta: activeProfile varsa HomeRoot, yoksa Seçim ekranı
      key: ValueKey(
        activeProfile?.id,
      ), // Profil değiştiğinde tüm uygulamayı yenile
      home: activeProfile == null
          ? const ProfileListScreen()
          : const HomeRoot(),
    );
  }
}

class HomeRoot extends StatefulWidget {
  const HomeRoot({super.key});
  @override
  State<HomeRoot> createState() => _HomeRootState();
}

class _HomeRootState extends State<HomeRoot> {
  int _index = 0;
  final _screens = const [
    MeasurementScreen(),
    AnalysisScreen(),
    RecordsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_index],
      bottomNavigationBar: _BottomNav(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.monitor_heart,
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: Icons.bar_chart,
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavItem(
            icon: Icons.list_alt,
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavItem(
            icon: Icons.settings,
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.white : Colors.white54),
      onPressed: onTap,
    );
  }
}

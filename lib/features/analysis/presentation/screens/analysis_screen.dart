// Ölçüm verilerinin grafik ve istatistiklerle analiz edildiği ekran.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:diyabetansiyon/core/enums/analysis_category.dart';
import 'package:diyabetansiyon/core/widgets/health_background.dart';
import 'package:diyabetansiyon/features/analysis/presentation/providers/analysis_provider.dart';
import 'package:diyabetansiyon/features/analysis/presentation/widgets/analysis_screen_content.dart';
import 'package:diyabetansiyon/features/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalysisScreen extends ConsumerStatefulWidget {
  const AnalysisScreen({super.key});

  @override
  ConsumerState<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends ConsumerState<AnalysisScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AnalysisCategory _selectedCategory = AnalysisCategory.systolic;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(
      categoryStatsProvider(
        category: _selectedCategory,
        tabIndex: _tabController.index,
      ),
    );
    final measurementsAsync = ref.watch(
      filteredMeasurementsProvider(
        category: _selectedCategory,
        tabIndex: _tabController.index,
      ),
    );
    final barGroupsAsync = ref.watch(
      categoryBarGroupsProvider(
        category: _selectedCategory,
        tabIndex: _tabController.index,
      ),
    );
    final profile = ref.watch(profileProvider).value;
    final age = profile?.age ?? 30;
    final gender = profile?.gender ?? 'male';

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppTexts.analysisTitle,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontXL(context),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryDark, AppColors.primary],
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: AppTexts.tabDaily),
            Tab(text: AppTexts.tabWeekly),
            Tab(text: AppTexts.tabMonthly),
            Tab(text: AppTexts.tabThreeMonths),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: HealthBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppDimensions.screenPadding(context),
            child: AnalysisScreenContent(
              selectedCategory: _selectedCategory,
              onCategoryChanged: (category) {
                setState(() => _selectedCategory = category);
              },
              statsAsync: statsAsync,
              measurementsAsync: measurementsAsync,
              barGroupsAsync: barGroupsAsync,
              age: age,
              gender: gender,
            ),
          ),
        ),
      ),
    );
  }
}

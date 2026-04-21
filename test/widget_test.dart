import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/features/settings/presentation/widgets/clinical_references_card.dart';

void main() {
  testWidgets('Clinical references card temel icerigi gosterir', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ClinicalReferencesCard())),
    );

    expect(find.text(AppTexts.clinicalReferencesTitle), findsOneWidget);
    expect(find.text(AppTexts.clinicalRefAha), findsOneWidget);
    expect(find.text(AppTexts.clinicalRefWhoAda), findsOneWidget);
    expect(find.text(AppTexts.clinicalRefAap), findsOneWidget);
  });
}

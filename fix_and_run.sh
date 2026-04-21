#!/bin/bash

echo "1. Eski kalıntılar temizleniyor..."
flutter clean

echo "2. Bağımlılıklar güncelleniyor..."
flutter pub get

echo "3. APK üretiliyor (Hata ayıklama modu)..."
flutter build apk --debug

echo "4. APK emülatöre yükleniyor..."
adb install build/app/outputs/flutter-apk/app-debug.apk

echo "İşlem tamam! Eğer 'Success' yazısını gördüyseniz uygulamayı emülatörden açabilirsiniz."

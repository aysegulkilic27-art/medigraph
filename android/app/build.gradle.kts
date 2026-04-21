plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.diyabetansiyon"
    compileSdk = 35

    // NDK Versiyonunu güncelledik
    ndkVersion = "28.2.13676358"

    // Java ve Kotlin sürümlerini 17 olarak eşitledik
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    defaultConfig {
        applicationId = "com.example.diyabetansiyon"

        // PROFİL TAKILMA SORUNUNU ÇÖZEN RAKAM:
        minSdk = flutter.minSdkVersion

        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

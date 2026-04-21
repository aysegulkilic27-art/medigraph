plugins {
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    id("dev.flutter.flutter-gradle-plugin") apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
    rootProject.layout.buildDirectory.set(file("${rootProject.projectDir}/../build"))
}

subprojects {
    val newBuildDir = file("${rootProject.layout.buildDirectory.get()}/${project.name}")
    project.layout.buildDirectory.set(newBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
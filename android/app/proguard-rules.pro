## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

## Gson rules
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

## Keep data models
-keep class com.kitabku.kitab_ku.** { *; }

## Remove logging in release
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
}

## Google Fonts
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

## HTTP
-keepattributes *Annotation*
-keepclassmembers class * {
    @org.jetbrains.annotations.** *;
}

## Shared Preferences
-keep class androidx.preference.** { *; }

## Share Plus
-keep class androidx.core.content.FileProvider { *; }

# Preserve all classes and methods in the Suunto MDS library
-keep class dk.cachet.carp_study_app.** { *; }

# Preserve all classes and methods that might contain callback methods
-keep class * {
    public void SDSInternalCallback(int, int, java.lang.String, byte[]);
}

# Preserve all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Preserve all classes and methods in your app's package
-keep class com.movesense.mds.**{*;}
-dontwarn org.bouncycastle.jsse.BCSSLParameters
-dontwarn org.bouncycastle.jsse.BCSSLSocket
-dontwarn org.bouncycastle.jsse.provider.BouncyCastleJsseProvider
-dontwarn org.conscrypt.Conscrypt$Version
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.ConscryptHostnameVerifier
-dontwarn org.openjsse.javax.net.ssl.SSLParameters
-dontwarn org.openjsse.javax.net.ssl.SSLSocket
-dontwarn org.openjsse.net.ssl.OpenJSSE
-dontwarn org.slf4j.impl.StaticLoggerBinder

-keepattributes Annotation, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt
-keepclassmembers class kotlinx.serialization.json.** {
*** Companion;
}
-keepclasseswithmembers class kotlinx.serialization.json.** {
kotlinx.serialization.KSerializer serializer(...);
}

-keep class kotlin.** { *; }
-keep class kotlinx.* { *; }
-keepclassmembers class **$WhenMappings { *; }
-keepclassmembers class kotlin.Metadata {
public *;
}


-keep class * implements android.os.Parcelable {
public static final android.os.Parcelable$Creator *;
}
-keepnames class * implements android.os.Parcelable {
public static final ** CREATOR;
}
-keepclassmembers class * implements android.os.Parcelable {
public static final android.os.Parcelable$Creator *;
}


-keep interface retrofit2.Call
-keep class retrofit2.** { *; }
-keep interface retrofit2.* { *; }
-keepattributes Signature
-keepattributes Annotation

-keep class com.squareup.retrofit2.** { *; }
-keep interface com.squareup.retrofit2.* { *; }
-keepclasseswithmembers class * {
@retrofit2.http *;
}

-keep class com.paystack.android.core.api.** { *; }
-keep interface com.paystack.android.core.api.* { *; }
-keep class com.paystack.android.core.api.models.* {*;}
-keepattributes Signature
-keepattributes Annotation
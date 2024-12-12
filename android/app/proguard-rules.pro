# 已有的规则
-keep class com.google.errorprone.annotations.** { *; }
-keep class javax.annotation.** { *; }
-dontwarn com.google.errorprone.annotations.**
-dontwarn javax.annotation.**

# 添加 media_kit 相关规则
-keep class com.arthenica.ffmpegkit.** { *; }
-keep class com.google.crypto.tink.** { *; }
-dontwarn com.google.crypto.tink.**

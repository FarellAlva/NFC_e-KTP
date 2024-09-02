# NFC_e-ktp

this project used integrated NFC with dartvm, using KTP as the subject point

## Getting Started :

- start new project
- flutter pub upgrade (make sure your flutter -version up to date)
- Add nfc_manager in your dependecies.yaml
- update AndroidManifest.XML,  in order to detect your app's nfc as high priority NFC used hardware
(android\app\src\main\AndroidManifest.xml)
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.NFC" />
    <uses-feature android:name="android.hardware.nfc" android:required="true" />

    <application
        android:label="ektp_reader_2"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <!-- Intent filter untuk NFC dengan prioritas tinggi -->
            <intent-filter android:priority="1000">
                <action android:name="android.nfc.action.TECH_DISCOVERED" />
            </intent-filter>
            <meta-data
                android:name="android.nfc.action.TECH_DISCOVERED"
                android:resource="@xml/nfc_tech_filter" />

            <!-- Intent filter utama aplikasi -->
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
            
            <!-- Metadata untuk tema Flutter -->
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
        </activity>

        <!-- Metadata untuk Flutter -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>

    <!-- Queries untuk aktivitas yang dapat memproses teks -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```

- make new folder ('xml') in android\app\src\main\res\xml\nfc_tech_filter.xml,  add:
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2">
    <tech-list>
        <tech>android.nfc.tech.NfcA</tech>
    </tech-list>
    <tech-list>
        <tech>android.nfc.tech.NfcB</tech>
    </tech-list>
    <tech-list>
        <tech>android.nfc.tech.NfcF</tech>
    </tech-list>
    <tech-list>
        <tech>android.nfc.tech.NfcV</tech>
    </tech-list>
</resources>
```

## https://pub.dev/packages/nfc_manager

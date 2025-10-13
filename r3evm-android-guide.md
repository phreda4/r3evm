# Guía completa: Portar r3evm a Android

Esta guía te ayudará a compilar y ejecutar r3evm en Android, tanto en emulador como en dispositivo físico.

---

## 📋 Requisitos previos

### En Windows

1. **Java JDK 17 o superior**
   - Descargar desde: https://adoptium.net/
   - Durante instalación, marca "Set JAVA_HOME variable"
   - Verificar: `java -version` en CMD

2. **Android Studio**
   - Descargar desde: https://developer.android.com/studio
   - Versión recomendada: Hedgehog o superior (2023+)
   - Durante instalación, incluir:
     - Android SDK
     - Android SDK Platform
     - Android Virtual Device

3. **Git for Windows**
   - Descargar desde: https://git-scm.com/download/win
   - Usar durante instalación: "Git from the command line and also from 3rd-party software"

4. **CMake** (si no viene con Android Studio)
   - Se instala desde Android Studio SDK Manager

### En Linux

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-17-jdk git cmake ninja-build

# Descargar Android Studio
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.1.1.28/android-studio-2023.1.1.28-linux.tar.gz
tar -xzf android-studio-*.tar.gz
cd android-studio/bin
./studio.sh
```

---

## 🔧 Instalación y configuración

### Paso 1: Configurar Android Studio

1. **Abrir Android Studio** por primera vez
2. Ir a **Tools → SDK Manager**
3. En la pestaña **SDK Platforms**, instalar:
   - ✅ Android 13.0 (API Level 33) o superior
   - ✅ Android 11.0 (API Level 30) - mínimo recomendado

4. En la pestaña **SDK Tools**, instalar:
   - ✅ Android SDK Build-Tools
   - ✅ NDK (Side by side) - versión 25.x o superior
   - ✅ CMake
   - ✅ Android SDK Command-line Tools

5. **Anotar las rutas** (las necesitarás):
   - SDK Location: `C:\Users\TuUsuario\AppData\Local\Android\Sdk` (Windows)
   - SDK Location: `~/Android/Sdk` (Linux)

### Paso 2: Configurar variables de entorno (Windows)

1. Presiona `Win + R`, escribe `sysdm.cpl` y Enter
2. Ir a **Opciones avanzadas → Variables de entorno**
3. Agregar/editar en **Variables del sistema**:

```
ANDROID_HOME = C:\Users\TuUsuario\AppData\Local\Android\Sdk
ANDROID_NDK_HOME = C:\Users\TuUsuario\AppData\Local\Android\Sdk\ndk\25.2.9519653
```

4. Editar `Path` y agregar:
```
%ANDROID_HOME%\platform-tools
%ANDROID_HOME%\tools
%ANDROID_HOME%\tools\bin
```

5. Reiniciar CMD y verificar:
```cmd
adb version
```

### Paso 3: Descargar SDL2

```bash
# Windows (PowerShell o Git Bash)
cd C:\Proyectos  # O tu directorio preferido
curl -L https://github.com/libsdl-org/SDL/releases/download/release-2.28.5/SDL2-2.28.5.tar.gz -o SDL2.tar.gz
tar -xzf SDL2.tar.gz
mv SDL2-2.28.5 SDL2

# Linux
cd ~/proyectos
wget https://github.com/libsdl-org/SDL/releases/download/release-2.28.5/SDL2-2.28.5.tar.gz
tar -xzf SDL2-2.28.5.tar.gz
mv SDL2-2.28.5 SDL2
```

---

## 📁 Crear estructura del proyecto

### Paso 1: Clonar r3evm

```bash
# Windows
cd C:\Proyectos
git clone https://github.com/phreda4/r3evm.git

# Linux
cd ~/proyectos
git clone https://github.com/phreda4/r3evm.git
```

### Paso 2: Crear proyecto Android

1. Abrir Android Studio
2. **File → New → New Project**
3. Seleccionar: **Native C++**
4. Configurar:
   - **Name**: R3EVM
   - **Package name**: com.r3evm.app
   - **Save location**: `C:\Proyectos\r3evm-android` (Windows) o `~/proyectos/r3evm-android` (Linux)
   - **Language**: Java
   - **Minimum SDK**: API 24 (Android 7.0)
   - **C++ Standard**: C++14

5. Click **Finish**

### Paso 3: Integrar SDL2 en el proyecto

**Estructura final del proyecto:**

```
r3evm-android/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── AndroidManifest.xml
│   │       ├── java/com/r3evm/app/
│   │       │   └── MainActivity.java
│   │       ├── cpp/
│   │       │   ├── r3/              # Código de r3evm
│   │       │   │   ├── main.c
│   │       │   │   └── ... (todos los archivos .c/.h)
│   │       │   ├── platform.h       # Nuevo archivo
│   │       │   └── CMakeLists.txt
│   │       ├── assets/
│   │       │   └── main.r3          # Scripts r3
│   │       └── jniLibs/             # Se generará automáticamente
│   └── build.gradle
├── SDL2/                            # Copiar aquí el SDL2 descargado
└── build.gradle
```

**Copiar SDL2:**

```bash
# Windows
xcopy /E /I C:\Proyectos\SDL2 C:\Proyectos\r3evm-android\SDL2

# Linux
cp -r ~/proyectos/SDL2 ~/proyectos/r3evm-android/
```

**Copiar código r3evm:**

```bash
# Windows
xcopy /E /I C:\Proyectos\r3evm\*.c C:\Proyectos\r3evm-android\app\src\main\cpp\r3\
xcopy /E /I C:\Proyectos\r3evm\*.h C:\Proyectos\r3evm-android\app\src\main\cpp\r3\

# Linux
cp -r ~/proyectos/r3evm/*.{c,h} ~/proyectos/r3evm-android/app/src/main/cpp/r3/
```

---

## 💻 Modificar código fuente

### Archivo 1: `platform.h`

Crear `app/src/main/cpp/platform.h`:

```c
#ifndef PLATFORM_H
#define PLATFORM_H

#ifdef _WIN32
    #include <windows.h>
    typedef HMODULE LibHandle;
    #define LOAD_LIB(name) LoadLibrary(name)
    #define GET_PROC(lib, name) GetProcAddress(lib, name)
    #define FREE_LIB(lib) FreeLibrary(lib)
    #define GET_ERROR() "Windows Error"
#else
    #include <dlfcn.h>
    typedef void* LibHandle;
    #define LOAD_LIB(name) dlopen(name, RTLD_LAZY)
    #define GET_PROC(lib, name) dlsym(lib, name)
    #define FREE_LIB(lib) dlclose(lib)
    #define GET_ERROR() dlerror()
    
    #ifdef __ANDROID__
        #include <android/log.h>
        #define LOG_TAG "R3EVM"
        #define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
        #define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)
    #else
        #define LOGI(...) printf(__VA_ARGS__)
        #define LOGE(...) fprintf(stderr, __VA_ARGS__)
    #endif
#endif

// Helper para construir nombres de librerías
static inline void get_lib_name(char* buffer, size_t size, const char* base) {
    #ifdef _WIN32
        snprintf(buffer, size, "%s.dll", base);
    #else
        snprintf(buffer, size, "lib%s.so", base);
    #endif
}

// Helper para obtener rutas de archivos
#ifdef __ANDROID__
    #include <SDL.h>
    static inline const char* get_asset_path(const char* filename) {
        static char path[512];
        const char* base = SDL_AndroidGetInternalStoragePath();
        snprintf(path, sizeof(path), "%s/%s", base, filename);
        return path;
    }
#else
    static inline const char* get_asset_path(const char* filename) {
        return filename;
    }
#endif

#endif // PLATFORM_H
```

### Archivo 2: Modificar código r3evm

En los archivos `.c` de r3evm que usen `LoadLibrary`/`GetProcAddress`, agregar al inicio:

```c
#include "../platform.h"  // Ajustar la ruta según ubicación

// Reemplazar:
// LoadLibrary("SDL2.dll") 
// Por:
char libname[256];
get_lib_name(libname, sizeof(libname), "SDL2");
LibHandle lib = LOAD_LIB(libname);
if (!lib) {
    LOGE("Error loading library: %s", GET_ERROR());
    return -1;
}

// Reemplazar:
// GetProcAddress(lib, "SDL_Init")
// Por:
void* func = GET_PROC(lib, "SDL_Init");

// Al abrir archivos, reemplazar:
// fopen("main.r3", "r")
// Por:
fopen(get_asset_path("main.r3"), "r")
```

---

## 📂 Distribuir archivos .r3 con el APK

Como r3evm es un intérprete que necesita archivos `.r3` externos, hay **3 métodos** para incluirlos en tu APK:

### **Método 1: Assets (Recomendado para archivos de solo lectura)**

Los archivos en `assets/` se empaquetan dentro del APK pero son de **solo lectura**.

#### Estructura:

```
app/src/main/assets/
├── r3/
│   ├── main.r3
│   ├── lib/
│   │   ├── util.r3
│   │   ├── gui.r3
│   │   └── math.r3
│   └── examples/
│       ├── demo1.r3
│       └── demo2.r3
```

#### Código para leer desde assets:

Actualizar `platform.h`:

```c
#ifdef __ANDROID__
    #include <SDL.h>
    #include <android/asset_manager.h>
    #include <android/asset_manager_jni.h>
    
    // Variable global para el AssetManager (inicializar desde Java)
    extern AAssetManager* g_AssetManager;
    
    // Leer archivo desde assets
    static inline char* read_asset_file(const char* filename, size_t* out_size) {
        if (!g_AssetManager) {
            LOGE("AssetManager not initialized!");
            return NULL;
        }
        
        AAsset* asset = AAssetManager_open(g_AssetManager, filename, AASSET_MODE_BUFFER);
        if (!asset) {
            LOGE("Failed to open asset: %s", filename);
            return NULL;
        }
        
        size_t size = AAsset_getLength(asset);
        char* buffer = (char*)malloc(size + 1);
        if (!buffer) {
            AAsset_close(asset);
            return NULL;
        }
        
        AAsset_read(asset, buffer, size);
        buffer[size] = '\0';
        
        if (out_size) *out_size = size;
        
        AAsset_close(asset);
        return buffer;
    }
    
    // Listar archivos en un directorio de assets
    static inline char** list_asset_dir(const char* dirpath, int* count) {
        if (!g_AssetManager) return NULL;
        
        AAssetDir* dir = AAssetManager_openDir(g_AssetManager, dirpath);
        if (!dir) return NULL;
        
        // Contar archivos
        *count = 0;
        const char* filename;
        while ((filename = AAssetDir_getNextFileName(dir)) != NULL) {
            (*count)++;
        }
        AAssetDir_rewind(dir);
        
        // Crear array
        char** files = (char**)malloc(*count * sizeof(char*));
        int i = 0;
        while ((filename = AAssetDir_getNextFileName(dir)) != NULL) {
            files[i++] = strdup(filename);
        }
        
        AAssetDir_close(dir);
        return files;
    }
#endif
```

#### Código en el main de r3evm:

```c
#ifdef __ANDROID__
    // Leer archivo .r3 desde assets
    size_t size;
    char* code = read_asset_file("r3/main.r3", &size);
    if (code) {
        // Ejecutar el código
        interpret(code, size);
        free(code);
    }
    
    // O listar todos los .r3 disponibles
    int count;
    char** files = list_asset_dir("r3", &count);
    for (int i = 0; i < count; i++) {
        LOGI("Found: %s", files[i]);
        free(files[i]);
    }
    free(files);
#else
    // Windows/Linux: leer de disco normalmente
    FILE* f = fopen("main.r3", "r");
    // ...
#endif
```

#### Modificar MainActivity.java:

```java
package com.r3evm.app;

import org.libsdl.app.SDLActivity;
import android.os.Bundle;
import android.content.res.AssetManager;

public class MainActivity extends SDLActivity {
    
    // Declarar función nativa para pasar el AssetManager
    private static native void nativeSetAssetManager(AssetManager assetManager);
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Pasar AssetManager al código nativo
        nativeSetAssetManager(getAssets());
    }
    
    @Override
    protected String[] getLibraries() {
        return new String[] {
            "SDL2",
            "r3evm"
        };
    }
}
```

#### Implementar en C (en tu main.c):

```c
#include <jni.h>
#include <android/asset_manager_jni.h>

AAssetManager* g_AssetManager = NULL;

JNIEXPORT void JNICALL
Java_com_r3evm_app_MainActivity_nativeSetAssetManager(JNIEnv* env, jclass cls, jobject assetManager) {
    g_AssetManager = AAssetManager_fromJava(env, assetManager);
}
```

---

### **Método 2: Copiar assets a almacenamiento interno (Recomendado para lectura/escritura)**

Si necesitas **modificar** los archivos `.r3` o crear nuevos en tiempo de ejecución:

#### Código para copiar assets al almacenamiento interno:

Agregar a `platform.h`:

```c
#ifdef __ANDROID__
    #include <sys/stat.h>
    #include <unistd.h>
    
    // Copiar archivo de assets a almacenamiento interno
    static inline bool copy_asset_to_internal(const char* asset_path, const char* dest_path) {
        size_t size;
        char* data = read_asset_file(asset_path, &size);
        if (!data) return false;
        
        // Crear directorios si no existen
        char dir[512];
        strncpy(dir, dest_path, sizeof(dir));
        char* last_slash = strrchr(dir, '/');
        if (last_slash) {
            *last_slash = '\0';
            mkdir(dir, 0755);  // Crear directorio
        }
        
        // Escribir archivo
        FILE* f = fopen(dest_path, "wb");
        if (!f) {
            free(data);
            return false;
        }
        
        fwrite(data, 1, size, f);
        fclose(f);
        free(data);
        
        return true;
    }
    
    // Copiar todo el directorio de assets
    static inline void copy_assets_folder(const char* asset_dir, const char* dest_dir) {
        mkdir(dest_dir, 0755);
        
        int count;
        char** files = list_asset_dir(asset_dir, &count);
        
        for (int i = 0; i < count; i++) {
            char asset_path[512];
            char dest_path[512];
            
            snprintf(asset_path, sizeof(asset_path), "%s/%s", asset_dir, files[i]);
            snprintf(dest_path, sizeof(dest_path), "%s/%s", dest_dir, files[i]);
            
            LOGI("Copying: %s -> %s", asset_path, dest_path);
            copy_asset_to_internal(asset_path, dest_path);
            
            free(files[i]);
        }
        free(files);
    }
    
    // Obtener ruta de almacenamiento interno de la app
    static inline const char* get_internal_storage_path() {
        return SDL_AndroidGetInternalStoragePath();
    }
#endif
```

#### Uso en el main:

```c
#ifdef __ANDROID__
    // Al iniciar la app, copiar todos los .r3 a almacenamiento interno
    const char* internal = get_internal_storage_path();
    char r3_dir[512];
    snprintf(r3_dir, sizeof(r3_dir), "%s/r3", internal);
    
    // Copiar solo si no existe (primera ejecución)
    struct stat st;
    if (stat(r3_dir, &st) != 0) {
        LOGI("First run, copying r3 files...");
        copy_assets_folder("r3", r3_dir);
        copy_assets_folder("r3/lib", r3_dir);
    }
    
    // Ahora puedes leer/escribir normalmente
    char filepath[512];
    snprintf(filepath, sizeof(filepath), "%s/main.r3", r3_dir);
    FILE* f = fopen(filepath, "r");
    // ...
#endif
```

---

### **Método 3: Descargar desde internet (Actualización dinámica)**

Para actualizaciones sin recompilar el APK:

```c
#ifdef __ANDROID__
    // Usar SDL_net o libcurl para descargar
    bool download_r3_files(const char* url, const char* dest_path) {
        // Implementar descarga HTTP
        // Guardar en get_internal_storage_path()
        return true;
    }
    
    // Al iniciar, verificar versión y actualizar si es necesario
    if (check_for_updates()) {
        download_r3_files("https://tuservidor.com/r3files.zip", get_internal_storage_path());
    }
#endif
```

---

## 🔄 Comparación de métodos

| Método | Ventajas | Desventajas | Uso recomendado |
|--------|----------|-------------|------------------|
| **Assets** | • Simple<br>• Empaquetado en APK<br>• No permisos extra | • Solo lectura<br>• No se puede modificar | Scripts de sistema fijos |
| **Copiar a interno** | • Lectura/escritura<br>• Permite modificación | • Usa espacio adicional<br>• Copia inicial | Scripts editables por usuario |
| **Descarga web** | • Actualización sin APK<br>• Menor tamaño APK | • Requiere internet<br>• Más complejo | Contenido actualizable |

---

## 📝 Actualizar build.gradle para incluir assets

Asegúrate de que `app/build.gradle` incluya:

```gradle
android {
    ...
    
    sourceSets {
        main {
            assets.srcDirs = ['src/main/assets']
        }
    }
    
    // Evitar que compresión dañe archivos .r3
    aaptOptions {
        noCompress "r3"  // No comprimir archivos .r3
    }
}
```

### Archivo 3: `CMakeLists.txt`

Crear/editar `app/src/main/cpp/CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.22.1)
project(r3evm)

# Agregar SDL2
add_subdirectory(${CMAKE_SOURCE_DIR}/../../../../SDL2 SDL2)

# Encontrar todos los archivos fuente de r3evm
file(GLOB R3_SOURCES 
    "r3/*.c"
)

# Crear la librería compartida
add_library(r3evm SHARED
    ${R3_SOURCES}
)

# Definir macros
target_compile_definitions(r3evm PRIVATE 
    __ANDROID__
)

# Opciones de compilación
target_compile_options(r3evm PRIVATE
    -Wall
    -O2
)

# Incluir directorios
target_include_directories(r3evm PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/../../../../SDL2/include
)

# Enlazar librerías
target_link_libraries(r3evm
    SDL2
    SDL2main
    log
    android
    dl
    GLESv2
    OpenSLES
)
```

### Archivo 4: `MainActivity.java`

Editar `app/src/main/java/com/r3evm/app/MainActivity.java`:

```java
package com.r3evm.app;

import org.libsdl.app.SDLActivity;
import android.os.Bundle;

public class MainActivity extends SDLActivity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }
    
    @Override
    protected String[] getLibraries() {
        return new String[] {
            "SDL2",
            "r3evm"
        };
    }
    
    @Override
    protected String getMainFunction() {
        return "SDL_main";
    }
}
```

### Archivo 5: `AndroidManifest.xml`

Editar `app/src/main/AndroidManifest.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <!-- Permisos -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    
    <!-- Características OpenGL ES -->
    <uses-feature android:glEsVersion="0x00020000" android:required="true" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="R3EVM"
        android:theme="@style/Theme.AppCompat.NoActionBar"
        android:fullBackupContent="@xml/backup_rules"
        android:dataExtractionRules="@xml/data_extraction_rules"
        tools:targetApi="31">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:configChanges="orientation|screenSize|keyboardHidden"
            android:screenOrientation="landscape">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

### Archivo 6: `build.gradle` (app)

Editar `app/build.gradle`:

```gradle
plugins {
    id 'com.android.application'
}

android {
    namespace 'com.r3evm.app'
    compileSdk 33

    defaultConfig {
        applicationId "com.r3evm.app"
        minSdk 24
        targetSdk 33
        versionCode 1
        versionName "1.0"

        ndk {
            abiFilters 'arm64-v8a', 'armeabi-v7a'
        }

        externalNativeBuild {
            cmake {
                cppFlags "-std=c++14"
                arguments "-DANDROID_STL=c++_shared"
            }
        }
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    externalNativeBuild {
        cmake {
            path "src/main/cpp/CMakeLists.txt"
            version "3.22.1"
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    sourceSets {
        main {
            assets.srcDirs = ['src/main/assets']
        }
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
}
```

---

## 🏃 Compilar y probar en emulador

### Paso 1: Crear un emulador (AVD)

1. En Android Studio: **Tools → Device Manager**
2. Click **Create Device**
3. Seleccionar:
   - **Category**: Phone
   - **Device**: Pixel 5 o similar
   - Click **Next**

4. **System Image**:
   - **Release Name**: Tiramisu (API 33)
   - **ABI**: arm64-v8a (o x86_64 si tu PC no soporta ARM)
   - Descargar si es necesario
   - Click **Next**

5. **AVD Name**: R3EVM_Test
6. **Startup orientation**: Landscape
7. Click **Finish**

### Paso 2: Compilar y ejecutar

1. En Android Studio, seleccionar el emulador de la lista desplegable superior
2. Click en el botón **Run** (▶️) o presiona `Shift + F10`
3. Esperar a que compile (primera vez puede tardar 5-10 minutos)
4. El emulador se iniciará automáticamente y ejecutará la app

### Paso 3: Ver logs (debugging)

Abrir la pestaña **Logcat** en Android Studio y filtrar por `R3EVM`:

```
# O desde línea de comandos:
adb logcat -s R3EVM:V SDL:V
```

### Solución de problemas comunes

**Error: "SDK location not found"**
```bash
# Crear/editar local.properties en la raíz del proyecto
sdk.dir=C\:\\Users\\TuUsuario\\AppData\\Local\\Android\\Sdk
```

**Error: "NDK not found"**
- Ir a SDK Manager → SDK Tools → Instalar NDK

**Error de compilación de SDL2**
- Verificar que SDL2 esté en la ruta correcta
- Revisar permisos de lectura en la carpeta SDL2

**App se cierra inmediatamente**
- Revisar Logcat para ver el error específico
- Verificar que todas las librerías estén cargando correctamente

---

## 📦 Generar APK para dispositivo físico

### Opción 1: APK Debug (para pruebas)

1. En Android Studio: **Build → Build Bundle(s) / APK(s) → Build APK(s)**
2. Esperar a que compile
3. Click en **locate** en la notificación
4. El APK estará en: `app/build/outputs/apk/debug/app-debug.apk`

**Instalar en dispositivo:**

```bash
# Conectar el teléfono por USB con "Depuración USB" habilitada
adb devices  # Verificar que aparezca el dispositivo

# Instalar
adb install app/build/outputs/apk/debug/app-debug.apk

# O arrastra el APK al teléfono y ábrelo desde allí
```

### Opción 2: APK Release (para distribución)

#### Paso 1: Generar keystore

```bash
# Windows (en PowerShell o CMD)
cd C:\Proyectos\r3evm-android
keytool -genkey -v -keystore r3evm-release.keystore -alias r3evm -keyalg RSA -keysize 2048 -validity 10000

# Linux
cd ~/proyectos/r3evm-android
keytool -genkey -v -keystore r3evm-release.keystore -alias r3evm -keyalg RSA -keysize 2048 -validity 10000
```

**Importante**: Anota la contraseña, la necesitarás.

#### Paso 2: Configurar firma

Crear/editar `app/build.gradle`:

```gradle
android {
    ...
    
    signingConfigs {
        release {
            storeFile file("../r3evm-release.keystore")
            storePassword "TU_CONTRASEÑA"
            keyAlias "r3evm"
            keyPassword "TU_CONTRASEÑA"
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

#### Paso 3: Compilar release

```bash
# Desde Android Studio
Build → Generate Signed Bundle / APK → APK
- Seleccionar keystore
- Ingresar contraseñas
- Build Variants: release
- Signature Versions: V1 y V2

# O desde línea de comandos
# Windows
cd C:\Proyectos\r3evm-android
gradlew.bat assembleRelease

# Linux
cd ~/proyectos/r3evm-android
./gradlew assembleRelease
```

El APK estará en: `app/build/outputs/apk/release/app-release.apk`

#### Paso 4: Optimizar APK (opcional)

```bash
# Instalar zipalign (viene con Android SDK)
zipalign -v -p 4 app-release.apk app-release-aligned.apk

# Verificar
zipalign -c -v 4 app-release-aligned.apk
```

---

## 📱 Instalar en dispositivo físico

### Método 1: Via USB (ADB)

1. **Habilitar opciones de desarrollador en el teléfono:**
   - Ir a Configuración → Acerca del teléfono
   - Tocar 7 veces en "Número de compilación"
   - Volver a Configuración → Opciones de desarrollador
   - Activar "Depuración USB"

2. **Conectar por USB y transferir:**

```bash
# Verificar conexión
adb devices

# Instalar
adb install -r app-release.apk

# Ver logs en tiempo real
adb logcat -s R3EVM:V
```

### Método 2: Transferencia directa

1. Copiar `app-release.apk` al teléfono (USB, Bluetooth, email, etc.)
2. En el teléfono, ir a Configuración → Seguridad
3. Activar "Fuentes desconocidas" o "Instalar apps desconocidas"
4. Abrir el APK desde el explorador de archivos
5. Click en "Instalar"

### Método 3: Compartir por red local

```bash
# En la PC, desde el directorio del APK
python -m http.server 8000

# En el teléfono, abrir navegador:
http://IP_DE_TU_PC:8000/app-release.apk
```

---

## 🐛 Debugging en dispositivo

### Ver logs en tiempo real

```bash
# Logs generales
adb logcat

# Filtrar solo R3EVM
adb logcat -s R3EVM:V

# Filtrar R3EVM y SDL
adb logcat -s R3EVM:V SDL:V

# Limpiar logs previos
adb logcat -c
```

### Monitorear recursos

```bash
# CPU y memoria
adb shell top | grep r3evm

# Información del sistema
adb shell dumpsys
```

### Acceder a archivos de la app

```bash
# Listar archivos
adb shell run-as com.r3evm.app ls -la

# Copiar archivo desde el dispositivo
adb pull /data/data/com.r3evm.app/files/archivo.txt

# Copiar archivo hacia el dispositivo
adb push archivo.txt /data/data/com.r3evm.app/files/
```

---

## ✅ Checklist final

Antes de compilar la versión final, verifica:

- [ ] Todas las llamadas a `LoadLibrary` están reemplazadas
- [ ] Todas las rutas de archivo usan `get_asset_path()`
- [ ] Los archivos necesarios están en `assets/`
- [ ] El `AndroidManifest.xml` tiene todos los permisos necesarios
- [ ] La app funciona en emulador sin crashes
- [ ] Los logs muestran que las librerías se cargan correctamente
- [ ] La firma del APK está configurada (para release)
- [ ] Has probado en al menos 2 arquitecturas (arm64-v8a, armeabi-v7a)

---

## 📚 Recursos adicionales

- **Documentación SDL2 Android**: https://wiki.libsdl.org/SDL2/README/android
- **Android NDK Docs**: https://developer.android.com/ndk/guides
- **ADB Docs**: https://developer.android.com/tools/adb
- **r3evm GitHub**: https://github.com/phreda4/r3evm

---

## 🆘 Soporte

Si encuentras problemas:

1. Revisar Logcat para errores específicos
2. Verificar que todas las rutas sean correctas
3. Asegurarse de que SDL2 esté compilando correctamente
4. Revisar permisos en AndroidManifest.xml
5. Probar primero en emulador antes que en dispositivo

**¡Buena suerte con tu proyecto r3evm en Android!** 🚀
#!/bin/bash

APP_NAME="Iconset Generator"
BUNDLE_DIR="build/${APP_NAME}.app"
BUNDLE_CONTENTS="${BUNDLE_DIR}/Contents"
EXECUTABLE="main"
SRC_DIR="src"
BUNDLE_FILE="${APP_NAME}.bundle"
ICONS_DIR="assets"

# Create the app bundle structure
mkdir -p "${BUNDLE_CONTENTS}/MacOS"
mkdir -p "${BUNDLE_CONTENTS}/Resources"
mkdir -p "${BUNDLE_CONTENTS}/Frameworks"

# Copy the executable
cp "build/${EXECUTABLE}" "${BUNDLE_CONTENTS}/MacOS/"

# Copy icon file if exists
cp "${ICONS_DIR}/icon.icns" "${BUNDLE_CONTENTS}/Resources/" 

# Create the Info.plist file
cat <<EOF > "${BUNDLE_CONTENTS}/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundleDisplayName</key>
    <string>${APP_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>com.savaughn.${APP_NAME}</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>CFBundleIconFile</key>
    <string>icon.icns</string>
    <key>CFBundleExecutable</key>
    <string>launcher.sh</string>
    <key>CFBundleIconFile</key>
    <string>icon.icns</string> 
</dict>
</plist>
EOF

# Create the launcher script
cat <<EOF > "${BUNDLE_CONTENTS}/MacOS/launcher.sh"
#!/bin/bash

# Set up environment variables needed for GTK applications
export GTK_PATH="\$(dirname "\$0")/../Frameworks"
export DYLD_LIBRARY_PATH="\$GTK_PATH:\$DYLD_LIBRARY_PATH"

# Default MacOS backend (Quartz)
# Execute the main application
exec "\$(dirname "\$0")/main" "\$@"
EOF

# Copy GTK and other dependencies
HOMEBREW_PREFIX="$(brew --prefix)"
GTK_ROOT="${HOMEBREW_PREFIX}/opt/gtk4"

cp -RL "${HOMEBREW_PREFIX}/lib/libgobject-2.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libglib-2.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${GTK_ROOT}/lib/libgtk-4.1.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libcairo.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libpangocairo-1.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libpango-1.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libharfbuzz.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libgdk_pixbuf-2.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libcairo-gobject.2.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libgraphene-1.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libgio-2.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libgobject-2.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libglib-2.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libintl.8.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libcairo.2.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libjansson.4.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libpng16.16.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libfontconfig.1.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libfreetype.6.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libx11.6.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
# libXext.6.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libXext.6.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libXrender.1.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libXrender.1.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
# libxcb.1.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libxcb.1.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libxcb-render.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libxcb-shm.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libpixman-1.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
cp -RL "${HOMEBREW_PREFIX}/lib/libgmodule-2.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libjpeg.8.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libjpeg.8.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libtiff.6.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libtiff.6.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libgraphite2.3.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libgraphite2.3.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libfribidi.0.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libfribidi.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libpangooft2-1.0.0.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libpangoft2-1.0.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libharfbuzz-gobject.0.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libharfbuzz-gobject.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libharfbuzz-subset.0.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libharfbuzz-subset.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libepoxy.0.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libepoxy.0.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libcairo-script-interpreter.2.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libcairo-script-interpreter.2.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#liblzo2.2.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/liblzo2.2.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libzstd.1.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libzstd.1.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libXau.6.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libXau.6.dylib" "${BUNDLE_CONTENTS}/Frameworks/"
#libXdcmp.6.dylib
cp -RL "${HOMEBREW_PREFIX}/lib/libXdmcp.6.dylib" "${BUNDLE_CONTENTS}/Frameworks/"

install_name_tool -change "${GTK_ROOT}/lib/libgtk-4.1.dylib" @executable_path/../Frameworks/libgtk-4.1.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libpangocairo-1.0.0.dylib" @executable_path/../Frameworks/libpangocairo-1.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libgobject-2.0.dylib" @executable_path/../Frameworks/libgobject-2.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libglib-2.0.dylib" @executable_path/../Frameworks/libglib-2.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libcairo.dylib" @executable_path/../Frameworks/libcairo.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libpango-1.0.0.dylib" @executable_path/../Frameworks/libpango-1.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libharfbuzz.0.dylib" @executable_path/../Frameworks/libharfbuzz.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libgdk_pixbuf-2.0.0.dylib" @executable_path/../Frameworks/libgdk_pixbuf-2.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libcairo-gobject.2.dylib" @executable_path/../Frameworks/libcairo-gobject.2.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libgraphene-1.0.0.dylib" @executable_path/../Frameworks/libgraphene-1.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libgio-2.0.0.dylib" @executable_path/../Frameworks/libgio-2.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libgobject-2.0.0.dylib" @executable_path/../Frameworks/libgobject-2.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libglib-2.0.0.dylib" @executable_path/../Frameworks/libglib-2.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libintl.8.dylib" @executable_path/../Frameworks/libintl.8.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libcairo.2.dylib" @executable_path/../Frameworks/libcairo.2.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libjansson.4.dylib" @executable_path/../Frameworks/libjansson.4.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libpng16.16.dylib" @executable_path/../Frameworks/libpng16.16.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libfontconfig.1.dylib" @executable_path/../Frameworks/libfontconfig.1.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libfreetype.6.dylib" @executable_path/../Frameworks/libfreetype.6.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libx11.6.dylib" @executable_path/../Frameworks/libx11.6.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libXext.6.dylib" @executable_path/../Frameworks/libXext.6.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libXrender.1.dylib" @executable_path/../Frameworks/libXrender.1.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libxcb.1.dylib" @executable_path/../Frameworks/libxcb.1.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libxcb-render.0.dylib" @executable_path/../Frameworks/libxcb-render.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libxcb-shm.0.dylib" @executable_path/../Frameworks/libxcb-shm.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libpixman-1.0.dylib" @executable_path/../Frameworks/libpixman-1.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libgmodule-2.0.0.dylib" @executable_path/../Frameworks/libgmodule-2.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libjpeg.8.dylib" @executable_path/../Frameworks/libjpeg.8.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libtiff.6.dylib" @executable_path/../Frameworks/libtiff.6.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libgraphite2.3.dylib" @executable_path/../Frameworks/libgraphite2.3.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libfribidi.0.dylib" @executable_path/../Frameworks/libfribidi.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libpangoft2-1.0.0.dylib" @executable_path/../Frameworks/libpangoft2-1.0.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libharfbuzz-gobject.0.dylib" @executable_path/../Frameworks/libharfbuzz-gobject.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libharfbuzz-subset.0.dylib" @executable_path/../Frameworks/libharfbuzz-subset.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libepoxy.0.dylib" @executable_path/../Frameworks/libepoxy.0.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libcairo-script-interpreter.2.dylib" @executable_path/../Frameworks/libcairo-script-interpreter.2.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/liblzo2.2.dylib" @executable_path/../Frameworks/liblzo2.2.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libzstd.1.dylib" @executable_path/../Frameworks/libzstd.1.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libXau.6.dylib" @executable_path/../Frameworks/libXau.6.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"
install_name_tool -change "${HOMEBREW_PREFIX}/lib/libXdmcp.6.dylib" @executable_path/../Frameworks/libXdmcp.6.dylib "${BUNDLE_CONTENTS}/MacOS/${EXECUTABLE}"

# make launcher.sh executable
chmod +x "${BUNDLE_CONTENTS}/MacOS/launcher.sh"

rm -rf build/main

# Final message
echo "Bundle created at: ${BUNDLE_DIR}"

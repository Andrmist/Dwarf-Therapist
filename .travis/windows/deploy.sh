#!/bin/bash

# Compile Qt style plugins
for plugin in fusiondark DarkStyle; do
    git clone https://github.com/cvuchener/$plugin
    cd $plugin
    cmd //C $TRAVIS_BUILD_DIR/.travis/windows/build_plugin.bat $QT_PREFIX
    cd -
done

dest=DwarfTherapist-${TRAVIS_TAG}-${QT_ARCH%%_*}
mkdir $dest

cp "$TRAVIS_BUILD_DIR/build/Release/DwarfTherapist.exe" "$dest/"
"$QT_PREFIX/bin/windeployqt.exe" "$dest/DwarfTherapist.exe"

cp "$TRAVIS_BUILD_DIR/README.rst" "$dest/"
cp "$TRAVIS_BUILD_DIR/LICENSE.txt" "$dest/"
cp "$TRAVIS_BUILD_DIR/CHANGELOG.txt" "$dest/"
cp "$TRAVIS_BUILD_DIR/build/lnp/manifest.json" "$dest/"

cp -R "$TRAVIS_BUILD_DIR/share" "$dest/data"

mkdir "$dest/doc"
cp "Dwarf Therapist.pdf" "$dest/doc/"

# TODO openssl dlls

7z a "$dest.zip" "$dest/"

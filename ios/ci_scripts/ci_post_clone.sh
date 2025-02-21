#!/bin/sh

# Change working directory to the root of your cloned repo.
cd $CI_PRIMARY_REPOSITORY_PATH

set -ex

# Install Flutter using git.
curl -sL https://github.com/flutter-actions/setup-flutter/releases/download/v4.0.0/setup-flutter.sh | bash
export PATH="$PATH:$HOME/flutter/bin"
echo "Flutter version: $(flutter --version)"

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
echo "Installing Flutter dependencies"
flutter pub get

# Install CocoaPods using Homebrew.
echo "Installing CocoaPods"
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods
echo "CocoaPods version: $(pod --version)"

# Install CocoaPods dependencies.
cd ios && pod install

exit 0
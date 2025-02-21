#!/bin/sh

# Change working directory to the root of your cloned repo.
cd $CI_PRIMARY_REPOSITORY_PATH

# Install Flutter using git.
curl -sL https://github.com/flutter-actions/setup-flutter/releases/download/v4.0.0/setup-flutter.sh | bash
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

# Install CocoaPods dependencies.
cd ios && pod install

exit 0
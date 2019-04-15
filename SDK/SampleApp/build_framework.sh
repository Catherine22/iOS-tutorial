echo "Start to build iOS SDK framework"

# environment variables
BUNDLE_ID="com.cbb.myproject.sdk"

## targets
TARGET_APP="SampleApp"

## build configurations
DEBUG_CONFIGURATION="Debug"
RELEASE_CONFIGURATION="Release"

## schemes
APP_SCHEME="SampleApp"
SDK_SCHEME="SDK"

# constants
BUILD_DIR=`pwd`
OUTPUT_DIR=`pwd`/output/

# print configuration
xcodebuild -list
/usr/bin/xcodebuild -version
swift --version
xcodebuild -list -project SampleApp.xcodeproj

# clean junk files
rm -rf output
mkdir output


# install CocoaPods


# update Info.plist via PlistBuddy
cd SDK
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier ${BUNDLE_ID}" Info.plist


# refer to https://medium.com/@marksiu/how-to-build-ios-project-with-command-82f20fda5ec5
# Clean Project or Workspace with scheme
cd ..
xcodebuild clean -project ${TARGET_APP}.xcodeproj -scheme ${APP_SCHEME}

# build a new framework
xcodebuild build -target ${TARGET_APP}.xcodeproj -configuration ${RELEASE_CONFIGURATION} -scheme ${SDK_SCHEME} -sdk iphoneos12.1 BUILD_DIR=${OUTPUT_DIR} BUILD_ROOT=${BUILD_DIR}
xcodebuild build -target ${TARGET_APP}.xcodeproj -configuration ${RELEASE_CONFIGURATION} -scheme ${SDK_SCHEME} -sdk iphonesimulator12.1 BUILD_DIR=${OUTPUT_DIR} BUILD_ROOT=${BUILD_DIR}

echo "Done"

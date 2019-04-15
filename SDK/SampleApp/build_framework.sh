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
OUTPUT_DIR="output"

# print configuration
xcodebuild -list
/usr/bin/xcodebuild -version
swift --version
xcodebuild -list -project SampleApp.xcodeproj

# clean junk files
rm -rf ${OUTPUT_DIR}
mkdir ${OUTPUT_DIR}
# install CocoaPods


# update Info.plist via PlistBuddy
cd ${SDK_SCHEME}
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier ${BUNDLE_ID}" Info.plist


# refer to https://medium.com/@marksiu/how-to-build-ios-project-with-command-82f20fda5ec5
# Clean Project or Workspace with scheme
cd ..
xcodebuild clean -project ${TARGET_APP}.xcodeproj -scheme ${APP_SCHEME}

# build a new framework (debug)
xcodebuild build -target ${TARGET_APP}.xcodeproj -configuration ${DEBUG_CONFIGURATION} -scheme ${SDK_SCHEME} -sdk iphoneos12.1 BUILD_DIR=${BUILD_DIR}/${OUTPUT_DIR}/ BUILD_ROOT=${BUILD_DIR} THE_KEY=Info.plist
xcodebuild build -target ${TARGET_APP}.xcodeproj -configuration ${DEBUG_CONFIGURATION} -scheme ${SDK_SCHEME} -sdk iphonesimulator12.1 BUILD_DIR=${BUILD_DIR}/${OUTPUT_DIR}/ BUILD_ROOT=${BUILD_DIR} THE_KEY=Info.plist

# merge iPhone and simulator frameworks (debug)
cd ${OUTPUT_DIR}
lipo -create ${DEBUG_CONFIGURATION}-iphoneos/${SDK_SCHEME}.framework/${SDK_SCHEME}  ${DEBUG_CONFIGURATION}-iphonesimulator/${SDK_SCHEME}.framework/${SDK_SCHEME} -output ${SDK_SCHEME}

mkdir ${SDK_SCHEME}.framework
cp -r ${DEBUG_CONFIGURATION}-iphoneos/${SDK_SCHEME}.framework `pwd`/${SDK_SCHEME}.framework

mv ${SDK_SCHEME} ${SDK_SCHEME}.framework/
echo "Done"

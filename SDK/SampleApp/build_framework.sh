echo "Start to build iOS SDK framework"

# environment variables
BUNDLE_ID="com.cbb.myproject.sdk"

## targets
TARGET_APP="SampleApp"

## build configurations
DEBUG_CONFIGURATION="Debug"
RELEASE_CONFIGURATION="Release"
declare -a configs
if [ "$#" = "0" ]
then
    echo "Using default settings"
else
  count=0
  for argu in "$@"
  do
    if [ \( "$argu" = ${DEBUG_CONFIGURATION} \) -o \( "$argu" = ${RELEASE_CONFIGURATION} \) ]
    then
      configs[count]="$argu"
      count=${count}+1
    fi
  done
fi

if [ "${#configs[@]}" = "0" ]
then
  configs=(${DEBUG_CONFIGURATION} ${RELEASE_CONFIGURATION})
fi
echo Configurations: [${configs[*]}]

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
xcodebuild -list -project ${TARGET_APP}.xcodeproj

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

for config in "${configs[@]}"
do
  # build a new framework
  xcodebuild build -target ${TARGET_APP}.xcodeproj -configuration $config -scheme ${SDK_SCHEME} -sdk iphoneos12.1 BUILD_DIR=${BUILD_DIR}/${OUTPUT_DIR}/ BUILD_ROOT=${BUILD_DIR} THE_KEY=Info.plist
  xcodebuild build -target ${TARGET_APP}.xcodeproj -configuration $config -scheme ${SDK_SCHEME} -sdk iphonesimulator12.1 BUILD_DIR=${BUILD_DIR}/${OUTPUT_DIR}/ BUILD_ROOT=${BUILD_DIR} THE_KEY=Info.plist

  # merge iPhone and simulator frameworks
  cd ${OUTPUT_DIR}
  lipo -create $config-iphoneos/${SDK_SCHEME}.framework/${SDK_SCHEME}  $config-iphonesimulator/${SDK_SCHEME}.framework/${SDK_SCHEME} -output $config-${SDK_SCHEME}

  mkdir $config-${SDK_SCHEME}.framework
  cp -r $config-iphoneos/${SDK_SCHEME}.framework $config-${SDK_SCHEME}.framework

  mv $config-${SDK_SCHEME} $config-${SDK_SCHEME}.framework/
  cd ..
done
echo "Done"

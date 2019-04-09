FRAMEWORK=AssistPayTest

BUILD=build
FRAMEWORK_PATH=AssistMobile.framework

# iOS
rm -Rf ./$BUILD
rm -f ./framework.tar.gz

xcodebuild archive -project ./AssistPayTest.xcodeproj -scheme AssistMobile -sdk iphoneos SYMROOT=$BUILD
xcodebuild build -project ./$FRAMEWORK.xcodeproj -target AssistMobile -sdk iphonesimulator SYMROOT=$BUILD

cp -RL ./$BUILD/Release-iphoneos ./$BUILD/Release-universal
cp -RL ./$BUILD/Release-iphonesimulator/$FRAMEWORK_PATH/Modules/AssistMobile.swiftmodule/* ./$BUILD/Release-universal/$FRAMEWORK_PATH/Modules/AssistMobile.swiftmodule

lipo -create ./$BUILD/Release-iphoneos/$FRAMEWORK_PATH/AssistMobile ./$BUILD/Release-iphonesimulator/$FRAMEWORK_PATH/AssistMobile -output ./$BUILD/Release-universal/$FRAMEWORK_PATH/AssistMobile

tar -czv -C $FRAMEWORK-iOS/$BUILD/Release-universal -f $FRAMEWORK-iOS.tar.gz $FRAMEWORK_PATH $FRAMEWORK_PATH.dSYM

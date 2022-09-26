#import "SecureAppSwitcherPlugin.h"
#if __has_include(<secure_app_switcher/secure_app_switcher-Swift.h>)
#import <secure_app_switcher/secure_app_switcher-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "secure_app_switcher-Swift.h"
#endif

@implementation SecureAppSwitcherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSecureAppSwitcherPlugin registerWithRegistrar:registrar];
}
@end

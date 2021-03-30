#import "FlutterSharePlugin.h"
#import <whatsapp_share/whatsapp_share-Swift.h>

@implementation FlutterSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSharePlugin registerWithRegistrar:registrar];
}
@end

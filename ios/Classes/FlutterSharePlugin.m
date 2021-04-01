#import "WhatsappShare.h"
#import <whatsapp_share/whatsapp_share-Swift.h>

@implementation WhatsappShare
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWhatsappShare registerWithRegistrar:registrar];
}
@end

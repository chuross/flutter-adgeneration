#import "ChrAdgenerationPlugin.h"
#import <chr_adgeneration/chr_adgeneration-Swift.h>

@implementation ChrAdgenerationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftChrAdgenerationPlugin registerWithRegistrar:registrar];
}
@end

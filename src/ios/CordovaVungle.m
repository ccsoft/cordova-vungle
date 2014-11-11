#import "CordovaVungle.h"

@implementation CordovaVungle
    
- (void) init:(CDVInvokedUrlCommand*)command {
    NSString* vungleId = nil;
    if([command.arguments count] > 0 && [command.arguments objectAtIndex:0] != (id)[NSNull null]) {
        vungleId = [command.arguments objectAtIndex:0];
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no appId sent to init"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    VungleSDK* sdk = [VungleSDK sharedSDK];
    // start vungle publisher library
    [sdk startWithAppId:vungleId];
    [sdk setDelegate:self];
    
    NSLog(@"Vungle SDK: %@", VungleSDKVersion);
        
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
    
- (void)dealloc {
  [[VungleSDK sharedSDK] setDelegate:nil];
}
    
- (void) playAd:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    if(self.viewController == nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no view to use"];
    }
    else {
        [[VungleSDK sharedSDK] playAd:self.viewController];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isVideoAvailable:(CDVInvokedUrlCommand*)command
{
    bool result = [[VungleSDK sharedSDK] isCachedAdAvailable];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:result];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
    
@end

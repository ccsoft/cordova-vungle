#import "CordovaVungle.h"

@implementation CordovaVungle

static UIViewController* viewController = nil;
static NSString* mCallbackId = nil;
static BOOL mPlayedVideoFully = FALSE;
    
+ (void) init: (UIViewController*)vc appId:(NSString*)appId {
    viewController = vc;
    VGUserData*  data  = [VGUserData defaultUserData];
    
    // set up config data
    //    data.age             = 36;
    //    data.gender          = VGGenderFemale;
    data.adOrientation   = VGAdOrientationPortrait;
    data.locationEnabled = FALSE;
    
    // start vungle publisher library
    [VGVunglePub startWithPubAppID:appId userData:data];
    [VGVunglePub allowAutoRotate:TRUE];
    [VGVunglePub logToStdout:TRUE];
    // [VGVunglePub (BOOL)setCustomCountDownText:(NSString*)text];
    // [VGVunglePub (void)alertBoxWithTitle:(NSString*)title Body:(NSString*)body leftButtonTitle:(NSString*)button1 rightButtonTitle:(NSString*)button2];
    
}
    
+ (void) exit {
    [VGVunglePub stop];
}
    
- (void) displayAdvert:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    if(viewController == nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no view to use"];
    }
    else {
        [VGVunglePub playModalAd:viewController animated:TRUE];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:1];
    }
        
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
    
- (void) displayIncentivizedAdvert:(CDVInvokedUrlCommand*)command
{
    if(viewController == nil) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parse installation found"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else {
        mCallbackId = [[NSString alloc] initWithString:command.callbackId];
        NSString* hrid = [command.arguments objectAtIndex:0];
        [VGVunglePub setDelegate:self];
        [VGVunglePub playIncentivizedAd:viewController animated:TRUE showClose:TRUE userTag:hrid];
    }
}

- (void) isVideoAvailable:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
	bool result = [VGVunglePub adIsAvailable];
    
    if (result) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:1];
    } else { 
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no video"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
    
// // VGVunglePubDelegate functions
    
- (void)vungleMoviePlayed:(VGPlayData*)playData
{
    mPlayedVideoFully = playData.playedFull;
    //NSLog(@"movie played call");
}
    
- (void)vungleAppStoreWillAppear
{
}

- (void)vungleAppStoreViewDidDisappear
{
}

- (void)vungleViewDidDisappear:(UIViewController*)viewController willShowProductView:(BOOL)willShow
{
    CDVPluginResult* pluginResult = nil;
    if(mPlayedVideoFully) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:1];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:0];
    }
    
    if(mCallbackId != nil) {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:mCallbackId];
    }
}

- (void)vungleViewWillAppear:(UIViewController*)viewController
{
    mPlayedVideoFully = FALSE;
}
    
@end

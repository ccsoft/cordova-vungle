#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <vunglepub/vunglepub.h>

@interface CordovaVungle : CDVPlugin<VGVunglePubDelegate> {

}

+ (void) init:(UIViewController*)vc appId:(NSString*)appId;
+ (void) exit;
    
- (void) displayAdvert:(CDVInvokedUrlCommand*)command;
- (void) displayIncentivizedAdvert:(CDVInvokedUrlCommand*)command;
- (void) isVideoAvailable:(CDVInvokedUrlCommand*)command;
   
// VGVunglePubDelegate
- (void)vungleMoviePlayed:(VGPlayData*)playData;
/*
- (void)vungleStatusUpdate:(VGStatusData*)statusData;
*/
- (void)vungleViewDidDisappear:(UIViewController*)viewController willShowProductView:(BOOL)willShow;
- (void)vungleViewWillAppear:(UIViewController*)viewController;

- (void)vungleAppStoreWillAppear;
- (void)vungleAppStoreViewDidDisappear;

@end

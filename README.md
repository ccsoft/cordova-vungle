cordova-vungle
=====================

Cordova plugin to use Vungle ad network.

We have tested with the following Vungle libraries

* Android 3.2.2
* iOS 3.0.10

##Installing the plugin
To add this plugin just type:
```cordova plugin add https://github.com/ccsoft/cordova-vungle.git```

To remove this plugin type:
```cordova plugin remove com.ccsoft.plugin.CordovaVungle```

###Android
On Android, plugin does most of the prerequisites automatically, arranges permissions, etc. in AndroidManifest.xml. It also installs google-playservices as a dependency.

#### Libs
You should only download and add Vungle libraries.
As of version 3.2.0, here are the libs.

* dagger-[version].jar
* javax.inject-[version].jar
* nineoldandroids-[version].jar
* support-v4-[version].jar 
* vungle-publisher-[version].jar

Note: If you already have support-v4 lib in your project, just use the most recent one (and delete the old one from your project).

#### Each Activity
Also, you should add these manually since plugin mechanism cannot do it:

Override the `onPause` and `onResume` methods in each `Activity` (including the first) to notify the Publisher SDK when your application gains or loses focus:

```java
import com.vungle.publisher.VunglePub;

public class EachActivity extends android.app.Activity {

  // get the VunglePub instance
  final VunglePub vunglePub = VunglePub.getInstance();

  ...
  
  @Override
  protected void onPause() {
      super.onPause();
      vunglePub.onPause();
  }
  
  @Override
  protected void onResume() {
      super.onResume();
      vunglePub.onResume();
  }
}
```

##Usage
The plugin has the following methods:
* [init](#init)
* [playAd](#playAd)
* [isVideoAvailable](#isVideoAvailable)

*** 

###init
Initializes the plugin. Must be called before calling any other function.

>####parameters

>> *vungleId*: string: Your Vungle app id.

>> *config*: object: Optional vungle config params as json object, see below for details. You do NOT need to supply all the params, defaults are used if a property is not supplied.
See: https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-advanced-settings.md

>> *successCallback*: function

>> *failureCallback*: function: Called with failure reason string.
         
>####example

	plugin.init('YOUR_VUNGLE_ID', {
            /* These are all the properties we support, they are here for demonstration purposes only.
            orientation: 0, // 0 means Orientation.autoRotate, 1 means Orientation.matchVideo
            soundEnabled: true,
            backButtonImmediatelyEnabled: false,
            immersiveMode: false,
            incentivized: false, 
            incentivizedUserId: '',
            incentivizedCancelDialogTitle: '',
            incentivizedCancelDialogBodyText: '',
            incentivizedCancelDialogCloseButtonText: '',
            incentivizedCancelDialogKeepWatchingButtonText: '',
            placement: '',
            extra1: '',
            extra2: '',
            extra3: '',
            extra4: '',
            extra5: '',
            extra6: '',
            extra7: '',
            extra8: '' */
        }
		function() { // success
			console.log("We got vungle");			
	}), failureCallback);

***

###playAd

>####parameters

>> *config*: object: Optional vungle config params as json object, see init for details

>> *successCallback*: function

>> *failureCallback*: function: Called with failure reason string.
         
>####example

	plugin.playAd(config
		function() { // success
			console.log("Ad played");		
	}), failureCallback);

***

###isVideoAvailable

>####parameters

>> *successCallback*: function: Called with a boolean value 

>> *failureCallback*: function: Called with failure reason string.
         
>####example

	plugin.isVideoAvailable(
		function(response) { // success
            if(response)
			    console.log("We have an ad available.");		
	}), failureCallback);

***
##Versions
Tested with Cordova 3.6.3

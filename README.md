# iOS Development Tutorial

# Resolution
If we want to display beautiful, then we need to ensure that the resolution is height
- Pixel (Pix-El, Picture Element)       
- Point     
- ppi - e.g. 72 ppi = 72 pixels per inch       

**1 Inch = 72 Point**       
1x: In normal screens, 1 pixel = 1 point.       
2x: In Retina screens, 4 pixels = 1 point.      
3x: 9 pixels = 1 point.
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/resolution.png)  

## Auto Layout
[See More](https://github.com/Catherine22/iOS-tutorial/blob/master/AutoLayout.md)

# Create Classes and Objects from Scratch
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/scratch.png)

# Useful tools
- Xcode   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/Xcode.png)        
- [Scale images from mobile development](https://appicon.co/#image-sets)        
- [Flat UI colors](https://flatuicolors.com/)      
- [Canva](https://www.canva.com/)         

# Sideloading
Install your apps on your physical iPhone for free.     

### Settings
1. Ensure your Xcode version matches with your iOS version on your iPhone. E.g. Xcode 10.**0** -> iOS 12.**0**, Xcode 10.**1** -> iOS 12.**1**      
2. Go to Xcode, you need:       
    - A unique bundle identifier
    - "Automatically manage signing" is ticked
    - Create a team     
    - Go to Product -> Destination -> Choose your device        
3. Run the app on your iPhone       
4. On your iPhone, go to Settings -> General -> Device Management -> Trust      
5. Run the app on your iPhone again

### Debugging wirelessly through the air        
1. Have your iPhone plug in through USB     
2. Go to Window -> Devices and Simulators -> Find your phone and select "Connect via network"
3. Unplug yor phone     
4. Run the app on your iPhone

# CocoaPods
[https://cocoapods.org/](https://cocoapods.org/)    
CocoaPods is what's known as dependency manager for Xcode project.

1. Install CocoaPods on your computer
```
$sudo gem install cocoapods
```
```
$pod setup --verbose
```

2. Install new pods in my Xcode project   
Go to your Xcode project, e.g. /Users/user/Workspace/Clima-iOS12/, initialise CocoaPods.
```
$pod init
```

3. You have a Podfile now. Open it by Xcode
```
$open -a Xcode Podfile
```

## Podfile
In Ruby, we don't use ```{}``` as code block, instead, we use
```Ruby
do

end
```

Add CocoaPods, the Pods we will use for our app
```Ruby
do
  pod 'SwiftyJSON'
  pod 'Alamofire'
  pod 'SVProgressHUD'
end
```

Check the current version of CocoaPods
```
$pod --version
```

Fix for CocoaPods v1.0.1 and below, add the following code in your Podfile
```Ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
```

Install all the CocoaPods that we specified earlier in our Podfile
```
$pod install
```

Open xcworkspace file instead which contains all of our CocoaPods.

[Podfile example](https://github.com/Catherine22/iOS-tutorial/Clima-iOS12/Podfile)

# The anatomy of an app
![MVC](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/MVC.png)       

- View: What you see or what appear on the screen.      
- ViewController: This goes behind the scene. This is the code that controls what should happen when the user taps a button, or what will happen when you have a piece of data to display on screen.        
- Model: Model is what controls the data. It manipulates the data and prepares the date to be served up to the ViewController.

# Coding Style
![Sections](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/sections.png)   
We can separate our code into describe sections by adding
```Swift
//MARK: - Networking
/***************************************************************/



//MARK: - JSON Parsing
/***************************************************************/



```

# Delegation
Let's say there's a property data in B, and we are going to pass data from class A to class B, the easiest way is to create an instance of B.
```Swift
class A {
  let b = B()
  b.data = "xxx"
}
```

But what if we cannot access properties in class A which is provided by Apple lick ```UIButton```, ```CoreLocation``` and so forth? For example, once the ```LocationManager``` has found the user's current location, it will send out an address, and how do we pass that address from the ```LocationManager``` (class A) into our own ```ViewController``` (class B)?   

That's what delegation comes in.    

Once the ```LocationManager``` finds a location, it will send it out to the delegation, if the delegation happens to be nil, then nothing happens to the information. But if the delegation happens to be sat, it will handle the data from the ```LocationManager```.

# Applications
- [I Am Rich](https://github.com/Catherine22/iOS-tutorial/tree/master/I%20Am%20Rich), [I Am Poor](https://github.com/Catherine22/iOS-tutorial/tree/master/I%20Am%20Poor)    
- [Magic8Ball](https://github.com/Catherine22/iOS-tutorial/tree/master/Magic8Ball), [Dicee](https://github.com/Catherine22/iOS-tutorial/tree/master/Dicee)    
  - Random number   
  - AutoLayout    
- [Quizzler](https://github.com/Catherine22/iOS-tutorial/tree/master/Quizzler-iOS12), [Destini](https://github.com/Catherine22/iOS-tutorial/tree/master/Destini-iOS12)    
  - MVC   
  - ProgressHUD   
  - Alert   
- [Xylophone](https://github.com/Catherine22/iOS-tutorial/tree/master/Xylophone-iOS12/Xylophone)    
  - Play wav audio    
  - ```do catch```    
- [Stack View Practice](https://github.com/Catherine22/iOS-tutorial/tree/master/Stack%20View%20Practice), [Auto Layout Practice](https://github.com/Catherine22/iOS-tutorial/tree/master/Auto-Layout-Practice)   
  - AutoLayout    
  - Stack View    
- [Clima](https://github.com/Catherine22/iOS-tutorial/tree/master/Clima-iOS12/Clima)    
  - Ask for permissions
  - Geo Location    
  - Delegation    
  - Fetching data via ```Alamofire``` and handling JSON by ```SwiftyJSON```


# Tips
### Ask the user for permissions   
For example, Location Permissions.
```Swift
let locationManager = CLLocationManager()
override func viewDidLoad() {
  super.viewDidLoad()

  locationManager.delegate = self
  locationManager.requestWhenInUseAuthorization();
}
```
In Info.plist,     
![info.plist](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/Info_plist1.png)

**Update Locations**
```Swift
// Asynchronous method (It works in the background), call didUpdateLocations and didFailWithError methods to handle callbacks
locationManager.startUpdatingLocation()
```

```Swift
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  // the laster the more accurate
  let location = locations[locations.count - 1]
  // Accuracy means the spread of possible locations.
  // When that value is negative, that represents an invalid result
  if (location.horizontalAccuracy > 0) {
    // Unless you want to destroy users' battery, you should stop updating locations as soon as you get the valid data
    locationManager.stopUpdatingLocation()
    print("(\(location.coordinate.longitude), \(location.coordinate.latitude))")
  }
}

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
  // Location unavailable
  print(error)
}
```

If you get ```Error Domain=kCLErrorDomain Code=0 "(null)"``` error, 2 solutions to fix this:    
1. Run on an iPhone device    
2. In your simulator, click Debug - Location, select Apple's headquarter or Custom Location

### Load data from HTTP URLs   

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSExceptionDomains</key>
  <dict>
    <key>openweathermap.org</key>
    <dict>
      <key>NSIncludesSubdomains</key>
      <true/>
      <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
      <true/>
    </dict>
  </dict>
</dict>
```
![info.plist](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/Info_plist2.png)

# Swift
[Tutorial](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground)

# Course
[Swift.org](https://swift.org/getting-started/)     
[iOS 12 & Swift - The Complete iOS App Development Bootcamp](https://www.udemy.com/ios-12-app-development-bootcamp/)        
[Apple human interface guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/)       

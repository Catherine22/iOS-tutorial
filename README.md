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

[Podfile example](https://github.com/Catherine22/iOS-tutorial/Clima-iOS12/Podfile)

# The anatomy of an app
![MVC](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/MVC.png)       

- View: What you see or what appear on the screen.      
- ViewController: This goes behind the scene. This is the code that controls what should happen when the user taps a button, or what will happen when you have a piece of data to display on screen.        
- Model: Model is what controls the data. It manipulates the data and prepares the date to be served up to the ViewController.

# Course
[Swift.org](https://swift.org/getting-started/)     
[iOS 12 & Swift - The Complete iOS App Development Bootcamp](https://www.udemy.com/ios-12-app-development-bootcamp/)        
[Apple human interface guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/)       

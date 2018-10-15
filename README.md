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
- xcode   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/xcode.png)        
- [Scale images from mobile development](https://appicon.co/#image-sets)        
- [Flat UI colors](https://flatuicolors.com/)      
- [Canva](https://www.canva.com/)         

# Sideloading
Install your apps on your physical iPhone for free.     

### Settings
1. Ensure your xcode version matches with your iOS version on your iPhone. E.g. xcode 10.**0** -> iOS 12.**0**, xcode 10.**1** -> iOS 12.**1**      
2. Go to xcode, you need:       
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

# The anatomy of an app
![MVC](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/MVC.png)       

- View: What you see or what appear on the screen.      
- ViewController: This goes behind the scene. This is the code that controls what should happen when the user taps a button, or what will happen when you have a piece of data to display on screen.        
- Model: Model is what controls the data. It manipulates the data and prepares the date to be served up to the ViewController.

# Course
[Swift.org](https://swift.org/getting-started/)     
[iOS 12 & Swift - The Complete iOS App Development Bootcamp](https://www.udemy.com/ios-12-app-development-bootcamp/)        
[Apple human interface guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/)       

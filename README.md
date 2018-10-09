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
To get our view fit on different screens, we do     
1. Adjust views programmatically. For example,    
```swift
class ViewController: UIViewController {
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var diceeLogoView: UIImageView!
    @IBOutlet weak var rollView: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Resize
        let horizontalCenter = self.view.frame.width/2
        let sectionHeight = self.view.frame.height/4
        diceeLogoView.center = CGPoint(x: horizontalCenter, y: sectionHeight)
        diceImageView1.center = CGPoint(x: horizontalCenter/2, y: sectionHeight*2)
        diceImageView2.center = CGPoint(x: horizontalCenter*3/2, y: sectionHeight*2)
        rollView.center = CGPoint(x: horizontalCenter, y: sectionHeight*3.5)

    }
  }
```

2. Pinning
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout1.png)  

Steps:    
![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout1_1.png)  
(1) Open Objects Library and search for UIView, drag it onto the screen. Change the height and the width to 100 each and position it onto the centre of the screen.     
(2) In order to keep it in the middle, we are going to add some constrains.   
(3) Open pinning button, uncheck the "Constrain to margins" box, this means instead of setting constrains to the margins of the screen, we actually want to set it to the edges of the screen.    
(4) Hit the drop down button, you can either set a constrain to the Dicee logo or ***what we want instead is setting it to the top of the view.***    
(5) Click "Add 4 constrains" to make them active on my design.    

Your xcode should look like:
![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout1_2.png)  


3. Fix the size of views
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2.png)  
Steps:    
(1) Set the fixed height and width  ![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2_1.png)  
(2) Check "Horizontally in Container" and "Vertically in Container"  ![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2_2.png)    

Your xcode should look like:
![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2_3.png)  

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

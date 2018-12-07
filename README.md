# iOS Development Tutorial
[iOS 12 & Swift - The Complete iOS App Development Bootcamp](https://www.udemy.com/ios-12-app-development-bootcamp/)        

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

# Segues
For example, I'd like to click "next" button to navigate to another page. In this case, I need segues.    

1. Create a UIViewController with a "next" button   
2. Create another UIViewController by searching "uiviewcontroller" in the object libraries.   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/segue.png)    
3. Click ```⌃``` and the "next" button, drag to another UIViewController, select "show"    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/segue1.png)   
**Now when you click the Next button, it will jump to the second page**   

4. In order to customise the second page, go to File - New - File to create a new Cocoa Touch Class, named "SecondViewController"    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/segue2.png)   
5. Link the segue we just created to SecondViewController   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/segue3.png)   

# Navigation Controller
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/navigation_viewcontroller.png)  

## Create the Navigation Controller
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/navigation_viewcontroller1.png)  
1. Select the initial ViewController    
2. Editor - Embed in - Navigation Controller    

## Another way to trigger segues

1. Click ```⌃``` and the "View Controller" button, drag to another UIViewController, select "show"    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/segue4.png)   
2. Set ```IBAction``` of the Next button, and jump to another segue by calling ```performSegue```, select the segue to name Identifier    

```Swift
@IBAction func buttonPressed(_ sender: Any) {
  performSegue(withIdentifier: "GoToSecondScreen", sender: self)
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  if segue.identifier == "GoToSecondScreen" {
    // We are not allowed to create a ViewController Object regularly, like
    // let destinationVC = SecondViewController()
    // Instead, we do
    let destinationVC = segue.destination as! SecondViewController
    destinationVC.textPassedOver = textField.text
  }
}
```    
Who initialised the segue will be the ```sender```, which in this case, will be the ```ViewController```.   
(https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/segue5.png)   

# Protocol and Delegate
Inside the [Clima](https://github.com/Catherine22/iOS-tutorial/tree/master/Clima-iOS12/Clima) application, we have a ```ChangeCityDelegate``` delegate on the second ViewController.    
```Swift
protocol ChangeCityDelegate{
    func userEnteredANewCityName(name: String)
}
```

We also defined the delegate variable in the class   

```Swift
var delegate: ChangeCityDelegate?
```

While user clicks the button, sending data to the first ViewController and the second ViewController will be dismissed and go back to the first ViewController   

```Swift
if (delegate != nil) {
  delegate?.userEnteredANewCityName(name: city)
  // close this ViewController
  self.dismiss(animated: true, completion: nil)
}
```

# TableView
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/tableView4.png)   

1. Drag a TableView into your storyboard
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/tableView1.png)   

2. Create ```.xib``` file, and define the identifier and class    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/tableView2.png)   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/tableView3.png)   

3. The class example   
```swift
import UIKit

class CustomMessageCell: UITableViewCell {
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
    }
}
```

4. Import the TableView in the UIViewController   
```swift
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet var messageTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    //TODO: Set yourself as the delegate and datasource here:
    messageTableView.delegate = self
    messageTableView.dataSource = self

    //TODO: Register your MessageCell.xib file here:
    messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
  }

  //TODO: Declare cellForRowAtIndexPath here:
  // This message gets called for every single cell that exists inside the tableView
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
      let messageArray = ["First message", "Second message", "Third message"]
      cell.messageBody.text = messageArray[indexPath.row]
      return cell
  }


  //TODO: Declare numberOfRowsInSection here:
  // Specify how many cells you want and what cells you want to display
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
  }
}
```

5. Resize the cells. Let's say we want to reset the height
```swift
override func viewDidLoad() {
  super.viewDidLoad()

  //TODO: Set yourself as the delegate and datasource here:
  messageTableView.delegate = self
  messageTableView.dataSource = self

  //TODO: Register your MessageCell.xib file here:
  messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
  configureTableView()
}

//TODO: Declare configureTableView here:
func configureTableView() {
  messageTableView.rowHeight = UITableView.automaticDimension
  messageTableView.estimatedRowHeight = 120.0
}
```

# Create Classes and Objects from Scratch
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/scratch.png)

# Useful tools
- Xcode   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/xcode.png)        
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

[Podfile example](https://github.com/Catherine22/iOS-tutorial/blob/master/Clima-iOS12/Podfile)

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
func retrieveMessage() {
//TODO: Retrieve messages from Firebase

}


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
- [Segues](https://github.com/Catherine22/iOS-tutorial/tree/master/Segues)    
  - Segue example   
  - Navigation ViewController   
- [Delegates and Protocols](https://github.com/Catherine22/iOS-tutorial/tree/master/Delegates%20and%20Protocols)    
  - Pass data between View Controllers    
  - Segues    
- [Clima](https://github.com/Catherine22/iOS-tutorial/tree/master/Clima-iOS12/)    
  - Ask for permissions
  - Geo Location    
  - Delegation    
  - Fetching data via ```Alamofire``` and handling JSON by ```SwiftyJSON```   
- [BitcoinTicker](https://github.com/Catherine22/iOS-tutorial/tree/master/BitcoinTicker-iOS12/)   
  - UIPickerViewDelegate, UIPickerViewDataSource    
  - Fetching data via ```Alamofire``` and handling JSON by ```SwiftyJSON```   
- [FlashChat](https://github.com/Catherine22/iOS-tutorial/tree/master/Flash-Chat-iOS12)   
  - Authenticate with Firebase    
  - Firebase Realtime Database    
  - Completion Handler    
  - Navigation ViewController   
  - TableView   
  - Popup keyboard animation (UI Animations + UITextFieldDelegate + UITapGestureRecognizer)   
  - ```ProgressHUD``` (Loading + alert)   
  - Get more colours via ```ChameleonFramework```    
- [Todoey](https://github.com/Catherine22/iOS-tutorial/tree/master/Todoey)    
  - Persistent object array with ```UserDefaults```   


# Tips
### Breakpoint
1. Set breakpoints    
![Breakpoint1](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/breakpoint1.png)   

2. Step over    
![Breakpoint2](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/breakpoint2.png)   

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

### Completion Handler
Callback: Do something time consuming   

```Swift
class DataManager {
    func save(key: String, value: String, callback: (Bool, String) -> Void){
      // Do something time consuming
        let isSuccess = true
        let message = "\(key) saved"
        callback(isSuccess, message)
    }
}
```

```Swift
class MyViewController: UIViewController {

  func completion(isSuccess: Bool, message: String) {
    print("isSuccess:\(isSuccess), message:\(message)")
  }

  @IBAction func registerPressed(_ sender: AnyObject) {
    let dataManager = DataManager()
    dataManager.save(key: "name", value: "Nick", callback: completion)
  }
}
```

or
```Swift
let dataManager = DataManager()
dataManager.save(key: "name", value: "Nick") { (isSuccess, message) in
  print("isSuccess:\(isSuccess), message:\(message)")
}
```

### Persistent Local Data Storage

Persistent an array
```Swift
let defaults = UserDefaults.standard
defaults.set(0.24, forKey: "volumn")
defaults.set(true, forKey: "musicOn")
defaults.set("Alex", forKey: "playerName")
defaults.set(["musket", "helmet"], forKey: "weapons")
defaults.set(["id": "A001", "title": "kill Demogorgon"], forKey: "mission")
defaults.set(Date(), forKey: "appLastOpenedByUser")
```

Retrieve the array from the local storage (plist)
```Swift
if let volumn = defaults.float(forKey: "volumn") as? Float {
  print("volumn:\(volumn)")
}
if let musicOn = defaults.bool(forKey: "musicOn") as? Bool {
  print("musicOn:\(musicOn)")
}
if let playerName = defaults.string(forKey: "playerName") {
  print("playerName:\(playerName)")
}
if let appLastOpenedByUser = defaults.object(forKey: "appLastOpenedByUser") {
  print("appLastOpenedByUser:\(appLastOpenedByUser)")
}
if let weapons = defaults.array(forKey: "weapons") as? [String] {
  print("weapons:\(weapons)")
}
if let mission = defaults.dictionary(forKey: "mission") as? Dictionary<String, String> {
  print("mission:\(mission)")
}
```

To print the simulator path in AppDelegate
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    return true
}
```

We gonna get    
```
/Users/ryan/Library/Developer/CoreSimulator/Devices/C2161038-1255-44C0-88EA-E61BEDD0EDE3/data/Containers/Data/Application/E927D9CE-FAF9-4229-8D6A-2D2B82EBF832/Documents
```

And the plist file is going to be actually saved in    
```
/Users/ryan/Library/Developer/CoreSimulator/Devices/C2161038-1255-44C0-88EA-E61BEDD0EDE3/data/Containers/Data/Application/E927D9CE-FAF9-4229-8D6A-2D2B82EBF832/Library/Preferences/com.CBB.Todoey.plist
```

![Todoey plist](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/todoey_plist.png)

> Notice: Object array is not allowed to persistent in local storage directly. Converting the data to JSON String could solve it.

The 
# Command Game
```
$emacs -batch -l dunnet
```

# Swift
[Tutorial](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground)

# Reference
[Swift.org](https://swift.org/getting-started/)     
[iOS 12 & Swift - The Complete iOS App Development Bootcamp](https://www.udemy.com/ios-12-app-development-bootcamp/)        
[Apple human interface guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/)       

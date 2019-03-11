# iOS Development Tutorial
[iOS 12 & Swift - The Complete iOS App Development Bootcamp](https://www.udemy.com/ios-12-app-development-bootcamp/)      

# Navigation
- [Resolution](https://github.com/Catherine22/iOS-tutorial#resolution)    
  - [Auto Layout](https://github.com/Catherine22/iOS-tutorial#auto-layout)    
- [Segues](https://github.com/Catherine22/iOS-tutorial#segues)    
- [Navigation Controller](https://github.com/Catherine22/iOS-tutorial#navigation-controller)    
  - [Create the Navigation Controller](https://github.com/Catherine22/iOS-tutorial#create-the-navigation-controller)    
  - [Another way to trigger segues](https://github.com/Catherine22/iOS-tutorial#another-way-to-trigger-segues)    
- [Protocol and Delegate](https://github.com/Catherine22/iOS-tutorial#protocol-and-delegate)    
- [View](https://github.com/Catherine22/iOS-tutorial#view)    
  - [TableView](https://github.com/Catherine22/iOS-tutorial#tableview)    
  - [UISearchBar](https://github.com/Catherine22/iOS-tutorial#uisearchbar)    
- [Create Classes and Objects from Scratch](https://github.com/Catherine22/iOS-tutorial#create-classes-and-objects-from-scratch)    
- [Useful tools](https://github.com/Catherine22/iOS-tutorial#useful-tools)    
- [Sideloading](https://github.com/Catherine22/iOS-tutorial#sideloading)    
  - [Settings](https://github.com/Catherine22/iOS-tutorial#settings)    
  - [Debugging wirelessly through the air](https://github.com/Catherine22/iOS-tutorial#debugging-wirelessly-through-the-air)    
- [CocoaPods](https://github.com/Catherine22/iOS-tutorial#cocoapods)    
  - [Podfile](https://github.com/Catherine22/iOS-tutorial#podfile)    
- [Carthage](https://github.com/Catherine22/iOS-tutorial#carthage)    
- [The anatomy of an app](https://github.com/Catherine22/iOS-tutorial#the-anatomy-of-an-app)    
- [Coding Style](https://github.com/Catherine22/iOS-tutorial#coding-style)    
  - [MARK](https://github.com/Catherine22/iOS-tutorial#mark)    
  - [Extension](https://github.com/Catherine22/iOS-tutorial#extension)   
  - [Internal and external parameters](https://github.com/Catherine22/iOS-tutorial#internal-and-external-parameters)    
- [Delegation](https://github.com/Catherine22/iOS-tutorial#delegation)    
- [Applications](https://github.com/Catherine22/iOS-tutorial#applications)    
- [Tips](https://github.com/Catherine22/iOS-tutorial#tips)    
  - [Ask the user for permissions](https://github.com/Catherine22/iOS-tutorial#ask-the-user-for-permissions)    
  - [Completion Handler](https://github.com/Catherine22/iOS-tutorial#completion-handler)    
  - [Thread Handling](https://github.com/Catherine22/iOS-tutorial#thread-handling)    
- [6 ways to persistent Local Data Storage](https://github.com/Catherine22/iOS-tutorial#6-ways-to-persistent-local-data-storage)    
  - [UserDefaults](https://github.com/Catherine22/iOS-tutorial#userdefaults)    
  - [FileManager](https://github.com/Catherine22/iOS-tutorial#filemanager)    
- [Databases](https://github.com/Catherine22/iOS-tutorial#databases)    
  - [Core Data](https://github.com/Catherine22/iOS-tutorial#core-data)    
  - [Realm](https://github.com/Catherine22/iOS-tutorial#realm)    
- [Network Connection](https://github.com/Catherine22/iOS-tutorial#network-connection)    
  - [Alamofire](https://github.com/Catherine22/iOS-tutorial#alamofire)    
  - [URLSession](https://github.com/Catherine22/iOS-tutorial#urlsession)    
- [Machine Learning](https://github.com/Catherine22/iOS-tutorial#machine-learning)    
  - [Supervised Learning](https://github.com/Catherine22/iOS-tutorial#supervised-learning)    
  - [Unsupervised Learning](https://github.com/Catherine22/iOS-tutorial#unsupervised-learning)    
  - [CoreML](https://github.com/Catherine22/iOS-tutorial#coreml)    
- [Command Game](https://github.com/Catherine22/iOS-tutorial#command-game)    
- [Swift](https://github.com/Catherine22/iOS-tutorial#swift)    
- [Reference](https://github.com/Catherine22/iOS-tutorial#reference)    


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
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/segue5.png)   

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

# View
## TableView
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

## UISearchBar

### UISearchBar in UIViewController
[Example: CategorySheetFloatingPanel.swift](https://github.com/Catherine22/iOS-tutorial/blob/master/RealmExample/RealmExample/Controllers/CategorySheetFloatingPanel.swift)   

1. Drag a Search Bar in to main.storyboard    

2. Indicate the delegate    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/searchBar.png)    

3. Implement ```UISearchBarDelegate``` in our ViewController    
```Swift
extension TodoListViewController: UISearchBarDelegate {
    
    // This method will be triggered as "Enter" is typed
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//      queryData(text: searchBar.text!)
//    }

    // This method will be triggered as users are typing
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      // Do something as users clear the Search Bar
      if searchBar.text?.count == 0 {
        reloadData()
      } else {
        // Query data as users are typing to improve user experience.
        queryData(text: searchBar.text!)
      }
    }
}
```

### UISearchBar inside NavigationController
[Example: ItemViewController.swift](https://github.com/Catherine22/iOS-tutorial/blob/master/RealmExample/RealmExample/Controllers/ItemViewController.swift)   

1. Embed your UIViewController in Navigation Controller   
2. Implement delegates    
```Swift
class ItemViewController: UIViewController {

  var searchController : UISearchController!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Set searchBar inside NavigationController
    initUISearchController()
  }
}

extension ItemViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    // This method will be triggered as "Enter" is typed
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        updateTableView(text: searchBar.text!)
    //    }
    
    func initUISearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Reload all the data as users clear the Search Bar
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                // No longer have the cursor and also the keyboard should go away
                searchBar.resignFirstResponder()
            }
        } else {
            // Query data as users are typing to improve user experience.
        }
    }
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
Go to your Xcode project, e.g. /Users/catherine/Workspace/Clima-iOS12/, initialise CocoaPods.
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

# Carthage

1. Install Carthage   
```
$brew update
$brew install carthage
```

2. Create Cartfile file   
Create a file called Cartfile, paste needed libraries. E.g. SVProgressHUD, and save it to project folder   
```
github "watson-developer-cloud/swift-sdk"
github "SVProgressHUD/SVProgressHUD"
```

3. Run ```carthage update``` to install libraries   
4. Import all the libraries you needed (the file path will be in /Carthage/Build/iOS/xxx.framework)   
![Carthage](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/carthage.png)   


# The anatomy of an app
![MVC](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/MVC.png)       

- View: What you see or what appear on the screen.      
- ViewController: This goes behind the scene. This is the code that controls what should happen when the user taps a button, or what will happen when you have a piece of data to display on screen.        
- Model: Model is what controls the data. It manipulates the data and prepares the date to be served up to the ViewController.

# Coding Style
## MARK
![Sections](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/sections.png)   
We can separate our code into describe sections by adding
```Swift
//MARK: - Networking
func retrieveMessage() {
//TODO: Retrieve messages from Firebase

}


//MARK: - JSON Parsing



```

## Fold code block
```
⌘ + ⌥ + ←
```

## Extension
Instead of implement delegates directly, creating an ```extension```    
E.g. The original code might be:
```Swift
class TodoListViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    <#code#>
  }
}
```

Split up the functionality of our ViewController, and we can have specific parts that are responsible for specific things.    
```Swift
class TodoListViewController {
  
}

//MARK: - SearchBar methods
extension TodoListViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    <#code#>
  }
}
```

![Extension](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/extension.png)   

# Internal and external parameters

Let's say we have a function
```Swift
func fetchRequest(request: NSFetchRequest<MyTodoeyItem>) {
  do {
    itemArray = try context.fetch(request)
    } catch {
      print("Error fetching data from context \(error)")
    }
  }
```

Modify 'request' parameter with an external parameter.    
The external parameter is ```with``` whereas the internal parameter: ```request```.   
Instead of calling the ```fetchRequest``` function with ```fetchRequest(request: request)```, we are using    
```Swift
fetchRequest(with: request)
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
  - UITableView   
  - Popup keyboard animation (UI Animations + UITextFieldDelegate + UITapGestureRecognizer)   
  - ```ProgressHUD``` (Loading + alert)   
  - Get more colours via ```ChameleonFramework```    
- [CoreData Example](https://github.com/Catherine22/iOS-tutorial/tree/master/Todoey)    
  - Persistent standard types and object array with ```UserDefaults``` and ```CoreData``` respectively.   
  - Persistent data with CoreData.    
  - UISearchBar   
  - UITableView   
  - [Swift] Error handling (```guard else```, ```do catch``` and ```if try```)    
  - [Swift] Internal, external and default parameters (```loadItems``` in ```TodoListViewController```)    
  - [Swift] extension   
- [Todoey with Realm](https://github.com/Catherine22/iOS-tutorial/tree/master/RealmExample)    
  - Persistent data with Realm    
  - 2 ways to use UISearchBar (put UISearchBar inside NavigationController or UIViewController)   
  - UITableView   
  - [FloatingPanel](https://cocoapods.org/pods/FloatingPanel)   
  - [ChameleonFramework](https://cocoapods.org/pods/ChameleonFramework) gradient color + random flat color    
  - Customise NavigationController style   
- [Calculator](https://github.com/Catherine22/iOS-tutorial/tree/master/Calculator)    
  - Swift tips: struct, if-let statement and guard-let statement    
- [SeeFood](https://github.com/Catherine22/iOS-tutorial/tree/master/SeeFood)    
  - UIImagePickerController (Pick out images from users' photos or camera)   
  - CoreML (Machine learning)    
- [WhatFLower](https://github.com/Catherine22/iOS-tutorial/tree/master/WhatFLower)    
  - UIImagePickerController (Pick out images from users' photos or camera)   
  - CoreML (Machine learning)    
  - Display Web images via [SDWebImage](https://github.com/SDWebImage/SDWebImage)   
     

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

Another example, in order to launch users' camera or open their photo albums, you need ```Privacy - Camera Usage Description``` and ```Privacy - Photo Library Usage Description```.

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

### Thread Handling
Run on background thread: 
```swift
DispatchQueue.global(qos: .background).async {
  //do something
}
```

Run on main(UI) thread:
```swift
DispatchQueue.main.async {
  //do something
}
```

## 6 ways to persistent Local Data Storage
![databases](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/databases.png)    

### UserDefaults    

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

To print the simulator and application path in AppDelegate
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    return true
}
```

We gonna get    
```
/Users/catherine/Library/Developer/CoreSimulator/Devices/C2161038-1255-44C0-88EA-E61BEDD0EDE3/data/Containers/Data/Application/E927D9CE-FAF9-4229-8D6A-2D2B82EBF832/Documents
```

And the plist file is going to be actually saved in    
```
/Users/catherine/Library/Developer/CoreSimulator/Devices/C2161038-1255-44C0-88EA-E61BEDD0EDE3/data/Containers/Data/Application/E927D9CE-FAF9-4229-8D6A-2D2B82EBF832/Library/Preferences/com.CBB.Todoey.plist
```

![Todoey plist](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/todoey_plist.png)

> Notice: Object array is not allowed to persistent in local storage directly. Why not create our own plist by using ```FileManager```.    

### FileManager   

Initialise the file with a reasonable name
```Swift
let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
```

Make the object encodable
```Swift
import Foundation

class TodoeyItem: Encodable {
    var title: String
    var done: Bool

    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
```

Encode the item array and save
```Swift
do {
  let encoder = PropertyListEncoder()
  let data = try encoder.encode(self.itemArray)
  try data.write(to: dataFilePath!)
  } catch {
    print("Error encoding item array")
  }
```

Make the object decodable (```Encodabe``` + ```Decodable``` = ```Codable```)
```Swift
import Foundation

class TodoeyItem: Codable {
    var title: String
    var done: Bool

    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
```

Retrieve and decode the item array
```Swift
if let data = try? Data(contentsOf: dataFilePath!) {
  let decoder = PropertyListDecoder()
  do {
    itemArray = try decoder.decode([TodoeyItem].self, from: data)

    //Refresh the tableView
    self.tableView.reloadData()
    } catch {
      print("Error decoding item array, \(error)")
    }
} else {
  print("Error decoding item array")
}
```

Cp. The difference between UserDefaults and FileManager plist is the type of Root directory, and that's why UserDefaults is supposed to keep standard types rather than Object.
![UserDefaults plist](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/todoey_plist2.png)
![FileManager plist](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/todoey_plist3.png)   

## Databases

### Core Data

1. Create a new project with CoreData   
![CoreData](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/coreData0.png)    
Or paste the following code in [AppDelegate]    

```Swift
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "YOUR_DATA_MODEL_NAME")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
```

2. Add a Core Data model [DataModel]      
File -> New -> File, scroll to Core Data section    
![CoreData](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/coreData1.png)    

3. Match the file name to NSPersistentContainer in [AppDelegate]   
```Swift
let container = NSPersistentContainer(name: "DataModel")
```
You might get ```CoreData: error:  Failed to load model named xxx``` if you forget to update the name.    

4. Go to [DataModel], add a new Entity named ```MyTodoeyItem```    
![CoreData](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/coreData2.png)    

5. Add attributes and make them optional if you need    
![CoreData](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/coreData3.png)    


6. Change the module from 'Global namespace' to 'Current Product Module'
![CoreData](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/coreData4.png)   

7. (Optional) You could either skip this step by setting 'Class Definition' as default, or select Category/Extension in Codegen if you are going to customise your entities, i.e. You have to create classes that are identically named to you entities. 

Now you might notice that we essentially replace the TodoeyItem class with     
TodoeyItem class:   

```Swift
import Foundation

class TodoeyItem: Codable {
    var title: String
    var done: Bool
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
```


8. Save data (Class name refers to the entity name)    
```Swift
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let newItem = MyTodoeyItem(context: context)
newItem.title = content
newItem.done = false

itemArray.append(newItem)
do {
  try context.save()
} catch {
  if let error = error as NSError? {
    fatalError("Unresolved error \(error), \(error.userInfo)")
  }
}
```

9. Load data    
```Swift
import CoreData

class TodoListViewController: UITableViewController {
  var itemArray:[MyTodoeyItem] = []
  func loadItems() {
    do {
      let request: NSFetchRequest<MyTodoeyItem> = MyTodoeyItem.fetchRequest()
      itemArray = try context.fetch(request)
      } catch {
        print("Error fetching data from context \(error)")
      }
  }
}
```

10. Update data    
```Swift
itemArray[indexPath.row].setValue("new value", forKey: "title")
itemArray[indexPath.row].setValue(true, forKey: "done")
do {
  try context.save()
} catch {
  print("Error saving context \(error)")
  }
```

11. Delete data   
This is a little tricky, we cannot delete the item like updating data we was doing.    
We are going to call ```context.delete()``` and ```context.save()```.
```Swift
// Delete data from our Core Data, then call 'context.save()' to save data
context.delete(itemArray[indexPath.row])
do {
  try self.context.save()
} catch {
  print("Error saving context \(error)")
}

// Does nothing for our Core Date, it merely update our itemArray which is used to populate our tableView
itemArray.remove(at: indexPath.row)
```

12. Query data
Have a look at [NSPredicate Cheatsheet](https://academy.realm.io/posts/nspredicate-cheatsheet/) and [NSHelper](https://nshipster.com/nspredicate/).    


13. Check the DB file if you want    
To print the simulator and application path in AppDelegate
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    return true
}
```

Then we got
```
/Users/catherine/Library/Developer/CoreSimulator/Devices/C2161038-1255-44C0-88EA-E61BEDD0EDE3/data/Containers/Data/Application/D6149CD2-A9F4-4051-AB2E-0314F26082B7/Documents
```

Go to the following path to check the sqlite file via [Datum](https://itunes.apple.com/us/app/datum-free/id901631046?mt=12)
```
/Users/catherine/Library/Developer/CoreSimulator/Devices/C2161038-1255-44C0-88EA-E61BEDD0EDE3/data/Containers/Data/Application/D6149CD2-A9F4-4051-AB2E-0314F26082B7/Library/Application\ Support/DataModel.sqlite
```

14. Edit Data model like a pro    
![CoreData](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/coreData5.png)   

(1) Switch to Graph style   
(2) Add a new entity    
(3) Select the entity   
(4) Add an attribute    
(5) Select the attribute    
(6) Update attribute's name and type. Check the optional box if you want

**Build the relationship between Category and MyTodoeyItem**    
![CoreData](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/coreData6.png)   

(7) Press ```Control``` and drag the Category to MyTodoeyItem   
(8)(9)(10) Update relations. Each Category can have many MyTodoeyItems associated with it. Therefore, the type should be "To Many". On the contrary, each MyTodoeyItem belongs to one single Category, so we set "To one".    

### Realm
Realm example:   
[Todoey with Realm](https://github.com/Catherine22/iOS-tutorial/tree/master/RealmExample)   

0. Install, setup and configure Realm
  - Go to [realm.io](https://realm.io/docs/swift/latest/) to download SDK (Dynamic framework / CocoaPods / Carthage).    
  - Download [Realm browser]() to open .realm file. The realm would be saved in:   
```Swift
class ViewController: UIViewController {
    var realm: Realm? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MARK: Realm - initialising
        do {
            realm = try Realm()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }

        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
}
```

1. Add a new piece of data   
Let's say, we have some categories and items, each item belongs to one single category.   

Create Category
```Swift
import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
```

Create Item
```Swift
import Foundation
import RealmSwift

class Item: Object {
    // dynamic is a declaration modifier, it basically tells the runtime to use dynamic dispatch over the standard which is a static dispatch.This allows the property "name" to be monitered for change at runtime.
    @objc dynamic var name: String = ""
    
    // If we just simpily wrote "Category", then this is just a class. In order to make it the type of "Category", we have to say ",self"
    // property: what the parent list named in Category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
```

2. Save data
Save data in the database
```Swift
do {
    try realm?.write {
        let category = Category()
        category.name = "any category"
        realm?.add(category)
    }
} catch {
    NSLog("Error writing Realm: \(error)")
}
```

3. Update data
```Swift
do {
    try realm?.write {
        // do something here
    }
} catch {
    NSLog("Error writing Realm: \(error)")
}
```

4. Read data
For example, in ViewController
```Swift
var categories: Results<Category>?
class ViewController: UIViewController {
  override func viewDidLoad() {
        super.viewDidLoad()

        do {
            realm = try Realm()
            categories = realm?.objects(Category.self)
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
  }
}
```

5. Delete data    
Notice: no need to remove items from the Results list, Realm would automatically do it.
```Swift
do {
  try realm?.write {
    realm?.delete(category)
    }
  } catch {
    NSLog("Error writing Realm: \(error)")
    }
```

# Network Connection
You could either use ```URLSession``` or popular third-party SDK like Alamofire    
The following features are included in 
[IO Operations](https://github.com/Catherine22/iOS-tutorial/tree/master/IOOperations/IOOperations)   
- SSL certificate validation (Read the documentation: [HTTPS Server Trust Evaluation](https://developer.apple.com/library/archive/technotes/tn2232/_index.html))    
  - Using ```openssl s_client -connect www.apple.com:443```   
  - Get the full certificate by ```openssl s_client -showcerts -host www.apple.com -port 443```   
  - Copying the text (the -----BEGIN CERTIFICATE----- line through to the -----END CERTIFICATE----- line) into a text file with the .pem extension

- Generic request/response types with associatedtype   

Tools you might need:   
  - (Check SSL online)[https://www.ssllabs.com/ssltest/]    
  - Convert .pem file to .crt file via ```openssl x509 -outform der -in xxxx.pem -out xxxx.crt```   

## Alamofire
- [Alamofire](https://cocoapods.org/pods/Alamofire) + [SwiftyJSON](https://cocoapods.org/pods/SwiftyJSON)    


## URLSession
- Generic request/response types with ```associatedtype```    

Check how exactly SSL pinning does on [HttpClient.swift](https://github.com/Catherine22/iOS-tutorial/tree/master/IOOperations/IOOperations/Utils/Network/HttpClient.swift)


### ATS, App Transport Security
Since iOS 9.0, app must follow App Transport Security:    
1. At least TLS 1.2   
2. HTTP is not allowed    
3. Apple will heavily censor when app infringes ATS settings (```NSAllowsArbitraryLoads```).

[Info.plist settings](https://developer.apple.com/documentation/bundleresources/information_property_list/nsapptransportsecurity):    
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>

    <!-- network related constants -->
    <key>NSAppTransportSecurity</key>
    <dict>
        <!-- lift ATS restriction -->
        <key>NSAllowsArbitraryLoads</key>
        <true/>
        <!-- lift ATS restriction of AV Foundation -->
        <key>NSAllowsArbitraryLoadsInMedia</key>
        <true/>
        <!-- lift ATS restriction of WebView -->
        <key>NSAllowsArbitraryLoadsInWebContent</key>
        <true/>
        <!-- to support localhost -->
        <key>NSAllowsLocalNetworking</key>
        <true/>
        <!-- to support minimum TLS version, could be TLSv1.0、TLSv1.1、TLSv1.2. Default value = TLSv1.2 -->
        <key>NSExceptionMinimumTLSVersion</key>
        <string>TLSv1.0</string>


        <!-- define special cases -->
         <key>NSExceptionDomains</key>
         <dict>
            <key>sdk_domain.com</key>
            <dict>
                <!-- to support HTTP -->
                <key>NSExceptionAllowsInsecureHTTPLoads</key>
                <true/>
        </dict>
        <key>your_domain.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <!-- apply all of the domain exceptions to every subdomain of your domain -->
            <key>NSIncludesSubdomains</key>
            <true/>
        </dict>
    </dict>
    </dict>


</dict>
</plist>
```

**Third Party keys**
NSThirdPartyExceptionAllowsInsecureHTTPLoads
NSThirdPartyExceptionMinimumTLSVersion
NSThirdPartyExceptionRequiresForwardSecrecy


# Machine Learning
Machine Learning is usual split into 2 broke categories - Supervised Machine Learning or Unsupervised Machine Learning.   

## Supervised Learning

## Unsupervised Learning

## CoreML
1. Load a pre-trained model, i.e., no training   
2. Make predictions   
3. Not encrypted

Get started from scratch [Sample code](https://github.com/Catherine22/iOS-tutorial/tree/master/SeeFood)    

Example1 - Inceptionv3: 
1. Download pre-trained models from Apple website: [https://developer.apple.com/machine-learning/build-run-models/](https://developer.apple.com/machine-learning/build-run-models/)   
2. Drag .mlmodel file into your project   
3. Check detection code here: [Inceptionv3Model.swift](https://github.com/Catherine22/iOS-tutorial/tree/master/SeeFood/SeeFood/MachineLearning/Inceptionv3Model.swift)

Example2 - [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/):   
1. Install Carthage and download SDK    
Add the dependency in our Cartfile:    
```
github "watson-developer-cloud/swift-sdk"
```
2. Register IBM cloud account   
3. Add Visual Recognition to IBM console    
4. Import VisualRecognition3.framework and Restkit.framework    
5. Check detection code here: [WatsonVisualRecognition.swift](https://github.com/Catherine22/iOS-tutorial/tree/master/SeeFood/SeeFood/MachineLearning/WatsonVisualRecognition.swift)

### Python Settings

1. Install python, pip and virtualenv    
```
$pip install virtualenv
```

2. Create python2.7 environment in a specific directory
```
$mkdir Environments
$cd Environments
$virtualenv --python=/usr/bin/python2.7 python27
```

3. Now we have a python27 directory in Environments, to activate our python
```
$source python27/bin/activate
```
You will see ```(python27) username Environments (git-branch-name) $ ```    

4. Stop virtual environment if you want
```
$deactivate
```

5. Install CoreML tools
```
$pip install -U coremltools
```
```-U``` means install or update coremltools to the latest version    

6. Convert the caffe model to .mlmodel    

### Convert a Caffe model to Core ML format

1. Download [Oxford 102 category flower dataset caffe model](https://udemy-assets-on-demand2.udemy.com/2018-07-02_18-48-43-c17b4a05c8f380a0c0a55d07b17b2b14/original.zip?nva=20190227142445&filename=Flower-Classifier.zip&download=True&token=0dc623fdf4c33a37fd2bf)   
2. Convert a Caffe model to Core ML format ([doc](https://apple.github.io/coremltools/generated/coremltools.converters.caffe.convert.html))   

    
convert-script.py 
```python
import coremltools

# Convert a caffe model to a classifier in Core ML
caffe_model = ('oxford102.caffemodel', 'deploy.prototxt')
labels = 'flower-labels.txt'

coreml_model = coremltools.converters.caffe.convert(
    caffe_model,
    class_labels = labels,
    image_input_names='data'
)

# Now save the model
coreml_model.save('FlowerClassifier.mlmodel')
```
3. Execute convert-script.py    
```
python convert-script.py
```


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

[AppDelegate]:<https://github.com/Catherine22/iOS-tutorial/tree/master/Todoey/Todoey/Todoey/AppDelegate.swift>
[DataModel]:<https://github.com/Catherine22/iOS-tutorial/tree/master/Todoey/Todoey/Todoey/Data%20Model/DataModel.xcdatamodeld>

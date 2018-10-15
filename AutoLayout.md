# Auto Layout
To get our view fit on different screens, we do     

## Adjust views programmatically. For example,    
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

## Pinning
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


## Fix the size of views
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2.png)  
Steps:    
(1) Set the fixed height and width    
![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2_1.png)  
(2) Check "Horizontally in Container" and "Vertically in Container"   
![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2_2.png)    

Your xcode should look like:    
![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/autolayout2_3.png)  

## Stack View   
Calculator for example,   
![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_1.png)  

![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_2.png)  

![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_3.png)  

![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_4.png)  

![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_5.png)  

![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_6.png)  

![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_7.png)  

![example](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/stack_view_8.png)  

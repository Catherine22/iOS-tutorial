import UIKit

/*
 * willSet and didSet
 */
class Observer {
    var value: String {
        willSet {
            // Call willSet before the value changes
            print("Call willSet, value = \(value)")
        }
        
        didSet {
            // Call willSet after the value changes
            print("Call didSet, new value = \(value)")
        }
    }
    
    init(value: String){
        self.value = value
    }
}

var osr = Observer(value: "init")
osr.value = "new value"

import UIKit

/*
 * willSet and didSet
 */
class Observer {
    var value: String {
        willSet {
            // Call willSet before the value changes
            print("Calling willSet, value = \(value), new value = \(newValue)")
        }
        
        didSet {
            // Call willSet after the value changes
            print("Calling didSet, new value = \(value), old value = \(oldValue)")
        }
    }
    
    init(value: String){
        self.value = value
    }
}

var osr = Observer(value: "A")
osr.value = "B"

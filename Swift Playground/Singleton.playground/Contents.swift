import UIKit

/*
 * Normal Object
 */
class Car {
    var colour = "red"
}

let myCar = Car()
myCar.colour = "blue"

let yourCar = Car()
print("Your car is \(yourCar.colour)")


/*
 * Singleton object 1
 */
class SingletonCar {
    var colour = "red"
    static let shareInstance = SingletonCar()
}

let myCar2 = SingletonCar.shareInstance
myCar2.colour = "blue"

let yourCar2 = SingletonCar.shareInstance
print("Your car is \(yourCar2.colour)")

/*
 * Singleton object 2
 */
class SingletonCar2 {
    static let shareInstance: SingletonCar2 = {
        let instance = SingletonCar2()
        
        // setup code
        let colour = "red"
        
        return instance
    }()
}

let myCar3 = SingletonCar.shareInstance
myCar3.colour = "black"

let yourCar3 = SingletonCar.shareInstance
print("Your car is \(yourCar3.colour)")


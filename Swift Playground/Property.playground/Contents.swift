import Foundation

class Util {
    var width: Float?
    var height: Float?
    
    init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
    
    var area: Float {
        return width! * height!
    }
    
    func getArea() -> Float {
        return width! * height!
    }
    
    // You cannot manipulate E (a get-only property)
    var E: Float {
        get {
            return 2.718
        }
    }
}

let util = Util(width: 10.0, height: 20.0)
print("Area: \(util.area)")
print("Area: \(util.getArea())")


// A perfect get/set example
class PizzaCalculator {
    let slicesPerPerson = 5
    let pizzaInInches = 16
    var numberOfPeople: Int?
    
    init(numberOfPeople: Int) {
        self.numberOfPeople = numberOfPeople
    }
    
    var numberOfSlices: Int {
        return pizzaInInches - 4
    }
    
    var numberOfPizza: Int {
        get {
            let neededSlices = Float(exactly: slicesPerPerson)! * Float(exactly: numberOfPeople!)!
            let result = neededSlices / Float(exactly: numberOfSlices)!
            return Int(exactly: ceilf(result))! //Int(exactly: result.rounded(.up))!
        }
        
        set {
            let totalSlices = newValue * numberOfSlices
            let numberOfInvitedPeople = Float(exactly: totalSlices)! / Float(exactly: slicesPerPerson)!
            numberOfPeople = Int(exactly: ceilf(numberOfInvitedPeople)) //Int(exactly: numberOfInvitedPeople.rounded(.down))
        }
    }
}

let pizzaCalculator = PizzaCalculator(numberOfPeople: 9)
print("We should buy \(pizzaCalculator.numberOfPizza) pizzas for \(9) people")

pizzaCalculator.numberOfPizza = 15
print("Now we have \(15) pizzas in the house, we can invite \(pizzaCalculator.numberOfPeople!) people")

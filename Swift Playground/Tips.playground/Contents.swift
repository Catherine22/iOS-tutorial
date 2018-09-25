import UIKit

/*
 * Functions
 */
func func1 () -> String {
    return "func1"
}

func func2 (context: String) -> String {
    return context
}

func func3 (_ context: String) -> String {
    return context
}

func func4 (_ context: String, type: String) -> String {
    return context
}

func func5 (_ numbers: [Int]) -> (min: Int?, max: Int?, avg: Float?){
    var min: Int? = nil
    var max: Int? = nil
    var total: Float? = nil
    for n in numbers {
        if min == nil {
            min = n
            max = n
            total = Float(n)
        } else {
            if n < min! {
                min = n
            } else if n > max! {
                max = n
            }
            total! += Float(n)
        }
    }
    
    if let avg = total {
        return (min, max, avg/Float(numbers.count))
    } else {
        return (min, max, total)
    }
}

print(func1())
print(func2(context: "func2"))
print(func3("func3"))
print(func4("func4", type: "String"))
print(func5([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))

/*
 * Random numbers
 */
var loveScore = Int(arc4random_uniform(101)) // 0 ≤ loveScore ≤ 100
print(loveScore)
loveScore = Int.random(in: 0...100) // 0 ≤ loveScore ≤ 100
print(loveScore)


/*
 * Class
 */
class Person {
    var name: String
    var age: Int
    
    init (name: String, age: Int){
        self.name = name
        self.age = age
    }
    
    func saySomething() -> String{
        return "Hi, my name is \(name), I am \(age) years old"
    }
}

var julianne = Person(name: "Julianne", age: 19)
print(julianne.saySomething())

/*
 * Extend
 */
class Employee: Person {
    var dept: String
    
    init(name: String, age: Int, dept: String){
        self.dept = dept
        super.init(name: name, age: age)
    }
    
    override func saySomething() -> String {
        return "Hi, my name is \(name), I work for \(dept) department"
    }
}

var joanne = Employee(name: "Joanne", age: 16, dept: "Accounting")
print(joanne.saySomething())

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

/*
 * enum
 */
enum Poker: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func getDesc() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return "\(self.rawValue)"
        }
    }
}

let act = Poker.ace
print(act.rawValue)
print(act.getDesc())

let eight = Poker.eight
print(eight.rawValue)
print(eight.getDesc())

enum Suit: String {
    case spade, diamond, heart, club
    func getSymbol() -> String {
        switch self {
        case .spade:
            return "♠︎"
        case .diamond:
            return "♦︎"
        case .heart:
            return "♥︎"
        case .club:
            return "♣︎"
        default:
            return "?"
        }
    }
}

let diamond = Suit.diamond
print(diamond.getSymbol())

enum Response {
    case success(Int, String)
    case failure(Int, String)
}
func getAlbum(message: Response) {
    switch message {
    case let .success(code, body):
        print("Message:\(body)")
    case let .failure(code, errorMessage):
        print("\(code) Error: \(errorMessage)")
    }
}

let albums = Response.success(200, "[{\"title\":\"Taylor Swift\",\"artist\":\"Taylor Swift\",\"url\":\"https://www.amazon.com/Taylor-Swift/dp/B0014I4KH6\",\"image\":\"https://images-na.ssl-images-amazon.com/images/I/61McsadO1OL.jpg\",\"thumbnail_image\":\"https://i.imgur.com/K3KJ3w4h.jpg\"}]")
let error = Response.failure(404, "Not Found")

getAlbum(message: albums)
getAlbum(message: error)

/*
 * struct
 */
struct GiftCardStruct {
    var sn: String
    var expiration: Double
    var value: Double
    
    func showInfo() {
        print("[struct] sn:\(sn), value:\(value)")
    }
}

class GiftCardClass {
    var sn: String
    var expiration: Double
    var value: Double
    
    init(sn: String, expiration: Double, value: Double){
        self.sn = sn
        self.expiration = expiration
        self.value = value
    }
    
    func showInfo() {
        print("[class] sn:\(sn), value:\(value)")
    }
}

var card1 = GiftCardClass(sn: "card1", expiration: 1924905600, value: 100.0)
var card2 = card1
card2.sn = "card2"
card1.showInfo()

var card3 = GiftCardStruct(sn: "card3", expiration: 1924905600, value: 100.0)
var card4 = card3
card4.sn = "card4"
card3.showInfo()


/*
 * Potocols
 */
protocol PermissionListener {
    var isLock: Bool { get }
    mutating func onGrand()
    mutating func onDeny()
}

class BluetoothModule: PermissionListener {
    var isLock: Bool = true
    
    func onGrand() {
        isLock = false
    }
    
    func onDeny() {
        isLock = true
    }
    
    func enableBluetooth() {
        if(isLock){
            print("Permission denied")
        }
        else{
            print("Bluetooth on")
        }
    }
}

var ble = BluetoothModule()
ble.enableBluetooth()
ble.onGrand()
ble.enableBluetooth()

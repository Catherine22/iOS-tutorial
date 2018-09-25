# Swift Tips
![Swift cheat sheet](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/SwiftCheatSheet.png)

## Optional Variable
```var``` for Variables and ```let``` for Constants. 
Constants take up less memory space than Variables.  

### Use ```if``` and ```let``` together to work with values that might be missing.
```swift
var optionalName: String? = "John"
if let name = optionalName {
   print("\(name) is not nil")
} else {
    print("name is nil")
}
// John is not nil


optionalName = nil
if let name = optionalName {
    print("\(name) is not nil")
} else {
    print("name is nil")
}
// name is nil
```

### ```??``` - If the optional value is missing, the default value is used instead.
```swift
var firstName: String? = "Catherine"
var middleName: String? = nil
var lastName: String? = "Chen"
print("\(firstName ?? " ")\(middleName ?? " ")\(lastName ?? " ")")
// Catherine Chen
```

## ```Switch```
```swift
let scores = ["John": 70, "Julianne": 100, "Anna": 59, "Paul": 0]
for (name, score) in scores {
    if name == "Paul" {
        print("Paul passed the test of course, because he is the son of the headmaster")
    } else {
        switch score {
        case 100:
            print("\(name) got a perfect mark!")
        case let x where x >= 60:
            print("\(name) passed the test!")
        default:
            print("\(name) didn't pass the test.")
        }
    }
}
/* John passed the test!
 * Julianne got a perfect mark!
 * Paul passed the test of course, because he is the son of the headmaster
 * Anna didn't pass the test.
 */
```

## Loop
Print all prime numbers up to 100

### ```while```
```swift
var n = 2
var header = 2
var isPrime = true
var primeNumbers: [Int] = []
while n <= 100 {
    while header <= n/2 {
        if n % header == 0 {
            isPrime = false
            break
        }
        header += 1
    }
    if isPrime {
        primeNumbers.append(n)
    }
    isPrime = true
    n += 1
    header = 2
}

print(primeNumbers)
// [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
```

### ```repeat``` + ```while```
```swift
repeat {
    while header <= n/2 {
        if n % header == 0 {
            isPrime = false
            break
        }
        header += 1
    }
    if isPrime {
        primeNumbers.append(n)
    }
    isPrime = true
    n += 1
    header = 2
} while n <= 100

print(primeNumbers)
// [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
```

### ```for```
```swift
var header = 2
var isPrime = true
var primeNumbers: [Int] = []

primeNumbers.append(2)
primeNumbers.append(3)
for n in 4...100 {
    for header in 2...n/2 {
        if n % header == 0 {
            isPrime = false
            break
        }
    }
    if isPrime {
        primeNumbers.append(n)
    }
    isPrime = true
}

print(primeNumbers)
// [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
```
> Range     
(0, 10), we use ```0...10```      
(0,10], we use ```0..<10```

## Function

- Return one single String
```swift
func func1 () -> String {
    return "func1"
}
print(func1()) // func1
```

- One argument named context
```swift
func func2 (context: String) -> String {
    return context
}
print(func2(context: "func2")) // func2
```

- write ```_``` to use no argument label
```swift
func func3 (_ context: String, type: String) -> String {
    return context
}
print(func3("func3", type: "String")) // func3
```

- Return a tuple
```swift
func func4 (numbers: [Int]) -> (min: Int?, max: Int?, avg: Float?){
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

print(func4(name: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
// (min: Optional(1), max: Optional(10), avg: Optional(5.5))
```

## Random

Get a random loveScore (0 ≤ loveScore ≤ 100) 

Either 
```swift
let loveScore = Int.random(in: 0...100)
```

Or
```swift
let loveScore = Int(arc4random_uniform(101))
```

## ```class```, ```enum``` and ```structure```

- Initialization
```swift
class Person {
    var name: String
    var age: Int
    
    init (name: String, age: Int){
        self.name = name
        self.age = age
    }
    func saySomething() {
        print("Hi, my name is \(name), I am \(age) years old")
    }
}

var julianne = Person(name: "Julianne", age: 19)
julianne.saySomething() // Hi, my name is Julianne, I am 19 years old
```
- Extend

Class Employee extends Person
```swift
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
print(joanne.saySomething()) // Hi, my name is Joanne, I work for Accounting department
```
- Observer - ```willSet``` and ```didSet```
```swift
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

// Call willSet, value = init
// Call didSet, new value = new value
```

- ```enum```

1. Basic enum
```swift
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
print(diamond.getSymbol()) // ♦ ︎
```

2. Advanced enum
```swift
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

getAlbum(message: albums) // Message:[{"title":"Taylor Swift",...
getAlbum(message: error) // 404 Error: Not Found
```

- ```struct```

One of the most important differences between structures and classes is that structures are always copied when they are passed around in your code, but classes are passed by reference.

```swift
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
card1.showInfo() // [class] sn:card2, value:100.0

var card3 = GiftCardStruct(sn: "card3", expiration: 1924905600, value: 100.0)
var card4 = card3
card4.sn = "card4"
card3.showInfo() // [struct] sn:card3, value:100.0
```
As we see, there are 2 differences between ```class``` and ```sturct```:        
1. ```sturct``` is not necessary to declare its initialization      
2. ```class``` is call-by-reference whereas ```struct``` is call-by-value

## Protocols and Extension

Protocol (Interface) example:
```swift
protocol PermissionListener {
    var isLock: Bool { get }
    mutating func onGrand()
    mutating func onDeny()
}
```
>```mutating``` means all the changes of its instance and any value of its instance are allowed.        

Implement the protocol via a class
```swift
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
ble.enableBluetooth() // Permission denied
ble.onGrand() 
ble.enableBluetooth() // Bluetooth on
```
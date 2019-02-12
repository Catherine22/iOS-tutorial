# Swift Tips
![Swift cheat sheet](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/SwiftCheatSheet.png)

## Navigation
- [Optional Variable](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#optional-variable)          
- [switch](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#switch)       
- [Loop](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#loop)       
- [Function](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#function-func)      
- [random](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#random)       
- [class, enum and structure](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#class-enum-and-structure)    
- [extension](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#extension)     
- [protocol](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#protocol)       
- [Error Handling](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#error-handling)       
- [Generics](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#generics)         
- [Access Levels](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#access-levels)       
- [Singleton](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#singleton)     
- [Fibonacci](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#fibonacci)     
- [Reference](https://github.com/Catherine22/iOS-tutorial/tree/master/Swift%20Playground#reference)     

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

### Nil Coalescing Operator(```??```) - If the optional value is missing, the default value is used instead.
```swift
var firstName: String? = "Catherine"
var middleName: String? = nil
var lastName: String? = "Chen"
print("\(firstName ?? " ")\(middleName ?? " ")\(lastName ?? " ")")
// Catherine Chen
```

## ```switch```
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
        }
    }
}
/* John passed the test!
 * Julianne got a perfect mark!
 * Paul passed the test of course, because he is the son of the headmaster
 * Anna didn't pass the test.
 */
```

## Property
### Function-liked property
For example, we have a class        
```Swift
class Util {
    let width = 10.0
    let height = 20.0
}
```

In order to calculate the area, we can create a method      
```Swift
func getArea() -> Double {
        return width * height
    }
```

Or USE PROPERTY     
>You must:       
>1. Set the property ```var```       
>2. Initialise the property with its type   

```Swift
var area: Double {
        return width * height
    }
```     

You could also write it completely with ```get { }```
```Swift
var area: Double {
        get {
            return width * height
        }
    }
```

### Get-only property
```Swift
var E: Float {
        get {
            return 2.718
        }
    }
```

### Observer - ```willSet``` and ```didSet```
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

**Loop an array**
> Deletion       
Removing elements from the end of an array, or indexOutOfRange exception might happen
```swift
var arr = [1, 3, -10, 5, -7]
for (index, element) in arr.enumerated().reversed() {
    if element < 0 {
        arr.remove(at: index)
    }
}
print(arr) // [1, 3, 5]
```

## Function, ```func```
>Method vs function      
>A method is a function that is associated with a class.     
>So if it is within the curly braces of a class, then it is called a method.     

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

## ```random```
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
### Designated Initialiser, ```init```
Every argument is supposed to be initialise

```swift
class Person {
    var name: String
    var age: Int

    init (name: String, age: Int) {
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

### Convenience Initialiser, ```convenience init```
Initialise with optional arguments

```swift
enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    var colour = "Black"
    var typeOfCar: CarType = .Coupe

    convenience init(customerChosenColour: String){
        self.init() // Initialise the default properties
        self.colour = customerChosenColour
    }
}

let myCar = Car() // It works
print(myCar.colour)
print(myCar.typeOfCar)

let someRichGuysCar = Car(customerChosenColour: "Gold") // It works as well
print(someRichGuysCar.colour)
print(someRichGuysCar.typeOfCar)
```

### Inheritance, ```extends```
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

### ```enum```
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
    case let .success(_, body):
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

### ```struct```
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
1. ```sturct``` is not necessary to declare its initialiser      
2. ```class``` is call-by-reference whereas ```struct``` is call-by-value

## ```extension```
Add a plug-in to user-defined classes or system classes
```swift
extension String {
    var toNumber: String {
        let okChars = Set("012345678")
        return self.filter { okChars.contains($0) }
    }
}

extension Int {
    var money: String {
        let temp: String = String(self)
        var money: String = ""
        var count = 0
        for (_, c) in temp.enumerated().reversed() {
            count+=1
            money.append(c)
            if count % 3 == 0 {
                money.append(",")
            }
        }

        if money.last == "," {
            money.removeLast()
        }

        return String(money.reversed())
    }

    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }

}

var rawData =  "555-1234!@#$%^&*   \n \t ≤"
var formattedPhoneNumber = rawData.toNumber
print(formattedPhoneNumber) // 5551234

var rawMoney = 3927241123
var formattedMoney = rawMoney.money
3.repetitions {
    print(formattedMoney)
}
// 3,927,241,123
// 3,927,241,123
// 3,927,241,123
```

### ```subscript```
Call ```extension``` + ```subscript``` by ```xxx[ooo]```
```swift
extension String {
    subscript(c: Character) -> Int {
        var count = 0
        for s in self {
            if s == c {
                count += 1
            }
        }
        return count
    }
}
var quote = "Without music, life would be a mistake"
print("I have \(quote["e"]) \"e\" in the quote")
```

## ```protocol```
### Scenario 1 - Light switch
>```mutating``` means all the changes of its instance and any value of its instance are allowed.     
```swift
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off // off
lightSwitch.toggle() // on
lightSwitch.toggle() // off
```

### Scenario 2: Initialiser requirements
Use ```required init``` to initialise
```swift
protocol PublicWiFiLogin {
    init(phoneNumber: String)
}

class WiFiAccess: PublicWiFiLogin {
    required init(phoneNumber: String) {
        print("Phone Number: \(phoneNumber.toNumber)")
    }
}
WiFiAccess(phoneNumber: "555-1234!@#$%^&*   \n \t ≤") // Phone Number: 5551234
```

### Scenario 3: A local broadcast system
```swift
protocol Receiver {
    // serialNumber must be unique
    var serialNumber: Int { get set }
    func onReceive (content: String)
}
```   

Implement the protocol via a class
```swift
class Register: Receiver {
    var serialNumber: Int = -1
    init (_ serialNumber: Int) {
        self.serialNumber = serialNumber
    }

    func onReceive (content: String) {
        print("You got a message(\(serialNumber)): \(content)")
    }
}
```

```swift
class BroadcastManager {
    var static receivers = [Receiver]()

    func sendMessage(content: String) {
        notifyAllReceivers(content)
    }

    func register(receiver: Receiver) {
        receivers.append(receiver)
    }

    func unregister(receiver: Receiver) {
        for (index, element) in receivers.enumerated().reversed() {
            if element.serialNumber == receiver.serialNumber {
                receivers.remove(at: index)
            }
        }
    }

    func notifyAllReceivers(_ content: String) {
        for r in receivers {
            r.onReceive(content: content)
        }
    }
}
```

Create 2 classes to get the message
```swift
class Inbox {
    init() {
        let broadcastManager = BroadcastManager()
        let emailReceiver = MessageReceiver(0x0001)

        // register a receiver
        broadcastManager.register(receiver: emailReceiver)
    }

    class MessageReceiver: Receiver {
        var serialNumber: Int = -1
        init (_ serialNumber: Int) {
            self.serialNumber = serialNumber
        }

        func onReceive (content: String) {
            print("You got a message(\(serialNumber)): \(content)")
        }
    }
}
```

```swift
class Notification {
    private let broadcastManager = BroadcastManager()
    private let notificationReceiver = MessageReceiver(0x0002)
    private var enable: Bool = false

    class MessageReceiver: Receiver {
        var serialNumber: Int = -1
        init (_ serialNumber: Int) {
            self.serialNumber = serialNumber
        }

        func onReceive (content: String) {
            print("A notification popped up(\(serialNumber)): \(content)")
        }
    }

    func showNotifications(enable: Bool) {
        if enable && !self.enable {
            broadcastManager.register(receiver: notificationReceiver)
        } else if !enable && self.enable {
            broadcastManager.unregister(receiver: notificationReceiver)
        }
        self.enable = enable
    }
}
```
MessageCenter is used to broadcast messages to each registered receiver
```swift
class MessageCenter {
    private let broadcastManager = BroadcastManager()
    func sendMockMessage (content: String) {
        broadcastManager.sendMessage(content: content)
    }
}
```
Demo
```swift
var inbox = Inbox()
var notification = Notification()

var messageCenter = MessageCenter()
messageCenter.sendMockMessage(content: "你好啊")
// You got a message(1): 你好啊

// register another receiver
notification.showNotifications(enable: true)
messageCenter.sendMockMessage(content: "我是一个快乐的broadcast")
// You got a message(1): 我是一个快乐的broadcast
// A notification popped up(2): 我是一个快乐的broadcast

// unregister the Notification receiver
notification.showNotifications(enable: false)
messageCenter.sendMockMessage(content: "还有谁收到我？")
// You got a message(1): 还有谁收到我？
```

## Error Handling
- Scenario 1
> Tips      
> - Define multiple errors in ```enum``` which must extend ```Error```      
> - Normally, we don't handle all of the errors. Therefore, we use another ```try-catch``` to wrap the main ```try-catch``` statement      
```swift
struct Item {
    var price: Int
    var count: Int
}

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class VendingMachine {
    var inventory = [
        "Prezels": Item(price: 7, count: 15),
        "Chips": Item(price: 13, count: 3),
        "Candy Bar": Item(price: 12, count: 0)
    ]

    // coinsDeposited: How much money customers deposit
    func vend(itemNamed name: String, coinsDeposited: Int) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: (item.price - coinsDeposited))
        }


        item.count -= 1
        inventory[name] = item
        print("Success! Depositing: $\(coinsDeposited - item.price)")
    }
}

var vendingMachine = VendingMachine()

func purchasedItem(itemNamed name: String, coinsDeposited: Int) throws {
    do {
        try vendingMachine.vend(itemNamed: name, coinsDeposited: coinsDeposited)
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    }
}

do {
    try purchasedItem(itemNamed: "Chipz", coinsDeposited: 100)
// Invalid Selection.
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

do {
    try purchasedItem(itemNamed: "Prezels", coinsDeposited: 100)
// Success! Depositing: $93
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

do {
    try purchasedItem(itemNamed: "Candy Bar", coinsDeposited: 100)
} catch {
    print("Unexpected vending-machine-related error: \(error)")
// Unexpected vending-machine-related error: outOfStock
}
```

- Scenario 2
> Ignore errors     
> Replace ```try?``` to ```try!```
```swift
extension Double {
    // byte
    var B: Double {
        return self
    }
    // kilobyte
    var KB: Double {
        return self * 1024
    }
    // megabyte
    var MB: Double {
        return self.KB * 1024
    }
    // gigabyte
    var GB: Double {
        return self.MB * 1024
    }
    // terabyte
    var TB: Double {
        return self.GB * 1024
    }
}

struct File {
    var name: String
    var size: Double
}

enum MemoryError: Error {
    case InsufficientStorage
}

func saveInExternalStorage(file: File) throws -> String {
    let mockAvailableStorageSize = 100.0.B
    guard file.size <= mockAvailableStorageSize else {
        throw MemoryError.InsufficientStorage
    }
    return "\(file.name) saved in the external storage"
}


func saveInInternalStorage(file: File) throws -> String {
    let mockAvailableStorageSize = 5.0.MB
    guard file.size <= mockAvailableStorageSize else {
        throw MemoryError.InsufficientStorage
    }
    return "\(file.name) saved in the internal storage"
}

func save(file: File) -> String {
    if let message = try? saveInExternalStorage(file: file) { return message }
    if let message = try? saveInInternalStorage(file: file) { return message }
    return "Failed to save"
}

var image = File(name: "Taylor Swift.png", size: 1.0.MB)
print("Downloading \(image.name) ...") // Downloading Taylor Swift.png ...
print("\(save(file: image))") // Taylor Swift.png saved in the internal storage

var video = File(name: "Despacito.mp4", size: 5.1.MB)
print("Downloading \(video.name) ...") // Downloading Despacito.mp4 ...
print("\(save(file: video))") // Failed to save
```

### ```defer``` , finally
```swift
func doSomething() throws {
    ...
}
```
- Scenario 1
> 1. No errors: ```try``` -> ```doSomething()``` -> ```defer```      
> 2. Found errors: ```try``` -> ```catch``` -> ```defer```      
```swift
defer {
    // Whether or not errors are found, this code block will absolutely be executed
}
do {
    try doSomething()
} catch {
    // Handle Error here
}
```
- **Scenario 2**
> 1. No errors: ```try``` -> ```doSomething()``` -> ```defer```      
> 2. Found errors: **```try``` -> ```defer``` -> ```catch```**      
```swift
do {
    defer {
        // Whether or not errors are found, this code block will absolutely be executed
    }
    try doSomething()
} catch {
    // Handle Error here
}

```

## Generics
### Scenario 1: Swap 2 generic types
```swift
func swap<T>(_ a: inout T, _ b: inout T) {
    let t = a
    a = b
    b = t
}

struct Animal {
    var name: String
    var _class: String

    static func compare (a: Animal, b: Animal) -> Int {
        if a.name == b.name && a._class == b._class {
            return 0
        }
        return -1
    }
}

var snack = Animal(name: "Elephant", _class: " ‎Mammalia")
var elephant = Animal(name: "Snake", _class: "Reptilia")
print("a:\(elephant), b:\(snack)") // a:Animal(name: "Snake", _class: "Reptilia"), b:Animal(name: "Elephant", _class: " ‎Mammalia")

swap(&elephant, &snack)
print("a:\(elephant), b:\(snack)") // a:Animal(name: "Elephant", _class: " ‎Mammalia"), b:Animal(name: "Snake", _class: "Reptilia")
```

### Scenario 2: Define a generic stack
```swift
struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop () -> T{
        return items.removeLast()
    }

    func empty() -> Bool {
       return items.isEmpty
    }

    func peek() -> T? {
        return items.last
    }

    func search(_ item: T, _ compare: (_ a: T, _ b: T) -> Int) -> Int {
        for (index, value) in items.enumerated().reversed() {
            if compare(value, item) == 0 {
                return index
            }
        }
        return -1
    }
}

var gorilla = Animal(name: "Gorilla", _class: " ‎Mammalia")
var zoo = Stack<Animal>()
zoo.push(elephant)
zoo.push(snack)
zoo.push(gorilla)

if zoo.peek() != nil {
    print("Top animal: \(zoo.peek()!)")
} else {
    print("Empty zoo")
}
// Top animal: Animal(name: "Gorilla", _class: " ‎Mammalia")

print("search snack: \(zoo.search(snack, Animal.compare))") // search snack: 1

print("fire \(zoo.pop())") // fire Animal(name: "Gorilla", _class: " ‎Mammalia")

if zoo.peek() != nil {
    print("Top animal: \(zoo.peek()!)")
} else {
    print("Empty zoo")
}
// Top animal: Animal(name: "Snake", _class: "Reptilia")
```

# Access Levels
Three common levels:        
- private       
- fileprivate       
- internal (default)

SDK packaging levels:       
- public        
- open

# Singleton
Solution 1: 
```swift
class SingletonCar {
    var colour = "red"
    static let shareInstance = SingletonCar()
}

let myCar2 = SingletonCar.shareInstance
myCar2.colour = "blue"

let yourCar2 = SingletonCar.shareInstance
print("Your car is \(yourCar2.colour)") // blue
````

Solution 2: initialise anything inside initialiser
```swift
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
print("Your car is \(yourCar3.colour)") // black
```

# Fibonacci
1. Recursion
```swift
func fibonacci1 (until n: Int) -> Int {
    if n<3 {
        return 1
    }
    return fibonacci1(until: n-1) + fibonacci1(until: n-2)
}
```

2. Loop
```swift
func fibonacci2 (until n: Int) -> Int {
    if n<3 {
        return 1
    }
    var n_1 = 1 // f(n-1)
    var n_2 = 1 // f(n-2)
    var res = 1 // f(n)
    for _ in 3...n {
        res = n_1 + n_2
        n_2 = n_1
        n_1 = res
    }
    return res
}
```

# Reference
[Swift Language Guide](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)
[Programing puzzles](https://projecteuler.net/archives)

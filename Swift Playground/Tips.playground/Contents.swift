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
    case let .success(_, body):
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
 * Extension
 */
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
            if(count % 3 == 0) {
                money.append(",")
            }
        }
        
        if(money.last == ",") {
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
    print(formattedMoney) // 3,927,241,123
}

/*
 * Subscript
 */
extension String {
    subscript(c: Character) -> Int {
        var count = 0
        for s in self {
            if(s == c) {
                count += 1
            }
        }
        return count
    }
}
var quote = "Without music, life would be a mistake"
print("I have \(quote["e"]) \"e\" in the quote")

/*
 * Protocols - scenario 1
 */
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

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
lightSwitch.toggle()


/*
 * Protocols - scenario 2
 */
protocol PublicWiFiLogin {
    init(phoneNumber: String)
}

class WiFiAccess: PublicWiFiLogin {
    required init(phoneNumber: String) {
        print("Phone Number: \(phoneNumber.toNumber)")
    }
}

WiFiAccess(phoneNumber: "555-1234!@#$%^&*   \n \t ≤")

/*
 * Potocols - scrnario 3
 */
protocol Receiver {
    // serialNumber must be unique
    var serialNumber: Int { get set }
    func onReceive (content: String)
}

class BroadcastManager {
    static var receivers = [Receiver]()
    
    func sendMessage(content: String) {
        notifyAllReceivers(content)
    }
    
    func register(receiver: Receiver) {
        BroadcastManager.receivers.append(receiver)
    }
    
    func unregister(receiver: Receiver) {
        for (index, element) in BroadcastManager.receivers.enumerated().reversed() {
            if(element.serialNumber == receiver.serialNumber) {
                BroadcastManager.receivers.remove(at: index)
            }
        }
    }
    
    func notifyAllReceivers(_ content: String) {
        for r in BroadcastManager.receivers {
            r.onReceive(content: content)
        }
    }
}

class Inbox {
    init() {
        let broadcastManager = BroadcastManager()
        let emailReceiver = MessageReceiver(0x0001)
        
        // register a reveicer
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
        if(enable && !self.enable) {
            broadcastManager.register(receiver: notificationReceiver)
        } else if (!enable && self.enable) {
            broadcastManager.unregister(receiver: notificationReceiver)
        }
        self.enable = enable
    }
}

class MessageCenter {
    private let broadcastManager = BroadcastManager()
    func sendMockMessage (content: String) {
        broadcastManager.sendMessage(content: content)
    }
}

var inbox = Inbox()
var notification = Notification()

var messageCenter = MessageCenter()
messageCenter.sendMockMessage(content: "你好啊")

// register another receiver
notification.showNotifications(enable: true)
messageCenter.sendMockMessage(content: "我是一个快乐的broadcast")

// unregister the Notification receiver
notification.showNotifications(enable: false)
messageCenter.sendMockMessage(content: "还有谁收到我？")

/*
 * Error Handling
 * Scenario 1
 */
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
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

do {
    try purchasedItem(itemNamed: "Prezels", coinsDeposited: 100)
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

do {
    try purchasedItem(itemNamed: "Candy Bar", coinsDeposited: 100)
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

/*
 * Error Handling
 * Scenario 2
 */
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
print("Downloading \(image.name) ...")
print("\(save(file: image))")

var video = File(name: "Despacito.mp4", size: 5.1.MB)
print("Downloading \(video.name) ...")
print("\(save(file: video))")

/*
 * Generics
 * Scenario 1
 */
func swap<T>(_ a: inout T, _ b: inout T) {
    let t = a
    a = b
    b = t
}

struct Animal {
    var name: String
    var _class: String
    
    static func compare (a: Animal, b: Animal) -> Int {
        if (a.name == b.name && a._class == b._class) {
            return 0
        }
        return -1
    }
}

var snack = Animal(name: "Elephant", _class: " ‎Mammalia")
var elephant = Animal(name: "Snake", _class: "Reptilia")
print("a:\(elephant), b:\(snack)")

swap(&elephant, &snack)
print("a:\(elephant), b:\(snack)")

/*
 * Generics
 * Scenario 2
 */
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
            if (compare(value, item) == 0) {
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
print("search snack: \(zoo.search(snack, Animal.compare))")
print("fire \(zoo.pop())")
if zoo.peek() != nil {
    print("Top animal: \(zoo.peek()!)")
} else {
    print("Empty zoo")
}

import UIKit



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

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
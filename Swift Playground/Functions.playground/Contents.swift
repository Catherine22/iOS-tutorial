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

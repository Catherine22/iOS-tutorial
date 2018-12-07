import UIKit

/*
 * Fibonacci
 */
func fibonacci1 (until n: Int) -> Int {
    if n<3 {
        return 1
    }
    return fibonacci1(until: n-1) + fibonacci1(until: n-2)
}

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

var f1 = [Int]();
var f2 = [Int]();
for i in 1...10 {
    f1.append(fibonacci1(until: i))
    f2.append(fibonacci2(until: i))
}
print(f1)
print(f2)

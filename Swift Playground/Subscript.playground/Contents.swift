import UIKit

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

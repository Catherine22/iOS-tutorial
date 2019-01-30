import UIKit

// Nil coalescing operator
let sam = "Sam"
var designatedScapegoat: String?

func findSbGoDown() -> String {
    return designatedScapegoat ?? sam
}

findSbGoDown()

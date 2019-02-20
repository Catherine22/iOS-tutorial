import UIKit


// function
func f(argu1: String, _ argu2: Int) -> Bool {
    return true
}

let result = f(argu1: "a", 10)

//closure
func c(argu1: String, _ argu2: Int, completion: (Bool) -> Void) {
    completion(true)
}

c(argu1: "a", 10, completion: { (result) -> Void in
    print("style1: \(result)")
    // result = ture
})

c(argu1: "a", 10) { (result) in
    print("style2: \(result)")
    // result = ture
}

c(argu1: "a", 10) {
    print("style3: \($0)")
    // result = ture
}

//@escaping
var functionalVar: ((String) -> ())?
func trimString(content: String, result: @escaping (String) -> ()) {
    // delay for 2 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        functionalVar = result
        result(content.replacingOccurrences(of: "\\s", with: "", options: .regularExpression))

    }
}
trimString(content: "i  n pu t ") { (newString) in
    print(newString)
}

//nested closure
func showFormattedString(content: String, completion: ((String) -> Void)? = nil) {
    trimString(content: content) { (formattedString) in
        print(formattedString)
        if completion != nil {
            completion!(formattedString)
        }
    }
}

showFormattedString(content: "i  n pu t ") { (formattedString) in
    print("show \(formattedString)")
}

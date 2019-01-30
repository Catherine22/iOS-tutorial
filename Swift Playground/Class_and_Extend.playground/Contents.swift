import UIKit

/*
 * Class - Designated Initialiser
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

/*
 * Class - Convenience Initialiser
 */

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

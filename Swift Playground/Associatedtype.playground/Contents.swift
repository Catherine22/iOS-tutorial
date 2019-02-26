import UIKit

protocol WeightCalculable {
    //为weight 属性定义的类型别名
    associatedtype WeightType
    var weight : WeightType {get}
}

struct MobilePhone: WeightCalculable {
    typealias WeightType = Double
    
    var weight : WeightType
    init(weight: WeightType) {
        self.weight = weight
    }
}

struct Car: WeightCalculable {
    typealias WeightType = Int
    
    var weight : WeightType
    init(weight: WeightType) {
        self.weight = weight
    }
}

let mobilePhone = MobilePhone(weight: 0.5)
let car = Car(weight: 2000)

print("mobile phone weighs \(mobilePhone.weight) kg")
print("car weighs \(car.weight) kg")

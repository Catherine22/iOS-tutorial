import UIKit

/*
 * struct
 */
struct GiftCardStruct {
    var sn: String
    var expiration: Double
    var value: Double
    
    func getInfo() -> String {
        return "[struct] sn:\(sn), value:\(value)"
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
    
    func getInfo() -> String {
        return "[class] sn:\(sn), value:\(value)"
    }
}

var card1 = GiftCardClass(sn: "card1", expiration: 1924905600, value: 100.0)
var card2 = card1
print("set card2 sn")
card2.sn = "card2"
print("card1: \(card1.getInfo())")
print("card2: \(card2.getInfo())")

var card3 = GiftCardStruct(sn: "card3", expiration: 1924905600, value: 100.0)
var card4 = card3
print("set card4 sn")
card4.sn = "card4"
print("card3: \(card3.getInfo())")
print("card4: \(card4.getInfo())")

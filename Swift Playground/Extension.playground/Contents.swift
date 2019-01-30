import UIKit

/*
 * Extension
 */
extension String {
    var toNumber: String {
        let okChars = Set("012345678")
        return self.filter { okChars.contains($0) }
    }
}

extension Int {
    var money: String {
        let temp: String = String(self)
        var money: String = ""
        var count = 0
        for (_, c) in temp.enumerated().reversed() {
            count+=1
            money.append(c)
            if(count % 3 == 0) {
                money.append(",")
            }
        }
        
        if(money.last == ",") {
            money.removeLast()
        }
        
        return String(money.reversed())
    }
    
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
}

var rawData =  "555-1234!@#$%^&*   \n \t ≤"
var formattedPhoneNumber = rawData.toNumber
print(formattedPhoneNumber) // 5551234

var rawMoney = 3927241123
var formattedMoney = rawMoney.money
3.repetitions {
    print(formattedMoney) // 3,927,241,123
}

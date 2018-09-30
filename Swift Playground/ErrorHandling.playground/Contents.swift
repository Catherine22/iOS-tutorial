/*
 * Error Handling
 */
struct Item {
    var price: Int
    var count: Int
}

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class VendingMachine {
    var inventory = [
        "Prezels": Item(price: 7, count: 15),
        "Chips": Item(price: 13, count: 3),
        "Candy Bar": Item(price: 12, count: 0)
    ]
    
    // coinsDeposited: How much money customers deposit
    func vend(itemNamed name: String, coinsDeposited: Int) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: (item.price - coinsDeposited))
        }
        
        
        item.count -= 1
        inventory[name] = item
        print("Success! Depositing: $\(coinsDeposited - item.price)")
    }
}

var vendingMachine = VendingMachine()

func purchasedItem(itemNamed name: String, coinsDeposited: Int) throws {
    do {
        try vendingMachine.vend(itemNamed: name, coinsDeposited: coinsDeposited)
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    }
}

do {
    try purchasedItem(itemNamed: "Chipz", coinsDeposited: 100)
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

do {
    try purchasedItem(itemNamed: "Prezels", coinsDeposited: 100)
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

do {
    try purchasedItem(itemNamed: "Candy Bar", coinsDeposited: 100)
} catch {
    print("Unexpected vending-machine-related error: \(error)")
}

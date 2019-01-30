import UIKit

/*
 * Error Handling
 * Scenario 1
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

/*
 * Error Handling
 * Scenario 2
 */
extension Double {
    // byte
    var B: Double {
        return self
    }
    // kilobyte
    var KB: Double {
        return self * 1024
    }
    // megabyte
    var MB: Double {
        return self.KB * 1024
    }
    // gigabyte
    var GB: Double {
        return self.MB * 1024
    }
    // terabyte
    var TB: Double {
        return self.GB * 1024
    }
}

struct File {
    var name: String
    var size: Double
}

enum MemoryError: Error {
    case InsufficientStorage
}

func saveInExternalStorage(file: File) throws -> String {
    let mockAvailableStorageSize = 100.0.B
    guard file.size <= mockAvailableStorageSize else {
        throw MemoryError.InsufficientStorage
    }
    return "\(file.name) saved in the external storage"
}


func saveInInternalStorage(file: File) throws -> String {
    let mockAvailableStorageSize = 5.0.MB
    guard file.size <= mockAvailableStorageSize else {
        throw MemoryError.InsufficientStorage
    }
    return "\(file.name) saved in the internal storage"
}

func save(file: File) -> String {
    if let message = try? saveInExternalStorage(file: file) { return message }
    if let message = try? saveInInternalStorage(file: file) { return message }
    return "Failed to save"
}

var image = File(name: "Taylor Swift.png", size: 1.0.MB)
print("Downloading \(image.name) ...")
print("\(save(file: image))")

var video = File(name: "Despacito.mp4", size: 5.1.MB)
print("Downloading \(video.name) ...")
print("\(save(file: video))")

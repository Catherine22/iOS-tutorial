import UIKit

/*
 * Protocols - scenario 1
 */
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
lightSwitch.toggle()


/*
 * Protocols - scenario 2
 */
protocol PublicWiFiLogin {
    init(phoneNumber: String)
}

class WiFiAccess: PublicWiFiLogin {
    required init(phoneNumber: String) {
        print("Phone Number: \(phoneNumber)")
    }
}

WiFiAccess(phoneNumber: "555-1234!@#$%^&*   \n \t ≤")

/*
 * Potocols - scrnario 3
 */
protocol Receiver {
    // serialNumber must be unique
    var serialNumber: Int { get set }
    func onReceive (content: String)
}

class BroadcastManager {
    static var receivers = [Receiver]()
    
    func sendMessage(content: String) {
        notifyAllReceivers(content)
    }
    
    func register(receiver: Receiver) {
        BroadcastManager.receivers.append(receiver)
    }
    
    func unregister(receiver: Receiver) {
        for (index, element) in BroadcastManager.receivers.enumerated().reversed() {
            if(element.serialNumber == receiver.serialNumber) {
                BroadcastManager.receivers.remove(at: index)
            }
        }
    }
    
    func notifyAllReceivers(_ content: String) {
        for r in BroadcastManager.receivers {
            r.onReceive(content: content)
        }
    }
}

class Inbox {
    init() {
        let broadcastManager = BroadcastManager()
        let emailReceiver = MessageReceiver(0x0001)
        
        // register a reveicer
        broadcastManager.register(receiver: emailReceiver)
    }
    
    class MessageReceiver: Receiver {
        var serialNumber: Int = -1
        init (_ serialNumber: Int) {
            self.serialNumber = serialNumber
        }
        
        func onReceive (content: String) {
            print("You got a message(\(serialNumber)): \(content)")
        }
    }
}

class Notification {
    private let broadcastManager = BroadcastManager()
    private let notificationReceiver = MessageReceiver(0x0002)
    private var enable: Bool = false
    
    class MessageReceiver: Receiver {
        var serialNumber: Int = -1
        init (_ serialNumber: Int) {
            self.serialNumber = serialNumber
        }
        
        func onReceive (content: String) {
            print("A notification popped up(\(serialNumber)): \(content)")
        }
    }
    
    func showNotifications(enable: Bool) {
        if(enable && !self.enable) {
            broadcastManager.register(receiver: notificationReceiver)
        } else if (!enable && self.enable) {
            broadcastManager.unregister(receiver: notificationReceiver)
        }
        self.enable = enable
    }
}

class MessageCenter {
    private let broadcastManager = BroadcastManager()
    func sendMockMessage (content: String) {
        broadcastManager.sendMessage(content: content)
    }
}

var inbox = Inbox()
var notification = Notification()

var messageCenter = MessageCenter()
messageCenter.sendMockMessage(content: "你好啊")

// register another receiver
notification.showNotifications(enable: true)
messageCenter.sendMockMessage(content: "我是一个快乐的broadcast")

// unregister the Notification receiver
notification.showNotifications(enable: false)
messageCenter.sendMockMessage(content: "还有谁收到我？")

//
//  Message.swift
//  Flash Chat
//
//  This is the model class that represents the blueprint for a message

class Message {
    
    //TODO: Messages need a messageBody and a sender variable
    let sender: String
    let messageBody: String
    
    init(sender: String, messageBody: String) {
        self.sender = sender
        self.messageBody = messageBody
    }
    
}

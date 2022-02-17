//
//  ChatModel.swift
//  SkWhatsApp
//
//  Created by SUshil on 17/02/22.
//

import Foundation
import SwiftUI
struct Chat: Identifiable{
    var id:UUID{person.id}
    let person: Person
    var message:[Message]
    var hasUnreadMessage = false
    
}

struct Person: Identifiable{
    let id=UUID()
    let name:String
    let imgString:String
}

struct Message: Identifiable{
    enum Messagetype {
        case Send,Received
    }
    let id = UUID()
    let date:Date
    let text:String
    let type:Messagetype
    
    init(_ text:String,type:Messagetype, date:Date){
        self.date = date
        self.type = type
        self.text = text
    }
    init(_ text: String, type: Messagetype){
        self.init(text, type: type,date: Date())
    }
}

extension Chat{
    
    static let sampleChat = [
       Chat(person:Person(name: "sushil", imgString: "DSC02147~2.ARW"),message:[
            Message("hey nitu", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu ,this is me ", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey  whats about me ", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nothing ", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey jsdlajfljlwef;mdjlwjeslgdjljgwlj  jnskjkjajfh jkawfh jsuqweflkasjf jfjkfswe", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
          
            
        ],hasUnreadMessage: true),
       Chat(person:Person(name:"rohit", imgString: "DSC02147~2.ARW"),message:[
            Message("hey nitu", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu ,this is me ", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey  whats about me ", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nothing ", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey jsdlajfljlwef;mdjlwjeslgdjljgwlj", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu", type: .Send, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("hey nitu", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
    ],hasUnreadMessage: true)
       ]
}

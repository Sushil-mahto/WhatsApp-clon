//
//  ChatViewModel.swift
//  SkWhatsApp
//
//  Created by SUshil on 17/02/22.
//

import Foundation
class ChatViewModel:ObservableObject{
    @Published var chats = Chat.sampleChat
    
    func getSortFilteredChats(query:String)->[Chat]{
        let sortedChats = chats.sorted{
            guard let date1 = $0.message.last?.date else{return false}
            guard let date2 = $1.message.last?.date else{return false}
            return date1 > date2
        }
        if query == "" {
            return sortedChats
        }
        return sortedChats.filter{$0.person.name.lowercased().contains(query.lowercased())}
    }
    
    
    func markAsUnread(_ newValue:Bool,chat:Chat){
        if let index = chats.firstIndex(where:{$0.id == chat.id}){
            chats[index].hasUnreadMessage = newValue
        }
    }
    
    
    func sendMessage(_ text:String,in chat:Chat) -> Message? {
        if let index = chats.firstIndex(where: {$0.id == chat.id}){
            let message = Message(text,type: .Send)
            chats[index].message.append(message)
            return message
        }
        return nil
    }
}

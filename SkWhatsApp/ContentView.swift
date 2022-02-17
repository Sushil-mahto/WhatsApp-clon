//
//  ContentView.swift
//  SkWhatsApp
//
//  Created by SUshil on 17/02/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ChatViewModel()
    @State private var query = ""
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.getSortFilteredChats(query: query)){chat in
                    ZStack{
                        ChatRow(chat:chat)
                        NavigationLink(destination:{
                            ChatView(chat:chat).environmentObject(viewModel)
                        }){
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                    }
                    .swipeActions(edge:.leading,allowsFullSwipe: true){
                        Button(action:{
                            viewModel.markAsUnread(!chat.hasUnreadMessage, chat:chat)
                        }){
                            if chat.hasUnreadMessage{
                                Label("Read",systemImage:"text.bubble")
                            }else{
                                Label("Read",systemImage:"circle.fill")
                            }
                        }.tint(.blue)
                    }
                    
                }
                    
            }
            .listStyle(PlainListStyle())
            .searchable(text: $query)
            .navigationTitle("Chats")
            .navigationBarItems( trailing: Button(action: {}){Image(systemName: "square.and.pencil")})
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

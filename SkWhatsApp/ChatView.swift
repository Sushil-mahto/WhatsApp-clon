//
//  ChatView.swift
//  SkWhatsApp
//
//  Created by SUshil on 17/02/22.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var viewModel:ChatViewModel
    let chat: Chat
    @State private var text = ""
    @FocusState private var isFocused
    
    @State private var messageIDToScroll: UUID?
    
    var body: some View {
        VStack(spacing:0){
            GeometryReader{ reader in
                ScrollView{
                    ScrollViewReader{
                        scrollReader in
                        getMessageView(viewModel:reader.size.width)
                            .padding(.horizontal)
                            .onChange(of: messageIDToScroll){ _ in
                                if let messageID = messageIDToScroll{
                                 scrollTo(messageID: messageID, shouldAnimation: true, scrollReader: scrollReader)
                                }
                            }
                            .onAppear{
                                if let messageID = chat.message.last?.id{
                                    scrollTo(messageID: messageID,anchor: .bottom, shouldAnimation: true, scrollReader: scrollReader)
                                }
                            }
                    }
                   
                }
            }
            .padding(.bottom,5)
            
            toolbarView()
        
        }
        .padding(.top,1)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: navBarLeadingBtn, trailing: navBarTrailingBtn)
        .onAppear{
            viewModel.markAsUnread(false, chat: chat)
                
        }
    }
    var navBarLeadingBtn: some View{
        Button(action:{}){
            HStack{
                Image(chat.person.imgString)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(chat.person.name)
                    .bold()
            }.foregroundColor(Color.blue)
        }
    }
    var navBarTrailingBtn: some View{
        HStack{
            Button(action:{}){
                Image(systemName: "video")
            }
            Button(action:{}){
                Image(systemName: "phone")
            }
        }
    }
    
    func scrollTo(messageID:UUID,anchor: UnitPoint? = nil,shouldAnimation:Bool,
                  scrollReader:ScrollViewProxy){
        DispatchQueue.main.async {
            withAnimation(shouldAnimation ? Animation.easeIn:nil){
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    
    func toolbarView() -> some View{
        VStack{
            let height:CGFloat = 37
            HStack{
                TextField("message..",text:$text)
                    .padding(.horizontal,10)
                    .frame(height:height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .focused($isFocused)
                Button(action:sendMessage){
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color.white)
                        .frame(width: height, height: height)
                        .background(
                        Circle()
                            .foregroundColor(text.isEmpty ? .gray:.blue)
                        )
                }
                .disabled(text.isEmpty)
            }
            .frame(height:height)
          
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thinMaterial)
    }
    
    func sendMessage(){
        if let message = viewModel.sendMessage(text,in:chat){
            text = ""
            messageIDToScroll = message.id
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]
    
    func getMessageView(viewModel:CGFloat) -> some View{
        LazyVGrid(columns: columns, spacing: 0){
            ForEach(chat.message){message in
                let isReceived = message.type == .Received
                HStack{
                    ZStack{
                        Text(message.text)
                            .padding(.horizontal)
                            .padding(.vertical,12)
                            .background(isReceived ? Color.black.opacity(0.2) : .green.opacity(0.9))
                            .cornerRadius(12)
                    }
                    .frame(width:260, alignment: isReceived ? .leading:.trailing)
                    .padding(.vertical)
                    //.background(.blue)
                }
                .frame( maxWidth: .infinity,  alignment:isReceived ? .leading: .trailing )
                .id(message.id)
        }
    }
}
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ChatView(chat: Chat.sampleChat[0])
            .environmentObject(ChatViewModel())
        }
    }
}

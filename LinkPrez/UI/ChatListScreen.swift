//
//  ChatListScreen.swift
//  LinkPrez
//
//  Created by Jacob Bartlett on 03/02/2025.
//

import SwiftUI

struct ChatListScreen: View {
    
    @State private var reply: String = ""
    @State private var messages = chatMessages
    
    var body: some View {
        NavigationView {
            ChatList {
                TextField("Reply", text: $reply)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        if !reply.isEmpty {
                            withAnimation {
                                sendMessage()
                            }
                        }
                    }
                    .padding(.vertical)
                    .colorScheme(.light)
                
                ForEach(messages) { message in
                    if let linkMessage = message.linkMessage() {
                        LinkMessageView(message: linkMessage, fromYou: message.firstName == "Bob")
                    } else {
                        ChatMessageView(message: message, fromYou: message.firstName == "Bob")
                    }
                }
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func sendMessage() {
        let newMessage = ChatMessage(id: UUID().uuidString, firstName: "Bob", text: reply, date: Date())
        messages.append(newMessage)
        reply = ""
        if let linkMessage = newMessage.linkMessage() {
            prewarm(linkMessage.url)
        }
    }
}

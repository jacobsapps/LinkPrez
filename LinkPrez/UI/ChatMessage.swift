//
//  ChatMessage.swift
//  LinkPrez
//
//  Created by Jacob Bartlett on 03/02/2025.
//

import SwiftUI

struct ChatMessageView: View {
    
    let message: ChatMessage
    let fromYou: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            name
            
            HStack(alignment: .center, spacing: 8) {
                if fromYou {
                    timestamp
                }
                
                messageBubble
                
                if !fromYou {
                    timestamp
                }
            }
            .frame(maxWidth: .infinity, alignment: fromYou ? .trailing : .leading)
        }
    }
    
    private var name: some View {
        Text(message.firstName)
            .font(.footnote)
            .foregroundStyle(.secondary)
            .fontWeight(.medium)
            .offset(x: fromYou ? -20 : 20)
            .frame(maxWidth: .infinity, alignment: fromYou ? .trailing : .leading)
            .padding(.top)
    }
    
    private var messageBubble: some View {
        Text(message.text)
            .foregroundStyle(.white)
            .padding()
            .background(fromYou ? .blue : .green)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            .overlay(alignment: fromYou ? .bottomTrailing : .bottomLeading) {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.title)
                    .rotationEffect(.radians((fromYou ? -1 : 1) * .pi/4))
                    .scaleEffect(x: 0.8)
                    .offset(x: fromYou ? 12 : -12, y: 12)
                    .foregroundStyle(fromYou ? .blue : .green)
            }
    }
    
    private var timestamp: some View {
        Text(message.date.formatted(date: .omitted, time: .shortened))
            .font(.caption2)
            .foregroundStyle(.secondary)
            .fontWeight(.light)
    }
}

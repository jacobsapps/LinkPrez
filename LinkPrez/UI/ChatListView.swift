//
//  ChatListView.swift
//  LinkPrez
//
//  Created by Jacob Bartlett on 03/02/2025.
//

import SwiftUI

struct ChatList<Content: View>: View {
    
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        _VariadicView.Tree(ChatLayout()) {
            content
        }
    }
}

struct ChatLayout: _VariadicView_MultiViewRoot {
    
    func body(children: _VariadicView.Children) -> some View {
        List {
            ForEach(children) { child in
                child
                    .inverted()
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .inverted()
    }
}

struct Inverted: ViewModifier {
    func body(content: Content) -> some View {
        content
            .rotationEffect(.radians(Double.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

extension View {
    func inverted() -> some View {
        modifier(Inverted())
    }
}

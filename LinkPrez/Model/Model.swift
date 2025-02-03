//
//  LinkPrezApp.swift
//  LinkPrez
//
//  Created by Jacob Bartlett on 03/02/2025.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: String
    let firstName: String
    let text: String
    let date: Date
}

struct LinkMessage: Identifiable {
    let id: String
    let firstName: String
    let text: String
    let url: URL
    let linkRange: Range<String.Index>
    let date: Date
}

extension ChatMessage {
    func linkMessage() -> LinkMessage? {
        guard let (url, range) = detectLink(in: text) else {
            return nil
        }
        return LinkMessage(id: id,
                           firstName: firstName,
                           text: text,
                           url: url,
                           linkRange: range,
                           date: date)
    }
}

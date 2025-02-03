//
//  LinkUtils.swift
//  LinkPrez
//
//  Created by Jacob Bartlett on 03/02/2025.
//

import UIKit
import LinkPresentation

func linkAttributedString(from text: String, range: Range<String.Index>) -> AttributedString {
    var attributedString = AttributedString(text)

    if let startOfUnderline = AttributedString.Index(range.lowerBound, within: attributedString),
       let endOfUnderline = AttributedString.Index(range.upperBound, within: attributedString) {
        let underlineRange = startOfUnderline..<endOfUnderline
        attributedString[underlineRange].underlineStyle = .single
    }

    return attributedString
}

func detectLink(in text: String) -> (url: URL, range: Range<String.Index>)? {
    guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue),
          let linkMatch = detector.firstMatch(in: text, range: NSRange(location: 0, length: text.utf16.count)),
          let url = URL(string: (text as NSString).substring(with: linkMatch.range)),
          UIApplication.shared.canOpenURL(url),
          let stringRange = Range(linkMatch.range, in: text)
    else {
        return nil
    }
    return (url, stringRange)
}

func prewarm(_ url: URL) {
    let metadataProvider = LPMetadataProvider()
    metadataProvider.startFetchingMetadata(for: url) { metadata, error in
        if error != nil {
            return
        }
        
        metadata?.imageProvider?.loadPreviewImage(completionHandler: { _, _ in })
    }
}

func openLinkIfPossible(_ url: URL) {
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}

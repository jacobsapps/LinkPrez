//
//  LinkPreview.swift
//  LinkPrez
//
//  Created by Jacob Bartlett on 03/02/2025.
//

import SwiftUI
import LinkPresentation

struct LinkPreview: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> LinkPreviewView {
        let view = LinkPreviewView()
        view.url = url
        return view
    }
    
    func updateUIView(_ uiView: LinkPreviewView, context: Context) {
        uiView.url = url
    }
}

final class LinkPreviewView: UIView {
    private let linkView = LPLinkView()
    
    var url: URL? {
        didSet {
            if let url, url != oldValue {
                loadMetadata(for: url)
            }
        }
    }
    
    func loadMetadata(for url: URL) {
        let metadataProvider = LPMetadataProvider()
        
        metadataProvider.startFetchingMetadata(for: url) { [weak self] metadata, error in
            guard let metadata, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                guard let self else { return }
                self.linkView.metadata = metadata
                self.addSubview(self.linkView)
                self.linkView.frame = self.bounds
            }
        }
    }
}

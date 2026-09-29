//
//  PostViewModel.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import Foundation
import SwiftUI

@Observable
class PostViewModel{
    var post: Post
    var isMenuOpen: Bool
    var isExpanded: Bool
    var isTruncated: Bool {
        post.content.count > 300
    }
    var contentLineLimit: Int? {
        isExpanded ? nil : isTruncated ? 7 : nil
    }
    
    init(post: Post, isMenuOpen: Bool = false, isExpanded: Bool = false) {
        self.post = post
        self.isMenuOpen = isMenuOpen
        self.isExpanded = isExpanded
    }
    
    
}

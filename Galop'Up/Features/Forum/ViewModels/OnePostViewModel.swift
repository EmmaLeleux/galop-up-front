//
//  PostViewModel.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import Foundation
import SwiftUI

@Observable
class OnePostViewModel{
    var isMenuOpen: Bool
    var isExpanded: Bool
    
    func isTruncated(post: Post) -> Bool {
        post.content.count > 300
    }
    
    func contentLineLimit(post: Post) -> Int? {
        isExpanded ? nil : isTruncated(post: post) ? 7 : nil
    }
    
    init(isMenuOpen: Bool = false, isExpanded: Bool = false) {
        self.isMenuOpen = isMenuOpen
        self.isExpanded = isExpanded
    }
    
    
}

//
//  CreatePostViewModel.swift
//  Galop'Up
//
//  Created by Emma on 21/09/2026.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class CreatePostViewModel{
    var title: String = ""
    var content: String = ""
    var postPictureItem: [PhotosPickerItem] = []
    var postPictureData: [Data] = []
    var listImage: [UIImage] = []
}

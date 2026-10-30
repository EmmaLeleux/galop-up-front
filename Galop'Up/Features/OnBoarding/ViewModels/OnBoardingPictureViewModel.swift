//
//  OnBoardingPictureViewModel.swift
//  Galop'Up
//
//  Created by Emma on 10/08/2026.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class OnBoardingPictureViewModel{
    var avatarDefaultImage: Picture?
    var avatarImage: Image?
    var avatarItem: PhotosPickerItem?
    var avatarData: Data?
}

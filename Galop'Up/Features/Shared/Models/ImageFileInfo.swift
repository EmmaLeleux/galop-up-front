//
//  FileInfo.swift
//  Galop'Up
//
//  Created by Emma on 15/08/2026.
//

import UniformTypeIdentifiers
import ImageIO

struct ImageFileInfo {
    let fileExtension: String
    let mimeType: String
}

func detectImageFileInfo(from data: Data) -> ImageFileInfo {
    guard let source = CGImageSourceCreateWithData(data as CFData, nil),
          let utiString = CGImageSourceGetType(source) as String?,
          let utType = UTType(utiString) else {
        return ImageFileInfo(fileExtension: "jpg", mimeType: "image/jpeg")
    }

    return ImageFileInfo(
        fileExtension: utType.preferredFilenameExtension ?? "jpg",
        mimeType: utType.preferredMIMEType ?? "image/jpeg"
    )
}

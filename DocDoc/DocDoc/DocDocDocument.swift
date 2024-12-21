//
//  DocDocDocument.swift
//  DocDoc
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
}

struct DocDocDocument: FileDocument {
    var text: String
    var lastModified: Date
    
    init(text: String = "Hello, world!") {
        self.text = text
        self.lastModified = Date()
    }
    
    static var readableContentTypes: [UTType] { [.exampleText, .plainText] }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
        lastModified = Date()
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}

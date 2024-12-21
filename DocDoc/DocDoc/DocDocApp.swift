//
//  DocDocApp.swift
//  DocDoc
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

@main
struct DocDocApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: DocDocDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}

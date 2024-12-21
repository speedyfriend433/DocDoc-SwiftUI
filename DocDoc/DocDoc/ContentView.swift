//
//  ContentView.swift
//  DocDoc
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: DocDocDocument
    @State private var fontSize: CGFloat = 14
    @State private var isBold: Bool = false
    @State private var isItalic: Bool = false
    @State private var showingWordCount = false
    
    var wordCount: Int {
        document.text.split(separator: " ").count
    }
    
    var characterCount: Int {
        document.text.count
    }
    
    var formattedLastModified: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: document.lastModified)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Toolbar
            HStack {
                // Font size controls
                Button(action: { fontSize -= 2 }) {
                    Image(systemName: "minus.circle")
                }
                Text("\(Int(fontSize))")
                    .frame(width: 30)
                Button(action: { fontSize += 2 }) {
                    Image(systemName: "plus.circle")
                }
                
                Divider()
                    .frame(height: 20)
                    .padding(.horizontal)
                
                // Text style controls
                Button(action: { isBold.toggle() }) {
                    Image(systemName: "bold")
                }
                .foregroundColor(isBold ? .accentColor : .primary)
                
                Button(action: { isItalic.toggle() }) {
                    Image(systemName: "italic")
                }
                .foregroundColor(isItalic ? .accentColor : .primary)
                
                Spacer()
                
                // Word count button
                Button(action: { showingWordCount.toggle() }) {
                    Image(systemName: "character.cursor.ibeam")
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .shadow(radius: 1)
            
            // Last modified date
            HStack {
                Text("Last modified: \(formattedLastModified)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            
            // Text Editor
            TextEditor(text: Binding(
                get: { document.text },
                set: {
                    document.text = $0
                    document.lastModified = Date()
                }
            ))
            .font(.system(size: fontSize,
                        weight: isBold ? .bold : .regular,
                        design: .default))
            .italic(isItalic)
            .padding()
        }
        .sheet(isPresented: $showingWordCount) {
            DocumentStatsView(wordCount: wordCount,
                            characterCount: characterCount)
        }
    }
}

struct DocumentStatsView: View {
    let wordCount: Int
    let characterCount: Int
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Words")
                    Spacer()
                    Text("\(wordCount)")
                }
                HStack {
                    Text("Characters")
                    Spacer()
                    Text("\(characterCount)")
                }
            }
            .navigationTitle("Document Statistics")
        }
    }
}

#Preview {
    ContentView(document: .constant(DocDocDocument()))
}

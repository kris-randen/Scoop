//
//  TextFieldAutoCompleteView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

@available(iOS 15.0, *)
public struct TextFieldAutoCompleteView: View {
    @State private var text: String = ""
    @State private var suggestions: [String] = ["Apple", "Banana", "Cherry", "Date", "Orange", "Custard Apple", "Pineapple"]
    @State private var showSuggestions: Bool = false

    public var body: some View {
        VStack {
            TextField("Type something...", text: $text, onEditingChanged: { isEditing in
                // Show suggestions when the text field is being edited
                showSuggestions = isEditing && !text.isEmpty
            })
            .onChange(of: text) { newValue in
                // Hide suggestions when there's no text
                showSuggestions = !newValue.isEmpty
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()

            // Suggestions List
            if showSuggestions {
                List {
                    ForEach(filteredSuggestions(), id: \.self) { suggestion in
                        Text(suggestion).onTapGesture {
                            // On selecting a suggestion, update the text and hide suggestions
                            self.text = suggestion
                            self.showSuggestions = false
                        }
                    }
                }
                .frame(maxHeight: 200) // Limit the height of the suggestions list
            }
        }
    }

    // Filter suggestions based on the text input
    func filteredSuggestions() -> [String] {
        let filtered = suggestions.filter { $0.lowercased().contains(text.lowercased()) }
        return filtered.isEmpty ? suggestions : filtered
    }
}

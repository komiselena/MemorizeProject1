//
//  EmojiMemoryTheme.swift
//  Memorize
//
//  Created by Mac on 13.12.2023.
//

import Foundation

struct EmojiMemoryTheme: Codable, Identifiable, Hashable {
    var name: String
    var emojis: [String]
    var id = UUID()
    
    static var templates: [EmojiMemoryTheme] { [
        EmojiMemoryTheme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "🧛‍♀️", "👽", "😱", "🥷", "🧟‍♂️", "🕸️", "⚡️"]),
        EmojiMemoryTheme(name: "Vehicle", emojis: ["🚌", "🚜", "🚗", "🛵", "🛺", "🚀", "🚢", "🛸", "✈️", "🚁"]),
        EmojiMemoryTheme(name: "Fruit", emojis: ["🫐", "🍒", "🥑", "🍑", "🥭", "🍍", "🍇", "🥥", "🥝", "🍓"]),
        EmojiMemoryTheme(name: "Flags", emojis: ["🇦🇹","🇨🇦","🇺🇳","🇷🇺","🇰🇷","🇷🇸","🇬🇧","🇱🇨","🇸🇬","🏴‍☠️"]),
        EmojiMemoryTheme(name: "Sport", emojis: ["🏀","⚽️","🏈","🏐","🏓","🥌","🛹","🏏","🎣","🏹"]),
        EmojiMemoryTheme(name: "Animals", emojis: ["🐶","🐐","🦍","🐖","🐼","🦄","🦋","🐣","🦖","🪼"]),
    ]}
    
}

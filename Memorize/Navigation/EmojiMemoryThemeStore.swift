//
//  EmojiMemoryThemeStore.swift
//  Memorize
//
//  Created by Mac on 14.12.2023.
//

import SwiftUI

extension UserDefaults {
    func themes(forKey key: String) -> [EmojiMemoryTheme]{
        if let jsonData = data(forKey: key),
           let decodedThemes = try?
            JSONDecoder().decode([EmojiMemoryTheme].self, from: jsonData){
            return decodedThemes
        } else {
            return []
        }
    }
    func set(_ themes: [EmojiMemoryTheme], forKey key: String) {
        let data = try? JSONEncoder().encode(themes)
        set(data, forKey: key)
    }
}

class EmojiMemoryThemeStore: ObservableObject, Identifiable {
    let name: String
    var id: String { name }
    
    private var userDefaultsKey: String { "ThemeStore: " + name }
    
    var themes: [EmojiMemoryTheme] {
        get {
            UserDefaults.standard.themes(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty{
                UserDefaults.standard.set(newValue,forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    init(named name: String) {
        self.name = name 
        if themes.isEmpty{
            themes = EmojiMemoryTheme.templates
            if themes.isEmpty {
                themes = [EmojiMemoryTheme(name: "Warning", emojis: ["⚠️"])]
            }
        }
    }
}



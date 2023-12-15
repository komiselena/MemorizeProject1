//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Mac on 13.11.2023.
//

import SwiftUI

@main
struct MemorizeApp: App{
    @StateObject var game = EmojiMemoryGame()
    @StateObject var themeStore = EmojiMemoryThemeStore(named: "Main")
    
    var body: some Scene{
        WindowGroup{
            EmojiMemoryGameView(viewModel: game, store: themeStore)
        }
    }
}

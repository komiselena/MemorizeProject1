//
//  ThemeList.swift
//  Memorize
//
//  Created by Mac on 15.12.2023.
//

import SwiftUI

struct ThemeList: View {
    
    @EnvironmentObject var store: EmojiMemoryThemeStore
    @EnvironmentObject var viewModel: EmojiMemoryGame


    var body: some View {
        NavigationStack{
            List(store.themes){ theme in
                NavigationLink(value: theme){
                    Text(theme.name)
                }
            }
            .navigationTitle("Themes")
            .navigationDestination(for: EmojiMemoryTheme.self) {theme in
                ThemeView(theme: theme)
            }
            
        }
    }
}

struct ThemeView: View {
    let theme: EmojiMemoryTheme
    @EnvironmentObject var viewModel: EmojiMemoryGame
    
    var body: some View{
        viewModel.createMemoryGame(with: theme.emojis)
        
    }
    
}
 

#Preview {
    ThemeList()
}

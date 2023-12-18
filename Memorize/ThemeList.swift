//
//  ThemeList.swift
//  Memorize
//
//  Created by Mac on 15.12.2023.
//

import SwiftUI

struct ThemeList: View {
    
    typealias themes = EmojiMemoryTheme
    @ObservedObject var store: EmojiMemoryThemeStore
    @EnvironmentObject var viewModel: EmojiMemoryGame


    var body: some View {
        NavigationStack{
            List(store.themes){ theme in
                NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))){
                    Text(theme.name)
                }
            }
            .navigationTitle("Themes")
        }
    }
}
 

#Preview {
    ThemeList(store: EmojiMemoryThemeStore(named: "preview"))
}

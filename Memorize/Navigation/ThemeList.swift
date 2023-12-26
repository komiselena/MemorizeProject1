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
    @State private var showContent = false
    @State private var selectedTheme: EmojiMemoryTheme?

    var body: some View {
        NavigationStack{
            List(store.themes){ theme in
                NavigationLink(destination: {
                    Text(theme.name)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .offset(y: -50)
                    EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
                }){
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

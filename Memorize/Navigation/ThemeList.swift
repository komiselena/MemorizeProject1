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
                    Text("Memorize!")
                        .offset(y: -40)
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                        .bold()
                    Text(theme.name)
                        .font(.title)
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

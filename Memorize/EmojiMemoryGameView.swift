//
//  ContentView.swift
//  Memorize
//
//  Created by Mac on 13.11.2023.
//


// Это View игры. То что у нас отображается на экране
import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    typealias Card = MemoryGame<String>.Card
    
    private let aspectRatio: CGFloat = 3/4
    private let spacing: CGFloat = 4
    
    var body: some View {
        
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
            Text("Score: \(viewModel.score)")
                .font(.title2)
            cards
                    .animation(.default, value: viewModel.cards)
            HStack{
                Button("Shuffle"){
                    viewModel.shuffle()
                }
                Spacer()
                Button("New Game"){
                    viewModel.newGame()
                    viewModel.shuffle()
                }
            }
        }
        .padding()
    }

    
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card: card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
            }
        .foregroundColor(viewModel.color)
    }
}

// Структура того как выглядят карточки
    

    
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}


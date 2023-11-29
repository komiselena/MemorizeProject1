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
            score
            cards
            HStack{
                buttonShuffle
                Spacer()
                buttonNewGame
            }
        }
        .padding()
    }

    private var score: some View{
        Text("Score: \(viewModel.score)")
            .font(.title2)
            .animation(nil)
    }
    private var buttonNewGame: some View{
        Button("New Game"){
            viewModel.newGame()
            viewModel.shuffle()
        }
    }
    private var buttonShuffle: some View{
        Button("Shuffle"){
            withAnimation{
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card: card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)){
                        viewModel.choose(card)
                    }
                }
            }
        .foregroundColor(viewModel.color)
    }
    
    private func scoreChange(causedBy: Card) -> Int{
        return 0
    }
    
}

// Структура того как выглядят карточки
    

    
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}


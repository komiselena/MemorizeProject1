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
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            HStack{
                Button("Shuffle"){
                    viewModel.shuffle()
                }
                Spacer()
                Button("New Game"){
                    viewModel.newGame()
                    // вот тут viewModel должно передавать значение view, чтобы появлялась новая тема карточек, но оно почему-то не отображается.
                }
            }
        }
        .padding()
        
    }
    
    
    var cards: some View{
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(Color.orange)
    }
    // 
}
    
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
        
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
                
            }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        }
    }
// Структура того как выглядят карточки
    

    
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}


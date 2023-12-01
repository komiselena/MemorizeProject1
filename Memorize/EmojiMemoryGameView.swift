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
    
    private let aspectRatio: CGFloat = 4/5
    private let spacing: CGFloat = 4
    private let dealInterval = 0.15
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
            score
            cards
            HStack{
                buttonShuffle
                Spacer()
<<<<<<< HEAD
                deck.foregroundColor(.orange)
                Spacer()
=======
>>>>>>> main
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
<<<<<<< HEAD
            if isDealt(card){
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    
=======
            CardView(card: card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)){
                        viewModel.choose(card)
                    }
                }
>>>>>>> main
            }
        }
        
        .foregroundColor(viewModel.color)
    }
    
<<<<<<< HEAD
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture{
            deal()
        }
    }
    
    private func deal(){
        //раздача карт
        var delay: TimeInterval = 0
        for card in viewModel.cards{
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }

    
    private func choose(_ card: Card){
        withAnimation{
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id )
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int{
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
=======
    private func scoreChange(causedBy: Card) -> Int{
        return 0
>>>>>>> main
    }
    
}

// Структура того как выглядят карточки
    

    
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}


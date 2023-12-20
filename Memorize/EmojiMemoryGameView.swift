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
    @ObservedObject var stopwatchManager = StopwatchManager()
    @State var isProgressView = true
    @State private var isDelayOut = false

    
    private let aspectRatio: CGFloat = 3/4
    private let spacing: CGFloat = 4
    private let dealInterval = 0.15
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack(alignment: .center) {
            if !isProgressView{
                HStack{
                    score
                    Spacer()
                    TimerView()
                }
                Spacer()
                cards
                    .foregroundColor(.orange)
                HStack{
                    buttonShuffle
                    Spacer()
                    buttonNewGame
                }
                
            } else {
                ProgressView()
                    .scaleEffect(3)
                    .tint(.orange)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            withAnimation{
                                isProgressView = false
                                isDelayOut = true
                            }
                        }
                    }
            }
        }
                .padding()
                .onChange(of: isDelayOut){ newValue in
                    if newValue {
                        isDelayOut = true
                        isProgressView = false
                    }
                    
                }
        
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
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.orange))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
    private var buttonShuffle: some View{
        Button("Shuffle"){
            withAnimation{
                viewModel.shuffle()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.orange))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
    
    private var cards: some View {
        return AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            view(for: card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                .onTapGesture {
                    choose(card)
                }
        }
    }
    
    private func view(for card: Card) -> some View {
        CardView(card)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    // MARK: - Dealing from a Deck
    
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
                view(for: card)
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0.5
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}



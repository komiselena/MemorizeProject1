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
    private let aspectRatio: CGFloat = 3/4
    private let spacing: CGFloat = 4

    
    var body: some View {
        VStack {
            if !viewModel.allCardsMatched{
                VStack(alignment: .center) {
                    HStack {
                        score
                        Spacer()
                        TimerView
                    }
                    .padding()

                    cards
                        .foregroundColor(.orange)

                    HStack {
                        buttonShuffle
                        Spacer()
                        buttonNewGame
                    }
                    .padding()
                }
                .onAppear{
                    stopwatchManager.start()
                }

                .padding()
             } else {
                    FinishView(
                    viewModel: EmojiMemoryGame(),
                    stopwatchManager: stopwatchManager,
                    themeList: ThemeList(store: EmojiMemoryThemeStore(named: "Store"), viewModel: EmojiMemoryGame(), allCardsMatch: false), finishTime: stopwatchManager.finishSeconds,
                    finalScore: viewModel.score
                    )
                    .onAppear {
                        stopwatchManager.finishSeconds = stopwatchManager.secondElapsed
                    }
            }
             

            
        }
        .background(Color.color)

    }
    
    private var TimerView: some View{
        Text(String(format: "%.1f", stopwatchManager.secondElapsed))
            .font(.system(size: 30))
            .foregroundColor(.white)
            .glowBorder(color: .black, lineWidth: 2)
    }
    
    private var score: some View{
        Text("Score: \(viewModel.score)")
            .font(.system(size: 30))
            .animation(nil)
            .foregroundColor(.white)
            .glowBorder(color: .black, lineWidth: 2)
    }
    private var buttonNewGame: some View{
        Button("New Game"){
            withAnimation{
                viewModel.newGame()
                viewModel.shuffle()
                stopwatchManager.start()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.orange))
        .cornerRadius(10)
        .foregroundColor(.white)
        .glowBorder(color: .black, lineWidth: 2)
    }
    private var buttonShuffle: some View{
        Button("Shuffle"){
            withAnimation(.easeInOut){
                viewModel.shuffle()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.orange))
        .cornerRadius(10)
        .foregroundColor(.white)
        .glowBorder(color: .black, lineWidth: 2)
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
    
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}



//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mac on 22.12.2023.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject{

    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var store: EmojiMemoryThemeStore
    private var chosenTheme: EmojiMemoryTheme
    private(set) var model: MemoryGame<String>
    @ObservedObject var stopWatch: StopwatchManager





    init(theme: EmojiMemoryTheme? = nil) {
        self.store = EmojiMemoryThemeStore(named: "Store")
        self.chosenTheme = theme ?? EmojiMemoryTheme.templates.randomElement()!
        let emojis = self.chosenTheme.emojis.shuffled()
        model = MemoryGame(numberOfPairsOfCards: self.chosenTheme.emojis.count) { emojis[$0] }
        stopWatch = StopwatchManager()
    }

    
    func createMemoryGame(with emojis: [String]) -> MemoryGame<String> {
        let shuffledEmojis = emojis.shuffled()
        return MemoryGame(numberOfPairsOfCards: shuffledEmojis.count) { pairIndex in
            guard shuffledEmojis.indices.contains(pairIndex) else {
                return "⁉️"
            }
            return shuffledEmojis[pairIndex]
        }
    }
    
    func newGame() {
        self.model = createMemoryGame(with: chosenTheme.emojis)
        objectWillChange.send()
        stopWatch.start()
    }
    

    var cards: Array<Card> {
        model.cards
    }
    
    var allCardsMatched: Bool{
        model.allCardsMatched
    }

    var color: Color{
        .orange
    }

    var score: Int {
        model.score
    }

    // MARK: - Intents

    
    func shuffle(){
        model.shuffle()
        objectWillChange.send()
    }
    // Функция, которая перемешиввет карты.

    func choose(_ card: Card){
        model.choose(card)
        objectWillChange.send()
    }
    
    
}

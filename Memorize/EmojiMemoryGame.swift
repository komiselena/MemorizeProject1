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
    private(set) var chosenTheme: EmojiMemoryTheme
    @Published private(set) var model: MemoryGame<String>
    
    func newGame(){
        self.model = createMemoryGame(with: chosenTheme.emojis)
        objectWillChange.send()
    }
    /*
     func newGame(){
         let randomTheme: [String] = EmojiMemoryGame.ThemeEmojis.randomElement() ?? []
         self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
         objectWillChange.send()
     }
     */
    // chosenTheme это тема которую пользователь выбрал в навигации
    
    init(theme: EmojiMemoryTheme? = nil) {
        self.store = EmojiMemoryThemeStore(named: "Store")
        self.chosenTheme = theme ?? EmojiMemoryTheme.templates.randomElement()!
        let emojis = self.chosenTheme.emojis.shuffled()
        model = MemoryGame(numberOfPairsOfCards: self.chosenTheme.emojis.count) { emojis[$0] }
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
        

    var cards: Array<Card> {
        model.cards
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

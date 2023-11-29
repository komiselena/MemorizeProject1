//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mac on 13.11.2023.
//




// Это View Model. То что связывает Model c View.
import SwiftUI


class EmojiMemoryGame: ObservableObject{

typealias Card = MemoryGame<String>.Card
    
    private static let Halloweenemojis = ["👻", "🎃", "🕷️", "🧛‍♀️", "👽", "😱", "🥷", "🧟‍♂️", "🕸️", "⚡️"]
    
    private static let VehicleEmojis = ["🚌", "🚜", "🚗", "🛵", "🛺", "🚀", "🚢", "🛸", "✈️", "🚁"]
    
    private static let FruitEmojis = ["🫐", "🍒", "🥑", "🍑", "🥭", "🍍", "🍇", "🥥", "🥝", "🍓"]
    
    private static let FlagsEmojis = ["🇦🇹","🇨🇦","🇺🇳","🇷🇺","🇰🇷","🇷🇸","🇬🇧","🇱🇨","🇸🇬","🏴‍☠️"]
    
    private static let SportEmojis = ["🏀","⚽️","🏈","🏐","🏓","🥌","🛹","🏏","🎣","🏹"]
    
    private static let AnimalEmojis = ["🐶","🐐","🦍","🐖","🐼","🦄","🦋","🐣","🦖","🪼"]
    
    static let ThemeEmojis = [Halloweenemojis, VehicleEmojis, FruitEmojis, FlagsEmojis, SportEmojis, AnimalEmojis]
    // массив с темами эмоджи
    
    func newGame(){
        let randomTheme: [String] = EmojiMemoryGame.ThemeEmojis.randomElement() ?? []
        self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
        objectWillChange.send()
    }
    // Здесь функция для того, чтобы появлялась новая игра с новой темой, рандомно выбранной из массива тем.

    init() {
        let randomTheme: [String] = EmojiMemoryGame.ThemeEmojis.randomElement() ?? []
        self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
    }
    
    static func createMemoryGame(with theme: [String]) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.count) { pairIndex in
            guard theme.indices.contains(pairIndex) else{
                return "⁉️"
            }
            return theme[pairIndex]
        }
    }
        
    @Published private var model: MemoryGame<String>

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
    }
    
    
}

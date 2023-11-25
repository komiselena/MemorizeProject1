//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mac on 13.11.2023.
//




// Это View Model. То что связывает Model c View.
import SwiftUI


class EmojiMemoryGame: ObservableObject{


    
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
        score = 0
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
    
    @Published var score: Int = 0

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func score(for card: MemoryGame<String>.Card) -> Int {
        return card.score
    }


    // MARK: - Intents

    
    func shuffle(){
        model.shuffle()
        objectWillChange.send()
    }
    // Функция, которая перемешиввет карты.

    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
        updateScore()
    }
    
    func scoring(_ card: MemoryGame<String>.Card){
        model.scoring(card)
        updateScore()
    }
    private func updateScore(){
        score = model.calculateScore()
        objectWillChange.send()
    }
    
}

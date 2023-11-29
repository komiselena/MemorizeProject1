//
//  File.swift
//  Memorize
//
//  Created by Mac on 13.11.2023.
//


// Это Model игры.
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))

        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{
            cards.indices.filter { index in cards[index].isFaceUp }.only
/*            for index in cards.indices{
                    if cards[index].isFaceUp{
                        faceUpCardIndicies.append(index)
                    }
                }
            if faceUpCardIndicies.count == 1{
                return faceUpCardIndicies.first
            }else{
                return nil
            }
 */
        }
        set{
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
/*
            for index in cards.indices{
              if index == newValue{
                    cards[index].isFaceUp = true
                }else{
                    cards[index].isFaceUp = false
                }
            }
 */
        }
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where:{ $0.id == card.id}){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }else{
                        if cards[chosenIndex].hasBeenSeen{
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen{
                                score -= 1
                            }
                        }
                }else{
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }

    
    mutating func shuffle(){
        cards.shuffle()
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isFaceUp: Bool = false{
            didSet{
                if oldValue && !isFaceUp{
                    hasBeenSeen = true
                }
            }
        }
        var isMatched: Bool = false
        let content: CardContent
        var hasBeenSeen: Bool = false
        
        
        var score: Int = 0
        var id: String

        var debugDescription: String {
            return "\(id): \(content), \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
        
    }
    
}

extension Array{
    var only: Element?{
        count == 1 ? first : nil
    }
}

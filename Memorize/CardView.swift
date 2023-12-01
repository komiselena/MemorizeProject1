//
//  CardView.swift
//  Memorize
//
//  Created by Mac on 28.11.2023.
//

import SwiftUI


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(card: MemoryGame<String>.Card) {
        self.card = card
    }

    
    var body: some View {
        TimelineView(.animation){ timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            }else{
                Color.clear
            }
        }
    }
    
    var cardContents: some View{
            Text(card.content)
                .font(.system(size: Constants.FontSize.largest))
                .minimumScaleFactor(Constants.FontSize.smallest /
                                    Constants.FontSize.largest)
                .aspectRatio(1, contentMode: .fit)
                .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie{
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
        
    }
}

extension Animation{
    static func spin(duration: TimeInterval) -> Animation{
        linear(duration: 1).repeatForever(autoreverses: false)
    }
}


struct CardView_Previews: PreviewProvider {
    typealias Card = MemoryGame<String>.Card
    static var previews: some View {
        CardView(card: Card(content: "X", id: "test1"))
            .padding ()
            .foregroundColor (.green)
    }
}

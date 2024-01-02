//
//  FinishView.swift
//  Memorize
//
//  Created by Mac on 22.12.2023.
//

import SwiftUI

struct FinishView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @ObservedObject var stopWatch: StopwatchManager
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6110873818, blue: 0.5621060729, alpha: 1))],
                           center: .bottom,
                           startRadius: 70, endRadius: 500)
            .ignoresSafeArea()
            Text("Good Job!")
                .font(.system(size: 70, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .offset(y: -250)
                .glowBorder(color: .black, lineWidth: 5)
            HStack{
                Text("You have scored: \(viewModel.score)")
                .font(.title)
                .padding(50)
                .foregroundColor(.white)
                .lineLimit(4)
                Spacer()
                Text("You did it in: \(stopWatch.secondElapsed) seconds")
                .font(.title)
                .padding(50)
                .foregroundColor(.white)
                .lineLimit(4)
                
            }
            
        }
        .onAppear {
            if viewModel.isFinishView {
                stopWatch.stop()
            }
        }
        
    }

}

#Preview {
    FinishView(viewModel: EmojiMemoryGame(), stopWatch: StopwatchManager())
}

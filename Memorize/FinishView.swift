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
            RadialGradient(colors: [Color(#colorLiteral(red: 1, green: 0.5757583976, blue: 0.3030374944, alpha: 1)), Color(#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1))],
                           center: .center,
                           startRadius: 5, endRadius: 500)
            .ignoresSafeArea()
            Text("Good Job!!")
                .font(.system(size: 70, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .offset(y: -250)
            HStack{
                Text("""
                You have
                scored: \(viewModel.score)
                """)
                .font(.title)
                .padding(50)
                .foregroundColor(.white)
                Spacer()
                Text("""
                    You did it in:
                    \(stopWatch.finishSeconds)
                    """)
                .font(.title)
                .padding(50)
                .foregroundColor(.white)
                
            }
        }
        
    }
}

#Preview {
    FinishView(viewModel: EmojiMemoryGame(), stopWatch: StopwatchManager())
}

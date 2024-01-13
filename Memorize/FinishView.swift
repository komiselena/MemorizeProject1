//
//  FinishView.swift
//  Memorize
//
//  Created by Mac on 22.12.2023.
//

import SwiftUI

struct FinishView: View {
    @State var showThemeList = false
    @ObservedObject var viewModel: EmojiMemoryGame
    @ObservedObject var stopwatchManager: StopwatchManager
    var  finishTime: TimeInterval
    var finalScore: Int
    @State var replayGame = false
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6110873818, blue: 0.5621060729, alpha: 1))],
                           center: .bottom,
                           startRadius: 100, endRadius: 500)
            .ignoresSafeArea()
            
            labelGoodJob
            
            labels

            Image("FinishViewPicture")
                .resizable()
                .scaledToFit()
                .offset()
            
            buttons
                
            }

        
    }
    
    var buttons: some View{
        VStack{
            if showThemeList{
                withAnimation{
                    ThemeList(store: EmojiMemoryThemeStore(named: "store"), viewModel: EmojiMemoryGame())
                }
            }else{
                ZStack{
                    RoundedRectangle(cornerRadius: 50.0)
                        .frame(width: 270, height: 80)
                        .foregroundColor(.orange)
                        .offset(y: 230)
                    
                    Button("Menu"){
                        showThemeList.toggle()
                    }
                    .frame(width: 260, height: 70)
                    .foregroundColor(.orange)
                    .font(.title)
                    .background(Color(.white))
                    .shadow(radius: 20)
                    .cornerRadius(50)
                    .offset(y: 230)
                }
            }
            
                ZStack{
                    RoundedRectangle(cornerRadius: 50.0)
                        .frame(width: 270, height: 80)
                        .foregroundColor(.orange)
                        .offset(y: 230)
                    
                    Button("Replay"){
                        viewModel.newGame()
                        viewModel.shuffle()
                        stopwatchManager.start()
                        replayGame.toggle()
                    }
                    .frame(width: 260, height: 70)
                    .foregroundColor(.orange)
                    .font(.title)
                    .background(Color(.white))
                    .shadow(radius: 20)
                    .cornerRadius(50)
                    .offset(y: 230)
                }
            }
    }
    
    var labelGoodJob: some View{
        HStack{
            Text("Good Job!")
                .font(.system(size: 70, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .offset(y: -270)
                .glowBorder(color: .black, lineWidth: 5)
        }
    }
    
    var labels: some View {
        HStack {
                Text("You have scored: \(finalScore)")
                    .font(.title)
                    .foregroundColor(.black)
                    .lineLimit(4)
                    .glowBorder(color: .white, lineWidth: 20)
                Spacer()
                Text("You did it in: \(formattedFinishTime)")
                .font(.title)
                .foregroundColor(.black)
                .glowBorder(color: .white, lineWidth: 20)

            

        }
        .offset(y: -160)
    }

    private var formattedFinishTime: String {
        let minutes = Int(stopwatchManager.finishSeconds) / 60
        let seconds = Int(stopwatchManager.finishSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    

    
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemoryGame()
        let stopwatchManager = StopwatchManager()
        
        return FinishView(viewModel: viewModel, stopwatchManager: stopwatchManager, finishTime: stopwatchManager.finishSeconds, finalScore: viewModel.score)
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}

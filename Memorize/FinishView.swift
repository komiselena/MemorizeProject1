//
//  FinishView.swift
//  Memorize
//
//  Created by Mac on 22.12.2023.
//

import SwiftUI

struct FinishView: View {
    @State var showThemeList = false
    @State private var isReplayButtonTapped = false
    @ObservedObject var viewModel: EmojiMemoryGame
    @ObservedObject var stopwatchManager: StopwatchManager
    var themeList: ThemeList
    var  finishTime: TimeInterval
    var finalScore: Int
    
    var body: some View {
            ZStack{
                RadialGradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6110873818, blue: 0.5621060729, alpha: 1))],
                               center: .bottom,
                               startRadius: 100, endRadius: 500)
                .ignoresSafeArea()
                
                labels
                
                Image("FinishViewPicture")
                    .resizable()
                    .scaledToFit()
                    .offset(y: -40)
                
                buttons
                
            }
/*            .fullScreenCover(isPresented: $isReplayButtonTapped, content: {
                EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: themeList.chosenTheme))
            })
*/
    }
    
    var buttons: some View{
        VStack{
            if showThemeList{
                withAnimation{
                    ThemeList(store: EmojiMemoryThemeStore(named: "store"), viewModel: EmojiMemoryGame(), allCardsMatch: false)
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
                        isReplayButtonTapped = true
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
            .offset(y: -30)


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
        .padding()
        .offset(y: -250)
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
        let themeList = ThemeList(store: EmojiMemoryThemeStore(named: "Store"), viewModel: EmojiMemoryGame(), allCardsMatch: false)
        
        return FinishView(viewModel: viewModel, stopwatchManager: stopwatchManager, themeList: ThemeList(store: EmojiMemoryThemeStore(named: "Store"), viewModel: EmojiMemoryGame(theme: themeList.chosenTheme), allCardsMatch: false), finishTime: stopwatchManager.finishSeconds, finalScore: viewModel.score)
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}

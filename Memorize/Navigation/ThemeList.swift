//
//  ThemeList.swift
//  Memorize
//
//  Created by Mac on 15.12.2023.
//

import SwiftUI

struct ThemeList: View {
    
    typealias themes = EmojiMemoryTheme
    @ObservedObject var store: EmojiMemoryThemeStore
    @ObservedObject var viewModel: EmojiMemoryGame
    @ObservedObject var stopwatchManager = StopwatchManager()
    @State private var isProgressView = true
    @State private var isDelayOut = false
    @State var chosenTheme: EmojiMemoryTheme?
    @State var allCardsMatch: Bool{
        didSet{
            allCardsMatch = viewModel.allCardsMatched
        }
    }
    
    var body: some View {
            VStack{
                if !isProgressView{
                    VStack(alignment: .center){
                        VStack{
                            Text("Memorize!")
                                .font(.system(size: 50, weight: .semibold, design: .rounded))
                                .foregroundColor(.orange)
                                .offset(y: 5)
                                .glowBorder(color: .black, lineWidth: 2)
                        }
                        
                        NavigationStack{
                            ZStack{
                                RadialGradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6110873818, blue: 0.5621060729, alpha: 1))],
                                               center: .bottom,
                                               startRadius: 70, endRadius: 500)
                                .ignoresSafeArea()
                                VStack{
                                    ForEach(store.themes){ theme in
                                            NavigationLink(destination: {
                                                VStack{

                                                    Text(theme.name)
                                                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.white)
                                                        .glowBorder(color: .black, lineWidth: 5)
                                                    EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
                                                    
                                                }
                                                .navigationBarBackButtonHidden()
                                                .background(Color.color)
                                                .onAppear{
                                                    chosenTheme = theme 
                                                }

                                            }){
                                                ThemeButton(theme: theme)
                                            }
                                            

                                    }
                                    
                                }
                                
                            }
                            
                        }  
                        .toolbar(.hidden)

                        
                    }

                    
                } else {
                    ZStack{
                        RadialGradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6110873818, blue: 0.5621060729, alpha: 1))],
                                       center: .center,
                                       startRadius: 70, endRadius: 500)
                        .ignoresSafeArea()
                        ProgressView()
                            .scaleEffect(3)
                            .tint(.blue)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                                    withAnimation{
                                        isProgressView = false
                                        isDelayOut = true
                                    }
                                }
                            }
                            .padding()
                            .onChange(of: isDelayOut){ newValue in
                                if newValue {
                                    stopwatchManager.timer.invalidate()
                                    isDelayOut = true
                                    isProgressView = false
                                    stopwatchManager.start()
                                }
                            }
                    }
                    
                }
                
                
            }
            
            .background(Color.color)
            
        }
    
    
}



#Preview {
    ThemeList(store: EmojiMemoryThemeStore(named: "preview"), viewModel: EmojiMemoryGame(), allCardsMatch: false)
}

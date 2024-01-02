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
    @State var isProgressView = true
    @State private var isDelayOut = false
    
    var body: some View {
        if !isProgressView{
            VStack(alignment: .center){
                NavigationStack{
                    ForEach(store.themes){ theme in
                        NavigationLink(destination: {
                            ZStack{
                                RadialGradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6110873818, blue: 0.5621060729, alpha: 1))],
                                               center: .center,
                                               startRadius: 70, endRadius: 500)
                                .ignoresSafeArea()
                                Text(theme.name)
                                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                                    .offset(y: -300)
                                EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
                            }
                        }){
                            ThemeButton(theme: theme)
                        }
                    }
                    .navigationTitle("Themes")
                    
                }
            }
        } else {
            ProgressView()
                .scaleEffect(3)
                .tint(.orange)
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

struct ThemeButton: View {
    var theme: EmojiMemoryTheme
    
    var body: some View{
        ZStack(alignment: .center){
            ZStack{
                RoundedRectangle(cornerRadius: 50, style: .circular)
                    .fill(Color(.orange))
                    .frame(width: 260, height: 50)
                RoundedRectangle(cornerRadius: 50, style: .circular)
                    .fill(Color(.white))
                    .frame(width: 250, height: 40)
            }
            HStack{
                Text(theme.emojis.first ?? "")
                    .font(.system(size: 30))
                    .padding(.vertical)
                Text(theme.name)
                    .font((.system(size: 25, weight: .semibold, design: .rounded)))
                    .foregroundColor(.orange)
                
                
            }
            .padding(.horizontal)
            
        }
        
    }
}


#Preview {
    ThemeList(store: EmojiMemoryThemeStore(named: "preview"), viewModel: EmojiMemoryGame())
}

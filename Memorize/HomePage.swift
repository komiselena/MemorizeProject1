//
//  HomeView.swift
//  Memorize
//
//  Created by Mac on 29.12.2023.
//

import SwiftUI

struct HomePage: View {
    @State var showThemeList = false
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6110873818, blue: 0.5621060729, alpha: 1))],
                           center: .top,
                           startRadius: 70, endRadius: 500)
            .ignoresSafeArea()
            VStack{
                Text("Hey!")
                Text("Wanna play?")
            }
            .font(.system(size: 50, weight: .semibold, design: .rounded))
            .offset(y: -200)
            .foregroundColor(.white)
            .glowBorder(color: .black, lineWidth: 5)
            
            VStack{
                if showThemeList{
                    withAnimation{
                        ThemeList(store: EmojiMemoryThemeStore(named: "store"), viewModel: EmojiMemoryGame())
                    }
                }else{
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 50.0)
                                .frame(width: 210, height: 80)
                                .foregroundColor(.orange)
                            
                            Button("Start"){
                                showThemeList.toggle()
                            }
                            .frame(width: 200, height: 70)
                            .foregroundColor(.orange)
                            .font(.title)
                            .background(Color(.white))
                            .shadow(radius: 20)
                            .cornerRadius(50)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 50.0)
                                .frame(width: 210, height: 80)
                                .foregroundColor(.orange)
                            Button("Exit"){
                                exit(0)
                            }
                            .frame(width: 200, height: 70)
                            .foregroundColor(.orange)
                            .font(.title)
                            .background(Color(.white))
                            .shadow(radius: 20)
                            .cornerRadius(50)
                        }
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    HomePage()
}

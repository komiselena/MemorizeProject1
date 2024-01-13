//
//  ThemeButton.swift
//  Memorize
//
//  Created by Mac on 06.01.2024.
//

import SwiftUI

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


//
//  FlyingNumber.swift
//  Memorize
//

//  Created by Mac on 29.11.2023.

//  Created by Mac on 30.11.2023.

//  Created by Mac on 29.11.2023.

//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    

    var body: some View {
        if number != 0{
            Text(number, format: .number)

    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number != 0{
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: .blue, radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0: 1)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)){
                        offset = number < 0 ? 200: -200
                    }
                }
                .onDisappear{
                    offset = 0
                }

    var body: some View {
        if number != 0{
            Text(number, format: .number)

        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}

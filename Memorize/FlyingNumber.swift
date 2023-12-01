//
//  FlyingNumber.swift
//  Memorize
//
<<<<<<< HEAD
//  Created by Mac on 29.11.2023.
=======
<<<<<<< HEAD
//  Created by Mac on 30.11.2023.
=======
//  Created by Mac on 29.11.2023.
>>>>>>> main
>>>>>>> first
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
<<<<<<< HEAD
    var body: some View {
        if number != 0{
            Text(number, format: .number)
=======
<<<<<<< HEAD
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
=======
    var body: some View {
        if number != 0{
            Text(number, format: .number)
>>>>>>> main
>>>>>>> first
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}

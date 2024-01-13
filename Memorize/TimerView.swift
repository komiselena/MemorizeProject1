//
//  TimerView.swift
//  Memorize
//
//  Created by Mac on 13.01.2024.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager =  TimerManager()
    
    var body: some View {
        Text(String(timerManager.secondsElapsed))
            .font(.system(size: 30))
            .foregroundColor(.black)
    }
}

#Preview {
    TimerView()
}

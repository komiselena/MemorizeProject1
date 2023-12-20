//
//  TimerView.swift
//  Memorize
//
//  Created by Mac on 20.12.2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var stopwatchManager = StopwatchManager()
    @ScaledMetric var secondsSize: CGFloat = 30.0
    
    var body: some View {
        Text(String(stopwatchManager.secondElapsed))
            .font(.system(size: secondsSize))
            .foregroundColor(.black)
    }
}
#Preview {
    TimerView()
}

//
//  StopwatchManager.swift
//  Memorize
//
//  Created by Mac on 20.12.2023.
//

import Foundation
import SwiftUI

class StopwatchManager: ObservableObject{
    @State var secondElapsed = 0.0
    @State private var timer = Timer()
    
    enum stopwatchMode{
        case running
        case stopped
    }
    
    @Published var mode: stopwatchMode = .stopped
    
    func start(){
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
            self.secondElapsed += 1 
        }
    }
    func stop(){
        timer.invalidate()
        secondElapsed = 0.0
        mode = .stopped
    }
    
    
}

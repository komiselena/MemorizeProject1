//
//  TimerManager.swift
//  Memorize
//
//  Created by Mac on 13.01.2024.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject{
    @Published var secondsElapsed: TimeInterval = 0
    var timer = Timer()
    
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.secondsElapsed += 1 
        }
    }
    
}

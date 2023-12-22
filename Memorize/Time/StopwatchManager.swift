//
//  StopwatchManager.swift
//  Memorize
//
//  Created by Mac on 20.12.2023.
//

import Foundation
import SwiftUI

class StopwatchManager: ObservableObject{
    @Published var secondElapsed: TimeInterval = 0
    var timer = Timer()
    
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.secondElapsed += 0.5
            print("\(self.secondElapsed)")
            
        }
    }
    func stop(){
        timer.invalidate()
        secondElapsed = 0
    }
    
}

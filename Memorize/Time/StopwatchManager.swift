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
    @Published var finishSeconds: TimeInterval = 0
    
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.secondElapsed += 0.5
            print("\(self.secondElapsed)")
            
        }
    }
    func stop(){
        finishSeconds = secondElapsed
        timer.invalidate()
        secondElapsed = 0
    }
    
}

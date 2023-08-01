//
//  Debouncer.swift
//  ImageFilter
//
//  Created by Roman Borzdukha on 31.07.2023.
//

import Foundation

class Debouncer {
    
    private(set) var isAllowed: Bool = true
    
    private let timeInterval: CGFloat
    
    private var timer: Timer = Timer()
    
    init(withTimeInterval timeInterval: CGFloat) {
        self.timeInterval = timeInterval
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] _ in
            self?.isAllowed = true
        })
    }
    
    deinit { timer.invalidate() }
    
    func debounce() {
        isAllowed = false
    }
}

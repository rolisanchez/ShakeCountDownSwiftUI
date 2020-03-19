//
//  ShakableViewRepresentable.swift
//  ShakerCountdown
//
//  Created by Victor Rolando Sanchez Jara on 3/19/20.
//  Copyright © 2020 Victor Rolando Sanchez Jara. All rights reserved.
//

import SwiftUI
struct ShakableViewRepresentable: UIViewControllerRepresentable {
    
    @Binding var timeToGo: TimeInterval
    
    func makeUIViewController(context: Context) -> ShakableViewController {
        ShakableViewController(timeToGo: timeToGo) { updatedTimeToGo in
            self.timeToGo = updatedTimeToGo
        }
    }
   
    func updateUIViewController(_ uiViewController: ShakableViewController, context: Context) {
    }
    
}


class ShakableViewController: UIViewController {
    var shakeStartTime: TimeInterval = 0.0
    var timeToGo : TimeInterval!
    var updateTime: ((TimeInterval) -> Void)!
    
    init(timeToGo: TimeInterval, updateTime: @escaping (TimeInterval) -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.timeToGo = timeToGo
        self.updateTime = updateTime
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("motionBegan")
        guard motion == .motionShake else { return }
        print("Shake began")
        shakeStartTime = Date.timeIntervalSinceReferenceDate
        UIDevice.vibrate()
    }
    
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("motionCancelled")
        UIDevice.vibrate()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("motionEnded")
        guard motion == .motionShake else { return }
        let shakeEndTime = Date.timeIntervalSinceReferenceDate
        let difference = shakeEndTime - shakeStartTime
        print("Shake ended \(difference)")
        timeToGo -= difference
        print("timeToGo \(timeToGo)")
        updateTime(timeToGo)
        UIDevice.vibrate()
    }
    
}

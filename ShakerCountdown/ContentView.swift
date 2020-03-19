//
//  ContentView.swift
//  ShakerCountdown
//
//  Created by Victor Rolando Sanchez Jara on 3/19/20.
//  Copyright © 2020 Victor Rolando Sanchez Jara. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var timeToGo: TimeInterval = 10.0
    var body: some View {
        ZStack {
            if timeToGo > 0 {
                ShakableViewRepresentable(timeToGo: $timeToGo)
            }
            VStack {
                Text("Shake until countdown reaches 0!")
                Divider()
                Text("\(timeToGo.format(using: [.second])!)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension TimeInterval {
    func format(using units: NSCalendar.Unit) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: self)
    }
}

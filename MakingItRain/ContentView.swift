//
//  ContentView.swift
//  MakingItRain
//
//  Created by Shah Md Imran Hossain on 17/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ParticleView(createSystem()) {
            Image(.circle)
                .blendMode(.plusLighter)
                .tag("unitView")
            Text("🦄")
                .font(.system(size: 150))
                .tag("unicorn")
        }
    }
}

extension ContentView {
    func createSystem() -> ParticleSystem {
        let system = ParticleSystem()
        system.tags = ["unitView"]
        system.position = [0.5, 0]
        system.angle = .degrees(180)
        system.angleVary = .degrees(20)
        system.shape = .box(width: 1, height: 0)
        system.color = .green
        system.speed = 0.2
        system.speedVary = 0.4
        system.acceleration = [0, 1]
        system.size = 0.5
        system.sizeVary = 1
        system.sizeAtDeath = 0
        
        return system
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

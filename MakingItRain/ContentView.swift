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
                .tag("snow")
            Text("🦄")
                .font(.system(size: 150))
                .tag("unicorn")
            Text("Soudha")
                .font(.system(size: 150))
                .tag("soudha")
            Text("Imran")
                .font(.system(size: 150))
                .tag("imran")
        }
    }
}

extension ContentView {
    func createSystem() -> ParticleSystem {
        let system = ParticleSystem()
        system.tags = ["snow"]
        system.position = [0.5, 0]
        system.angle = .degrees(190)
        system.angleVary = .degrees(20)
        system.shape = .box(width: 1, height: 0)
        system.color = .green
        system.speed = 0.2
        system.speedVary = 0.4
        system.acceleration = [0, 2]
        system.size = 0.09
        system.sizeVary = 0.05
        system.sizeAtDeath = 1
        
        return system
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

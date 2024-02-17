//
//  ParticleSystem.swift
//  MakingItRain
//
//  Created by Shah Md Imran Hossain on 18/2/24.
//

import SwiftUI

struct Particle {
    var tag: String
    var position: SIMD2<Double>
    var speed: SIMD2<Double>
    var birthTime: Double
    var lifeSpan: Double
    var startSize: Double
    var currentSize = 0.0
    var currentAngle = SIMD3<Double>()
    var spinSpeed: SIMD3<Double>
}

enum ParticleSystemShape {
    case point
    case box(width: Double, height: Double)
}

class ParticleSystem {
    public var tags = [String]()
    var color = Color.white
    
    var particles = [Particle]()
    var position = SIMD2(0.5, 0.5)
    
    var lifespan = 1.0
    var speed = 1.0
    var size = 1.0
    
    var lifeVary = 0.0
    var speedVary = 0.0
    var sizeVary = 0.0
    
    var sizeAtDeath = 1.0
    
    var acceleration = SIMD2<Double>()
    
    var angle: Angle = Angle.zero
    var angleVary: Angle = Angle.zero
    
    var spinSpeed = SIMD3<Double>()
    var spindSpeedVary = SIMD3<Double>()
    
    var lastUpdate = Date.now.timeIntervalSince1970
    
    var shape = ParticleSystemShape.point
    
    func createParticle() {
        let lauchAngle = angle.radians + angleVary.radians.spread() - .pi / 2
        
        let launchSpeed = speed + speedVary.spread()
        let launchLifespan = lifespan + lifeVary.spread()
        let launchSize = size + sizeVary.spread()
        
        
        let xSpeed = cos(lauchAngle) * launchSpeed
        let ySpeed = sin(lauchAngle) * launchSpeed
        
        let spin = SIMD3(
            spinSpeed.x + spindSpeedVary.x.spread(),
            spinSpeed.y + spindSpeedVary.y.spread(),
            spinSpeed.z + spindSpeedVary.z.spread()
        )
        
        let newPosition: SIMD2<Double>
        
        switch shape {
        case .point:
            newPosition = position
        case .box(let width, let height):
            newPosition = [
                position.x + width.spread(),
                position.y + height.spread()
            ]
        }
        
        let newParticle = Particle(
            tag: tags.randomElement() ?? "",
            position: newPosition,
            speed: [xSpeed, ySpeed],
            birthTime: lastUpdate,
            lifeSpan: launchLifespan,
            startSize: launchSize,
            spinSpeed: spin
        )
        
        particles.append(newParticle)
    }
    
    func update(date: Date) {
        createParticle()
        
        let currentTimeInterval = date.timeIntervalSince1970
        let delta = currentTimeInterval - lastUpdate
        lastUpdate = currentTimeInterval
        
        particles = particles.compactMap{
            var copy = $0
            
            let age = currentTimeInterval - copy.birthTime
            let progress = age / copy.lifeSpan
            let targetSize = copy.startSize * sizeAtDeath
            let gap = targetSize - copy.startSize
            
            copy.position += copy.speed * delta
            copy.speed += acceleration * delta
            copy.currentSize = copy.startSize + (gap * progress)
            
            copy.currentAngle += copy.spinSpeed * delta
            
            if age >= copy.lifeSpan * 2 {
                return nil
            } else {
                return copy
            }
        }
    }
}


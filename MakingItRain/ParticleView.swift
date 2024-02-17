//
//  ParticleView.swift
//  MakingItRain
//
//  Created by Shah Md Imran Hossain on 18/2/24.
//

import SwiftUI

struct ParticleView<Symbols>: View where Symbols: View {
    @ViewBuilder var symbols: Symbols
    @State var system: ParticleSystem
    
    init(_ system: ParticleSystem, @ViewBuilder symbols: () -> Symbols) {
        _system = State(initialValue: system)
        self.symbols = symbols()
    }
    
    var body: some View {
        TimelineView(.animation) { timeLine in
            Canvas { context, size in
                system.update(date: timeLine.date)
                draw(system, into: context, at: size)
            } symbols: {
                symbols
            }
        }
    }
}

extension ParticleView {
    func draw(_ system: ParticleSystem, into context: GraphicsContext, at size: CGSize) {
        for particle in system.particles {
            let x = particle.position.x * size.width
            let y = particle.position.y * size.height
            
            var ctx = context
            ctx.translateBy(x: x, y: y)
            
            ctx.scaleBy(x: particle.currentSize, y: particle.currentSize)
            
//            ctx.addFilter(.colorMultiply(system.color))
            
            var transform = CATransform3DIdentity
            
            transform = CATransform3DRotate(transform, particle.currentAngle.x, 1, 0, 0)
            transform = CATransform3DRotate(transform, particle.currentAngle.y, 0, 1, 0)
            transform = CATransform3DRotate(transform, particle.currentAngle.z, 0, 0, 1)
            
            ctx.addFilter(
                .projectionTransform(
                    ProjectionTransform(transform)
                )
            )
            
            if let unitView = ctx.resolveSymbol(id: particle.tag) {
                ctx.draw(unitView, at: .zero)
            }
            
            // all modifier need to add before draw, not after
        }
    }
}


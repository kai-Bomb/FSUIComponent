import SwiftUI

public struct FSShapesProgressView: View {
    @State private var scale: CGFloat = 0.1
    
    public var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let centerX = size.width / 2
            let centerY = size.height / 2
            let radius: CGFloat = size.width * 0.5
            
            ForEach(0..<3) { index in
                let angle = Angle(degrees: Double(index) * 120 - 90)
                let x = centerX + cos(angle.radians) * radius
                let y = centerY + sin(angle.radians) * radius
                
                Group {
                    switch index {
                    case 0:
                        Triangle().stroke(Color.red, lineWidth: 3)
                    case 1:
                        Rectangle().stroke(Color.blue, lineWidth: 3)
                    default:
                        Circle().stroke(Color.green, lineWidth: 3)
                    }
                }
                .frame(width: 20, height: 20)
                .opacity(Double(scale))
                .scaleEffect(scale)
                .animation(
                    Animation.easeInOut(duration: 0.6)
                        .repeatForever()
                        .delay(Double(index) * 1 / 3),
                    value: scale
                )
                .position(x: x, y: y)
            }
        }
        .frame(width: 64, height: 64)
        .onAppear {
            withAnimation {
                scale = 1.25
            }
        }
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        path.move(to: top)
        path.addLine(to: bottomLeft)
        path.addLine(to: bottomRight)
        path.addLine(to: top)
        return path
    }
}


#Preview {
    FSShapesProgressView()
}

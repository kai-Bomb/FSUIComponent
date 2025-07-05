import SwiftUI

struct FSCircleProgressView: View {
    @State var scale: CGFloat = 0.1
    var body: some View {
        GeometryReader { geometry in
            ForEach(Dot.allCases, id: \.self) { dot in
                Circle()
                    .stroke(lineWidth: scale)
                    .frame(width: 10, height: 10)
                    .opacity(scale)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(dot.delay),
                        value: scale
                    )
                    .offset(
                        x: geometry.size.width * dot.offset.width,
                        y: geometry.size.height * dot.offset.height
                    )
            }
        }
        .frame(width: 64, height: 64)
        .onAppear {
            withAnimation {
                scale = 1.2
            }
        }
    }
}

private extension FSCircleProgressView {
    
    enum Dot: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        
        var delay: Double {
            1 / Double(Self.allCases.count) * Double(self.rawValue)
        }
        
        var offset: CGSize {
            switch self {
            case .one:
                return .init(width: 0.90, height: 0.50)
            case .two:
                return .init(width: 0.79, height: 0.79)
            case .three:
                return .init(width: 0.50, height: 0.92)
            case .four:
                return .init(width: 0.21, height: 0.79)
            case .five:
                return .init(width: 0.10, height: 0.50)
            case .six:
                return .init(width: 0.21, height: 0.21)
            case .seven:
                return .init(width: 0.50, height: 0.08)
            case .eight:
                return .init(width: 0.79, height: 0.21)
            }
        }
    }
}

#Preview {
    FSCircleProgressView()
}

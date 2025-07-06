import SwiftUI

public enum AlertType {
    case success
    case warning
    case infomaion
    case error
    
    var baseColor: Color {
        switch self {
        case .success:
            return .green
        case .warning:
            return .yellow
        case .infomaion:
            return .mint
        case .error:
            return .red
        }
    }
    
    var icon: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .warning:
            return "exclamationmark.circle.fill"
        case .infomaion:
            return "info.circle.fill"
        case .error:
            return "xmark.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .success:
            return String(localized: .success)
        case .warning:
            return String(localized: .warning)
        case .infomaion:
            return String(localized: .information)
        case .error:
            return String(localized: .error)
        }
    }
}

#Preview {
    FSSamplePreview()
}


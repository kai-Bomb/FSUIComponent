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

private struct SampleView: View {
    @State private var showAlert1: Bool = false
    @State private var showAlert2: Bool = false
    @State private var showAlert3: Bool = false
    @State private var showAlert4: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            Button("Show Success Alert") {
                showAlert1 = true
            }
            Button("Show Warning Alert") {
                showAlert2 = true
            }
            Button("Show Error Alert") {
                showAlert3 = true
            }
            Button("Show Infomation Alert") {
                showAlert4 = true
            }
        }
        .fsAlert(
            isPresented: $showAlert1,
            type: .success
        )
        .fsAlert(
            isPresented: $showAlert2,
            type: .warning,
            message: "This is a warning message"
        )
        .fsAlert(
            isPresented: $showAlert3,
            type: .error,
            message: "This is an error message"
        )
        .fsAlert(
            isPresented: $showAlert4,
            type: .infomaion,
            message: "This is an info message"
        )
    }
}

#Preview {
    SampleView()
}

import SwiftUI

public extension View {
    func fsAlert(
        isPresented: Binding<Bool>,
        type: AlertType,
        message: String? = nil
    ) -> some View {
        self
            .modifier(
                FSAlertDesignModifier(
                    isPresented: isPresented,
                    type: type,
                    message: message
                )
            )
    }
}

private struct FSAlertDesignModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    let type: AlertType
    let message: String?
    
    init(
        isPresented: Binding<Bool>,
        type: AlertType,
        message: String? = nil
    ) {
        self._isPresented = isPresented
        self.type = type
        self.message = message
    }
    
    func body(content: Content) -> some View {
        content
            .fsAlertSystem(
                isPresented: $isPresented,
                content: {
                    VStack(spacing: 8) {
                        Image(systemName: type.icon)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(type.baseColor)
                            .background(
                                Circle()
                                    .fill(.background)
                                    .frame(width: 72, height: 72)
                            )
                        Text(type.title)
                            .font(.title)
                            .bold()
                        if let message {
                            Text(message)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        Button(action: {
                            isPresented = false
                        }, label: {
                            Text("OK")
                                .foregroundStyle(Color.white)
                                .frame(height: 40)
                                .frame(width: 250)
                                .bold()
                                .background(
                                    type.baseColor.clipShape(RoundedRectangle(cornerRadius: 8))
                                )
                                .padding()
                        })
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.background)
                            .padding(.top, 32)
                    )
                    .transition(.blurReplace.combined(
                        with: .opacity)
                    )
                },
                background: {
                    Rectangle()
                        .fill(.primary.opacity(0.35))
                }
            )
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

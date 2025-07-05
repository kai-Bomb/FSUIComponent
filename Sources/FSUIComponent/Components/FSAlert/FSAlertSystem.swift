import SwiftUI

 extension View {
    @ViewBuilder func fsAlertSystem<Content: View, Background: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: @escaping () -> Background
    ) -> some View {
        self
            .modifier(
                FSAlertSystemModifier(
                    isPresented: isPresented,
                    alertContent: content,
                    background: background
                )
            )
    }
}

private struct FSAlertSystemModifier<AlertContent: View, Background: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder var alertContent: AlertContent
    @ViewBuilder var background: Background
    @State private var showFullScreenCover: Bool = false
    @State private var animatedValue: Bool = false
    @State private var allowsInteraction: Bool = false
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $showFullScreenCover) {
                ZStack {
                    if animatedValue {
                        alertContent
                    }
                }
                .presentationBackground {
                    background
                        .allowsHitTesting(allowsInteraction)
                        .opacity(animatedValue ? 1 : 0)
                }
                .task {
                    try? await Task.sleep(for: .seconds(0.05))
                    withAnimation(.easeInOut(duration: 0.2)) {
                        animatedValue = true
                    }
                    
                    try? await Task.sleep(for: .seconds(0.3))
                    allowsInteraction = true
                }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                var transaction = Transaction()
                transaction.disablesAnimations = true
                transaction.animation = nil
                
                if newValue {
                    withTransaction(transaction) {
                        showFullScreenCover = true
                    }
                } else {
                    allowsInteraction = false
                    withAnimation(.easeInOut(duration: 0.3), completionCriteria: .removed) {
                        animatedValue = false
                    } completion: {
                        withTransaction(transaction) {
                            showFullScreenCover = false
                        }
                    }
                }
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

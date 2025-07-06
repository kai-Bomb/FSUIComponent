import SwiftUI

public extension View {
    func fsAlert(
        isPresented: Binding<Bool>,
        type: AlertType,
        message: String? = nil,
        confirmButtonTitle: String? = nil,
        confirmAction: (() -> Void)? = nil,
        discardButtonTitle: String? = nil,
        discardAction: (() -> Void)? = nil
    ) -> some View {
        self
            .modifier(
                FSAlertDesignModifier(
                    isPresented: isPresented,
                    type: type,
                    message: message,
                    confirmButtonTitle: confirmButtonTitle,
                    confirmAction: confirmAction,
                    discardButtonTitle: discardButtonTitle,
                    discardAction: discardAction
                )
            )
    }
}

private struct FSAlertDesignModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    let type: AlertType
    let message: String?
    let confirmButtonTitle: String
    let confirmAction: (() -> Void)?
    let discardButtonTitle: String
    let discardAction: (() -> Void)?

    init(
        isPresented: Binding<Bool>,
        type: AlertType,
        message: String? = nil,
        confirmButtonTitle: String?,
        confirmAction: (() -> Void)?,
        discardButtonTitle: String?,
        discardAction: (() -> Void)?
    ) {
        self._isPresented = isPresented
        self.type = type
        self.message = message
        self.confirmButtonTitle = confirmButtonTitle ?? String(localized: .ok)
        self.confirmAction = confirmAction
        self.discardButtonTitle = discardButtonTitle ?? String(localized: .cancel)
        self.discardAction = discardAction
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
                                .frame(maxWidth: 250)
                        }
                        VStack(spacing: 8) {
                            Button(action: {
                                confirmAction?()
                                isPresented = false
                            }, label: {
                                Text(confirmButtonTitle)
                                    .foregroundStyle(Color.white)
                                    .frame(height: 40)
                                    .frame(width: 250)
                                    .bold()
                                    .background(
                                        type.baseColor.clipShape(RoundedRectangle(cornerRadius: 8))
                                    )
                            })

                            if let discardAction {
                                Button {
                                    discardAction()
                                    isPresented = false
                                } label: {
                                    Text(discardButtonTitle)
                                        .foregroundStyle(type.baseColor)
                                        .frame(height: 40)
                                        .frame(width: 250)
                                        .bold()
                                        .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(type.baseColor, lineWidth: 2)
                                            )
                                }
                            }
                        }
                        .padding()
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

#Preview {
    FSSamplePreview()
}


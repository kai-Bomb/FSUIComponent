//
//  SwiftUIView.swift
//  FSUIComponent
//
//  Created by katsumasa.watanabe on 2025/07/06.
//

import SwiftUI

struct FSSamplePreview: View {
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
            type: .success,
            discardButtonTitle: "Cancel",
            discardAction: {}
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
    FSSamplePreview()
}

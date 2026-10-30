//
//  ErrorMessageComponentView.swift
//  Galop'Up
//
//  Created by Emma on 01/10/2026.
//

import SwiftUI
 
struct ErrorMessageComponentView: View {
    @Environment(ErrorViewModel.self) var errorVM
 
    var body: some View {
        if let error = errorVM.currentError {
            VStack {
                Text(error.localizedMessage)
                    .font(.custom("Nunito", size: 14))
                    .foregroundStyle(.customWhite)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customRed)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .onTapGesture { errorVM.dismiss() }
 
                Spacer()
            }
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.spring, value: errorVM.currentError)
        }
    }
}

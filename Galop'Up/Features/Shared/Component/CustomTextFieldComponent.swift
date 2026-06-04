//
//  CustomTextFieldComponent.swift
//  Galop'Up
//
//  Created by Emma on 27/05/2026.
//

import SwiftUI

struct CustomTextFieldComponent: View {
    @Binding var text: String
    var placehorder: String
    var isSecured: Bool = false
    @FocusState.Binding var isFocused: Bool
    var body: some View {
        
        Group{
            if isSecured{
                SecureField(placehorder, text: $text)
            }
            
            else{
                TextField(placehorder, text: $text)
            }
        }
        .focused($isFocused)
        .frame(height: 17)
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .font(.custom("Lato-Regular", size: 12))
        .background(.white)
        .onSubmit {
            isFocused.toggle()
        }
        .foregroundStyle(.customBrown)
        .autocorrectionDisabled()
        .autocapitalization(.none)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color(.darkBrown), lineWidth: 1)
        )
        
           
    }
}

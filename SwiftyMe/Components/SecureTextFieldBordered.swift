//
//  SecureTextFieldBordered.swift
//  SwiftyMe
//
//  Created by MacBook on 26/12/2022.
//

import SwiftUI

class SecureTextFieldViewModel : ObservableObject {
    @Published var borderColorActive:Color = .gray
    @Published var focusedField: Field?
}

struct SecureTextFieldBordered: View {
    var placeholder:String = ""
    var keyboardType:UIKeyboardType = .default
    var foregroundColor:Color = .white
    var borderColor:Color = .gray
    var height:CGFloat = 45
    var cornerRadius:CGFloat = 5
    @State var fieldState: String = ""
    @EnvironmentObject var borderColorViewModel:SecureTextFieldViewModel
    var fieldType:Field = Field.login_password
    
    let action: (String?) -> Void
    
    var body: some View {
        ZStack{
            SecureField(placeholder, text: Binding<String>(
                get: { self.fieldState },
                set: {
                    self.fieldState = $0
                    self.callMe(with: $0)
                }),
                onCommit: {
                borderColorViewModel.focusedField = nil
            })
            
            .onTapGesture {
                borderColorViewModel.focusedField = fieldType
            }
            .keyboardType(keyboardType)
            .foregroundColor(foregroundColor)
            .padding()
            .frame(height:height)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(activeBorderColor, lineWidth: 1)
            )
            
        }
    }
    
    var activeBorderColor:Color{
        print("focusedField sec=",borderColorViewModel.focusedField)
        if borderColorViewModel.focusedField == fieldType{
            return .black
        }
        return .gray
    }
    func callMe(with tx: String) {
        action(tx)
    }
}

struct SecureTextFieldBordered_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextFieldBordered(placeholder: "Pssword", keyboardType: .emailAddress, foregroundColor: Color.black, borderColor:Color.gray){ _ in
            
        }.environmentObject(SecureTextFieldViewModel())
    }
}

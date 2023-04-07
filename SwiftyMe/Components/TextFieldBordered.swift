//
//  TextFieldBordered.swift
//  SwiftyMe
//
//  Created by MacBook on 26/12/2022.
//

import SwiftUI

enum Field {
    case login_username
    case login_password
    case signup_fName
    case signup_lName
    case signup_email
    case signup_password
    case signup_confirmPassword
    
    case search_bus_from_location
    case search_bus_to_location
    
    case contest_form_name
    case contest_form_phone
    case contest_form_caption
    case contest_form_location
}

class TextFieldViewModel : ObservableObject {
    @Published var borderColorActive:Color = .gray
    @Published var focusedField: Field?
}

struct TextFieldBordered: View {
    
    var placeholder:String = ""
    var keyboardType:UIKeyboardType = .default
    var foregroundColor:Color = .white
    var borderColor:Color = .gray
    var height:CGFloat = 45
    var cornerRadius:CGFloat = 5
    @State var fieldState: String = ""
    @EnvironmentObject var borderColorViewModel:TextFieldViewModel
    @EnvironmentObject var secureTextFieldViewModel:SecureTextFieldViewModel
    var fieldType: Field
    
    let action: (String?) -> Void
    
    var body: some View {
        ZStack{
            TextField(placeholder, text: Binding<String>(
                get: { self.fieldState },
                set: {
                    self.fieldState = $0
                    self.callMe(with: $0)
                }),
                onEditingChanged: { changed in
                if changed {
                    borderColorViewModel.focusedField = fieldType
                    secureTextFieldViewModel.focusedField = nil
                }
                else {
                    borderColorViewModel.focusedField = nil
                }
            })
            //.contentShape(Rectangle())
            .keyboardType(keyboardType)
            .foregroundColor(foregroundColor)
            .padding()
            .frame(height:height)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke( activeBorderColor, lineWidth: 1)
            )
            .onTapGesture { ///this tap is added to avoid keyboard dismiss when tapped, currently when parent view is tapped for dismiss keyboard, when not adding this keyboard jumps
                print("field tapped")
            }
            
        }
    }
    
    var activeBorderColor:Color{
        print("focusedField=",borderColorViewModel.focusedField)
        if borderColorViewModel.focusedField == fieldType{
            return .black
        }
        return .gray
    }
    
    func callMe(with tx: String) {
        action(tx)
    }
}

struct TextFieldBordered_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBordered(placeholder: "Enter email address", keyboardType: .emailAddress, foregroundColor: Color.black, borderColor:Color.gray, fieldType: Field.login_username){ _ in
            
        }.environmentObject(TextFieldViewModel())
    }
}

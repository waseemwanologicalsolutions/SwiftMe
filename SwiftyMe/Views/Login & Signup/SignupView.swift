//
//  SignupView.swift
//  SwiftyMe
//
//  Created by MacBook on 26/12/2022.
//

import SwiftUI
import AlertKit


struct SignupView: View {
    
    @StateObject var alertManager = AlertManager()
    @State var isToMoveBack:Bool = false
    @State var fName:String = ""
    @State var lName:String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var confirmPassword:String = ""
    
    @EnvironmentObject var textFieldViewModel:TextFieldViewModel
    @EnvironmentObject var secureTextFieldViewModel:SecureTextFieldViewModel
    
    @Environment(\.presentationMode) var presentation
    var showBackButton:Bool = true
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack() {
                    TopNavigationHeader(actionLeft: backPressed, actionRight: nextPressed,rightTitle: "Next", showBackButton: showBackButton)
                    ScrollView {
                        VStack(spacing: 20){
                            
                            CommonScreenTitleView(title: "Create an account!")
                                .padding([.top], 20)
                                .padding([.bottom], 5)
                            
                            TextFieldBordered(placeholder:"First name",keyboardType: .default, foregroundColor: .black, fieldType: Field.signup_fName){ val in
                                fName = val ?? ""
                            }.padding(1)
                            TextFieldBordered(placeholder:"Last name",keyboardType: .default, foregroundColor: .black, fieldType: Field.signup_lName){ val in
                                lName = val ?? ""
                            }.padding(1)
                            TextFieldBordered(placeholder:"Email address",keyboardType: .emailAddress, foregroundColor: .black, fieldType: Field.signup_email){ val in
                                email = val ?? ""
                            }.padding(1)
                            
                            SecureTextFieldBordered(placeholder:"Password",foregroundColor: .black, fieldType: Field.signup_password){ val in
                                password = val ?? ""
                            }.padding(1)
                            
                            SecureTextFieldBordered(placeholder:"Confirm password",foregroundColor: .black, fieldType: Field.signup_confirmPassword){ val in
                                confirmPassword = val ?? ""
                            }.padding(1)
                                .padding(.bottom, 20)
                            
                            Text("By signing up, I hereby accept all terms and conditions.")
                                .font(.sfProRounded(12)).opacity(0.75)
                            
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 5){
                            
                            Text("Already have an acccount?")
                                .font(.sfProRounded(14))
                            
                            RectButton(title: "Login", foreground:Color.blue, fontSize: 14, action:loginPressed)
                                .frame(maxWidth:40)
                            
                        }
                        CapsuleButton(title: "SUBMIT",foreground: Color.white, background: Color.blue, height: 60, action:nextPressed)
                    }
                    
                }.padding().uses(alertManager)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Spacer()
                        }
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                dismisssKeyBoard()
                            }
                        }
                        
                    }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .onTapGesture {
                    self.dismisssKeyBoard()
                }
            NavigationLink(destination: LoginView(), isActive: $isToMoveBack) {
                
            }
        }.navigationBarHidden(true)
            .onDisappear(){
                dismisssKeyBoard()
            }
        
    }
    
    func backPressed(){
        print("backPressed")
        dismisssKeyBoard()
        isToMoveBack = true
        self.presentation.wrappedValue.dismiss()
    }
    func loginPressed(){
        print("loginPressed")
        dismisssKeyBoard()
        
    }
    func nextPressed(){
        print("nextPressed")
        dismisssKeyBoard()
    }
    func dismisssKeyBoard(){
        hideKeyboard()
        textFieldViewModel.focusedField = nil
        secureTextFieldViewModel.focusedField = nil
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(TextFieldViewModel())
            .environmentObject(SecureTextFieldViewModel())
    }
}

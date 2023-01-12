//
//  LoginView.swift
//  SwiftyMe
//
//  Created by MacBook on 21/12/2022.
//

import SwiftUI
import AlertKit

struct LoginView: View {
    
    @StateObject var alertManager = AlertManager()
    @State private var topExpanded: Bool = true
    @State var selection:String = "Option 1"
    @State var value:String = ""
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isToMoveToSignup:Bool = false
    
    @EnvironmentObject var textFieldViewModel:TextFieldViewModel
    @EnvironmentObject var secureTextFieldViewModel:SecureTextFieldViewModel
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var selectedTabIndex:SelectedTabViewModel
    
    var showBackButton:Bool = false
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                VStack {
                    
                    TopNavigationHeader(actionLeft: backPressed, actionRight: signupPressed, rightTitle: "Signup", showBackButton: showBackButton)
                        
                    
                    CommonScreenTitleView(title: "Login to your account!")
                        .padding([.top, .bottom], 20)
                    
                    TextFieldBordered(placeholder:"Email address",keyboardType: .emailAddress, foregroundColor: .black, fieldType: Field.login_username){ val in
                        username = val ?? ""
                    }
                    .padding(.bottom, 15)
                    
                    SecureTextFieldBordered(placeholder:"Password",foregroundColor: .black, fieldType: Field.login_password){ val in
                        password = val ?? ""
                    }
                    .padding(.bottom, 20)
                    
                    CapsuleButton(title: "LOGIN",foreground: Color.white, background: Color.blue, height: 60, action:loginPressed)
                    
                    HStack(spacing: 5){
                        Text("Forget password?")
                            .font(.sfProRounded(14))
                        RectButton(title: "Reset here", foreground:Color.blue, fontSize: 14, action:resetPressed)
                            .frame(width:75)
                    }
                    
                    Spacer()
                    NavigationLink("", destination: SignupView(), isActive: $isToMoveToSignup)
                        
                }
                .padding().uses(alertManager)
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

        }.navigationBarHidden(true)
        /*
            .onTapGesture {
                self.dismisssKeyBoard()
            }*/
    
    }
    
    // MARK: - Acttions -
    
    func backPressed(){
        print("backPressed")
        dismisssKeyBoard()
        self.presentation.wrappedValue.dismiss()
    }
    func signupPressed(){
        print("signupPressed")
        dismisssKeyBoard()
        isToMoveToSignup = true
    }
    func resetPressed(){
        print("resetPressed")
        dismisssKeyBoard()
        selectedTabIndex.selectedView = 1
    }
    func loginPressed(){
        
        print("loginPressed")
        dismisssKeyBoard()
        
        if username.isEmpty{

            alertManager.show(primarySecondary: .error(title: "Hang On!", message: "Please add your email address", primaryButton: Alert.Button.default(Text("OK"), action: {
                print("primaryButton")
                                }), secondaryButton: .cancel()))
        }else{
            //alertManager.show(dismiss: .info(message: "Successfully fetched data", dismissButton: Alert.Button.default(Text("OK"))))
            isToMoveToSignup = true
        }
    }
    func dismisssKeyBoard(){
        hideKeyboard()
        textFieldViewModel.focusedField = nil
        secureTextFieldViewModel.focusedField = nil
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(TextFieldViewModel())
            .environmentObject(SecureTextFieldViewModel())
        
    }
}




struct ScreenTitleView: View {
    var body: some View {
        return Text("Login to your account!")
            .font(.title)
            .fontWeight(.medium)
            .padding([.bottom, .top], 20)
    }
}


//
//  SubmitEntrySceneView.swift
//  SwiftyMe
//
//  Created by MacBook on 03/04/2023.
//

import SwiftUI

struct SubmitEntrySceneView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var vm = SubmitEntrySceneViewModel()
    @State var selectedImage:UIImage?
    @State var selectedViedoURL:URL?
    @Binding var tabSelection: TabBarItem
    
    var body: some View {
        ZStack{
            
            ScrollView(.vertical){
                VStack(){
                    
                    HStack(){
                        Label("Upload a reel to the contest", systemImage: "folder.circle")
                            .font(.sfProRounded(20, weight: .bold))
                            .foregroundColor(Color.reel_black_text)
                            .multilineTextAlignment(.center)
                    }
                    .padding([.leading, .trailing], 1)
                    .padding([.top], 20)
                    .padding([.top], 10)
                    .padding([.horizontal], 5)
                    
                    ContestEntryFormView(selectedViedoURL: $selectedViedoURL, selectedImage: $selectedImage, vm: vm)
                        .padding()
                    
                    FooterButtons
                    
                }
                .frame(maxWidth:.infinity)
                .background(Color.reel_white_text)
                .cornerRadius(8)
                .padding([.horizontal])
                .shadow(color:Color.reel_black_text.opacity(0.15), radius: 3)
            }
            Spacer()
            
        }
        .navigationBarHidden(true)
        .alert(isPresented: $vm.showAlert) {
            switch vm.activeAlert{
            case .confirmation:
                return Alert(
                    title: Text("Are you ready to confirm?"),
                    primaryButton: .destructive(Text("Let's do it!")) {
                         
                        print("did we reach the bottom?")

                    },
                    secondaryButton: .cancel())
            case .error:
              return  Alert(
                title: Text(vm.errorMsgTitle),
                message: Text(vm.errorMsg)
                )
            }
        }
        .fullScreenCover(isPresented: $vm.showVideoSelection, content: {
            AssetsPickerView(mediaType: .videos, image: $selectedImage, url: $selectedViedoURL)
        })
    }
    
    var FooterButtons: some View{
        HStack{
            
            Button {
                self.submitEntry()
            } label: {
                ZStack{
                    Rectangle()
                        .fill(.clear)
                    Text("Submit")
                        .font(.sfProRounded(14, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding([.horizontal], 10)
                }
            }
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .background(Color.reel_blue)
            .cornerRadius(5)
            .shadow(radius: 2)
            
            /*
            Spacer()
            
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                HStack(spacing:10){
                    Text("Cancel")
                        .lineLimit(1)
                        .font(.sfProRounded(14, weight: .medium))
                        .foregroundColor(Color.white)
                        
                }
            }
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .background(Color.reel_light_gray)
            .cornerRadius(5)
            .shadow(radius: 2)
            */
        }
        .padding([.vertical],15)
        .padding(.horizontal, 15)
    }
    
    func submitEntry(){
        if vm.tfName.isEmpty{
            vm.errorMsgTitle = "Hang On!"
            vm.errorMsg = "Name is required."
            vm.showAlert.toggle()
        }else if vm.tfPhone.isEmpty{
            vm.errorMsgTitle = "Hang On!"
            vm.errorMsg = "Phone number is required."
            vm.showAlert.toggle()
        }else if vm.tfCaption.isEmpty{
            vm.errorMsgTitle = "Hang On!"
            vm.errorMsg = "Caption is required."
            vm.showAlert.toggle()
        }else if vm.tfLocation.isEmpty{
            vm.errorMsgTitle = "Hang On!"
            vm.errorMsg = "Location is required."
            vm.showAlert.toggle()
        }
    }
}

struct SubmitEntrySceneView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitEntrySceneView(tabSelection: .constant(.add))
    }
}

//
//  ContestEntryFormView.swift
//  SwiftyMe
//
//  Created by MacBook on 03/04/2023.
//

import SwiftUI
import AVKit

struct ContestEntryFormView: View {
    
    @EnvironmentObject var textFieldViewModel:TextFieldViewModel
    @Binding var selectedViedoURL:URL?
    @Binding var selectedImage:UIImage?
    @State private var player:AVPlayer?
    var vm:SubmitEntrySceneViewModel = SubmitEntrySceneViewModel()
    
    var body: some View {
        VStack{
            TextFieldBordered(placeholder:"Full name",keyboardType: .default, foregroundColor: .black, fieldType: Field.contest_form_name){ val in
                vm.tfName = val ?? ""
            }
            .padding(.bottom, 15)
            
            TextFieldBordered(placeholder:"Phone number",keyboardType: .phonePad, foregroundColor: .black, fieldType: Field.contest_form_phone){ val in
                vm.tfPhone = val ?? ""
            }
            .padding(.bottom, 15)
            
            TextFieldBordered(placeholder:"Caption",keyboardType: .default, foregroundColor: .black, fieldType: Field.contest_form_caption){ val in
                vm.tfCaption = val ?? ""
            }
            .padding(.bottom, 15)
            
            TextFieldBordered(placeholder:"Location where it was captured",keyboardType: .default, foregroundColor: .black, fieldType: Field.contest_form_location){ val in
                vm.tfName = val ?? ""
            }
            .padding(.bottom, 15)
            
            HStack{
                if player != nil{
                    VideoPlayer(player: player)
                }else{
                    Image(systemName: "video.badge.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.reel_light_gray)
                        .frame(width: 100, height: 100)
                }
            }
            .frame(maxWidth:.infinity)
            .frame(height: UIScreen.main.bounds.width - 150)
            .cornerRadius(8)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.reel_light_gray)
                .opacity(0.3)
            )
            .onTapGesture {
                if player == nil{
                    print("attach video")
                    vm.showVideoSelection.toggle()
                }else{
                    print("url=",selectedViedoURL ?? "")
                    player?.play()
                }
            }
            if player != nil{
                TextUnderLineButton(title: "Select Different File", foreground: Color.blue, height: 40, weight: .semibold){
                    selectedViedoURL = nil
                    player = nil
                    vm.showVideoSelection.toggle()
                    
                }
            }
            
        }
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
        .onChange(of: selectedViedoURL){ newVal in
            if let url = newVal{
                print("url=",url)
                player = .init(AVPlayer(url: url))
            }
        }
        
    }
    
    func dismisssKeyBoard(){
        hideKeyboard()
        textFieldViewModel.focusedField = nil
    }
}

struct ContestEntryFormView_Previews: PreviewProvider {
    static var previews: some View {
        ContestEntryFormView(selectedViedoURL: .constant(nil), selectedImage: .constant(nil))
            .environmentObject(TextFieldViewModel())
    }
}

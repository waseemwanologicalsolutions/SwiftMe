//
//  APITestView.swift
//  SwiftyMe
//
//  Created by MacBook on 14/03/2023.
//

import SwiftUI

struct APITestView: View {
    
    @StateObject var apiTestViewModel = APITestsViewModel()
    
    var body: some View {
        VStack{
            Text("Test Multifarm Request")
                .underline()
                .foregroundColor(.blue)
                .onTapGesture {
                    apiTestViewModel.testMultiFormRequest()
                }
                .padding()
            
            Text("Test Post Request")
                .underline()
                .foregroundColor(.blue)
                .onTapGesture {
                    apiTestViewModel.testPostRequest()
                }
                .padding()
            
            Text("Test Json Request")
                .underline()
                .foregroundColor(.blue)
                .onTapGesture {
                    apiTestViewModel.testPostJsonRequest()
                }
                .padding()
            
            HStack{
                Text("Test File upload")
                    .underline()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        apiTestViewModel.testFileUpload()
                    }
                    .padding()
                ProgressCircle(progress: CGFloat(apiTestViewModel.uploadProgress), strockWidth: 4, background: .gray, forground: .blue)
                    .frame(width: 30, height: 30)
                
            }
            .padding()
            
            
            
            HStack{
                Text("Test File downloaad")
                    .underline()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        apiTestViewModel.testFileDownload()
                    }
                    .accessibilityLabel("Test File downloaad")
                    .padding()
                ProgressCircle(progress: CGFloat(apiTestViewModel.downloadProgress), strockWidth: 4, background: .gray, forground: .blue)
                    .frame(width: 30, height: 30)
               
            }
            .padding()
            
            Button() {
                apiTestViewModel.downloadProgress = 1
            } label: {
                Text("Hit Button")
            }

        }
    }
}

struct APITestView_Previews: PreviewProvider {
    static var previews: some View {
        APITestView()
    }
}

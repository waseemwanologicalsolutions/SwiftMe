//
//  ReelListCardView.swift
//  SwiftyMe
//
//  Created by MacBook on 30/03/2023.
//

import Foundation
import SwiftUI

struct ReelListCardView: View {
    
    @EnvironmentObject var stateManager:StateManager
    @State var reel:ReelsModel?
    @State var showSharingView:Bool = false
    var vm:ReelsDashboardSceneViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack() {
                Image("reel_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                
                Button(action: {
                    print("play video")
                    stateManager.selectedVideoFromList = reel?.id ?? ""
                    vm.showVideoFeeds.toggle()
                }) {
                    ZStack{
                        Rectangle()
                            .fill(.clear)
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .padding([.top], 2)
                .opacity(1.0)
                .frame(maxWidth: .infinity)
                
                
            }
            
            VStack(alignment:.leading, spacing: 5) {
                
                /*
                 HStack{
                 
                 SocialCircleButton(image:"reel_facebook",bgColor:Color.clear){
                 
                 }
                 Spacer()
                 SocialCircleButton(image:"reel_twitter",bgColor:Color.clear){
                 
                 }
                 Spacer()
                 SocialCircleButton(image:"reel_google",bgColor:Color.clear){
                 
                 }
                 Spacer()
                 SocialCircleButton(image:"reel_pinterest",bgColor:Color.clear){
                 
                 }
                 Spacer()
                 SocialCircleButton(image:"reel_copy",iconPadding: 7, width: 30, height: 30){
                 
                 let pasteboard = UIPasteboard.general
                 pasteboard.string = "link"
                 vm.errorMsgTitle = "Copied"
                 vm.errorMsg = ""
                 vm.activeAlert = .error
                 vm.showAlert.toggle()
                 }
                 
                 
                 }
                 .padding([.bottom], 5)
                 .padding([.horizontal], 5)
                 */
                
                Text(reel?.caption ?? "")
                    .lineLimit(1)
                    .font(.sfProRounded(14, weight: .semibold))
                    .foregroundColor(Color.reel_black_text)
                    .padding([.leading], 3)
                HStack(spacing: 1) {
                    Image(systemName: "mappin")
                        .foregroundColor(Color.reel_light_gray)
                    Text(reel?.location ?? "")
                        .lineLimit(1)
                        .font(.sfProRounded(13, weight: .regular))
                        .foregroundColor(Color.reel_light_gray)
                    
                    Spacer()
                }
                HStack{
                    Text("Contestant:")
                        .font(.sfProRounded(13, weight: .medium))
                        .foregroundColor(Color.reel_light_gray)
                        .padding([.leading], 3)
                    
                    Text(reel?.autherName ?? "")
                        .font(.sfProRounded(13, weight: .regular))
                        .foregroundColor(Color.reel_light_gray)
                    
                    
                    Spacer()
                }
                .padding([.bottom], 10)
                Divider()
                HStack{
                    
                    Text("300 Votes")
                        .font(.sfProRounded(14, weight: .regular))
                        .foregroundColor(Color.reel_black_text)
                    
                    IconButton(title: "", foreground: .clear, background: .clear, image: Image("share_web"),iconTintColor: Color.reel_black_text, iconAlignment: .center,iconPadding: 8, action: shareAction)
                        .frame(width: 40, height: 40)
                    
                    
                    Spacer()
                    
                    
                    Button {
                        
                    } label: {
                        HStack(spacing:10){
                            
                            Image(systemName: "heart")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 15, height: 15)
                            
                            Text("Vote Now")
                                .lineLimit(1)
                                .font(.sfProRounded(14, weight: .medium))
                                .foregroundColor(Color.white)
                            
                        }
                    }
                    .frame(height: 38)
                    .frame(width: 120)
                    .background(Color.reel_blue)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                    
                }
                .padding([.top],10)
                .padding(.horizontal, 3)
            }
            .padding(.horizontal, 8)
            .padding([.top],10)
            .padding([.bottom],15)
            
        }
        .onTapGesture {
            stateManager.selectedVideoFromList = reel?.id ?? ""
            vm.showVideoFeeds.toggle()
        }
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.reel_light_gray)
                .opacity(0.3)
        ).shadow(radius: 4)
            .sheet(isPresented: $showSharingView) {
                ActivityViewController(activityItems: [URL(string: "https://www.apple.com/")!])
            }
        
        
    }
    
    func shareAction(){
        //showSharingView.toggle()
        guard let urlShare = URL(string: reel?.url ?? "https://tripscon.com") else { return
            
        }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}


struct ReelListCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReelListCardView(reel: ReelsDashboardSceneViewModelData.initDataList()[0], vm: ReelsDashboardSceneViewModel())
    }
}

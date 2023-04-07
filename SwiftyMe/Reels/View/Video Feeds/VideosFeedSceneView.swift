//
//  VideosFeedSceneView.swift
//  SwiftyMe
//
//  Created by MacBook on 04/04/2023.
//

import SwiftUI
import AVKit

struct VideosFeedSceneView: View {
    
    @EnvironmentObject var stateManager:StateManager
    @Binding var data:[ReelsModel]
    @State var isPlaying:Bool = false
    @State var currentTab:Int = 0
    @Binding var tabSelection: TabBarItem
    @State var showSharingView:Bool = false
    @State var isOnScreen:Bool = false
     
   
    var body: some View {
        
        VStack{
            ZStack{
                GeometryReader { proxy in
                    TabView(selection: $currentTab) {
                        ForEach(self.data) { video in
                            let url = URL(string: video.url ?? "")!
                            HomepageVideoView(url:url, obj:video, showSharingView:$showSharingView, isOnScreen: $isOnScreen, currentTab: $currentTab)
                                .tag(video.tag)
                        }
                        .rotationEffect(.degrees(-90)) // Rotate content
                        .frame(
                            width: UIScreen.main.bounds.size.width,
                            height: UIScreen.main.bounds.size.height
                        )
                    }
                    .onChange(of: currentTab) { value in
                        print("selected tab = \(value)")
                        isOnScreen = true
                        
                    }
                    .frame(
                        width: UIScreen.main.bounds.size.height, // Height & width swap
                        height: UIScreen.main.bounds.size.width
                    )
                    .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
                    .offset(x: UIScreen.main.bounds.size.width) // Offset back into screens bounds
                    .tabViewStyle(
                        PageTabViewStyle(indexDisplayMode: .never)
                    )
                    
                }
                
            }
        
        }
        .padding([.horizontal],0)
        .padding([.vertical],0)
        .onChange(of: tabSelection){ newVal in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3){
                print("stateManager.selectedVideoFromList=",stateManager.selectedVideoFromList)
                print("self.data=",self.data.count)
                if let index = self.data.firstIndex(where: {$0.id == stateManager.selectedVideoFromList}){
                    print("index=",index)
                    stateManager.selectedVideoFromList = ""
                    self.currentTab = index
                }
            }
            if tabSelection == .feed{
                isOnScreen = true
            }else{
                isOnScreen = false
            }
        }
        .onAppear {
            print("onAppear VideosFeedSceneView")
            if tabSelection == .feed{
                isOnScreen = true
            }else{
                isOnScreen = false
            }
        }
        .onDisappear{
            print("onDisappear VideosFeedSceneView")
            isOnScreen = false
        }
        .statusBar(hidden: true)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationTitle("")
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showSharingView) {
            if currentTab < data.count{
                if let url = URL(string: (data[currentTab].url ?? "").encodeURL){
                    ActivityViewController(activityItems: [url])
                }
            }
        }
        
    }
    
    struct VideosFeedSceneView_Previews: PreviewProvider {
        static var previews: some View {
            VideosFeedSceneView(data: .constant([]), tabSelection: .constant(.feed))
        }
    }
    
}


struct HomepageVideoView: View {
    
    @State var isVideoPlaying:Bool = false
    @State private var player:AVPlayer
    @Binding var showSharingView:Bool
    @Binding var isOnScreen:Bool
    @Binding var currentTab:Int
    
    var item: ReelsModel
    
    init(url: URL, obj: ReelsModel, showSharingView:Binding<Bool>, isOnScreen:Binding<Bool>, currentTab:Binding<Int>) {
        _player = .init(wrappedValue: AVPlayer(url: url))
        _showSharingView = showSharingView
        _isOnScreen = isOnScreen
        _currentTab = currentTab
        item = obj
        
    }
    var body: some View {
        VStack{
            ZStack{
                
                Player(player: player)
                    .frame(width: UIScreen.main.bounds.width + 15, height: UIScreen.main.bounds.height)
                //.offset(y:-10)
                    .allowsHitTesting(false)
                    .tag(item.tag)
                    .onAppear{
                        if isOnScreen{
                            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player, queue: .main) { [self] _ in
                                DispatchQueue.main.async {
                                    //if isVideoPlaying{
                                        player.seek(to: .zero)
                                        player.play()
                                    //}
                                }
                            }
                        }
                        print("onAppear=",item.tag)
                    }
                    .onDisappear{
                        NotificationCenter.default.removeObserver(self)
                        print("onDisappear=",item.tag)
                    }
                
                Button(action: {
                    isVideoPlaying.toggle()
                    if isVideoPlaying{
                        player.play()
                    }else{
                        player.pause()
                    }
                }){
                    ZStack{
                        Rectangle()
                            .fill(.clear)
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(isVideoPlaying ? 0.0 : 1.0)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxWidth: .infinity)
                }
                
                UserVideoView()
                    .padding(.bottom,90)
                    .padding([.trailing],50)
                    .padding([.leading],10)
                
                RightSideMenuView(item: item, showSharingView: $showSharingView, currentTab: $currentTab)
                    .padding(.bottom,90)
                
               
            }
            .onChange(of: isOnScreen){ newVal in
                if newVal == false{
                    player.pause()
                }else if item.tag == currentTab{
                    isVideoPlaying = true
                    player.play()
                    player.seek(to: .zero)
                }
            }
            .onChange(of: currentTab){ newVal in
                if currentTab != item.tag{
                    player.pause()
                    print("player pasued=", currentTab)
                }else{
                    isVideoPlaying = true
                    player.play()
                    player.seek(to: .zero)
                }
            }
            
        }
    }
    
}

struct Player: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        //
    }
}

struct RightSideMenuView: View {
    
    var item: ReelsModel
    @Binding var showSharingView:Bool
    @Binding var currentTab:Int
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 35) {
                    
                    Button {
                        //currentTab = 1
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "hand.thumbsup.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.white)
                                .shadow(color:.black, radius: 4)
                            Text("22k")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .shadow(color:.black, radius: 4)
                        }
                    }
                    Button {
                        //currentTab = 3
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "message.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.white)
                                .shadow(color:.black, radius: 4)
                            Text("1021")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .shadow(color:.black, radius: 4)
                        }
                    }
                    Button {
                        showSharingView.toggle()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "arrowshape.turn.up.right.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.white)
                                .shadow(color:.black, radius: 4)
                            Text("Share")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .shadow(color:.black, radius: 1)
                        }
                    }
                }
                .padding(.bottom, 30)
                .padding(.trailing)
            }
        }
        
    }
}

struct UserVideoView: View{
    
    var body: some View{
        VStack{
            Spacer()
            HStack{
                
                Button {
                    print("show profile")
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 26, height: 26, alignment: .center)
                        .foregroundColor(.white)
                        .cornerRadius(13)
                }
                Text("@PrinkaMonkya")
                    .font(.sfProRounded(14, weight: .regular))
                    .foregroundColor(Color.white)
                
                Button {
                    
                } label: {
                    HStack(spacing:10){
                        
                        Image(systemName: "heart")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 14, height: 14)
                        
                        Text("Vote Now")
                            .lineLimit(1)
                            .font(.sfProRounded(13, weight: .medium))
                            .foregroundColor(Color.white)
                        
                    }
                }
                .frame(height: 30)
                .frame(width: 100)
                .background(Color.reel_blue)
                .cornerRadius(5)
                .shadow(radius: 2)
                
                Spacer()
            }
            HStack{
                Text("Main Kahi Eid Gifts #wanological")
                    .lineLimit(2)
                    .font(.sfProRounded(12, weight: .regular))
                    .foregroundColor(Color.white)
                Spacer()
            }
        }
        .frame(maxWidth:.infinity)
        .shadow(color:.black.opacity(0.35),radius: 2)
        .padding()
    }
}

struct UserVideoView_Previews: PreviewProvider {
    static var previews: some View {
        UserVideoView()
    }
}

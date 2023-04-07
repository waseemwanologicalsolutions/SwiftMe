//
//  VideosFeedSceneView.swift
//  SwiftyMe
//
//  Created by MacBook on 04/04/2023.
//

import SwiftUI
import AVKit

struct VideosFeedSceneView: View {
    
    @Binding var data:[Video]
    //@State var data = [Video]()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                PlayerScrollView(data: self.$data)
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        
    }
    
    struct VideosFeedSceneView_Previews: PreviewProvider {
        static var previews: some View {
            VideosFeedSceneView(data: .constant([]))
        }
    }
    
    struct PlayerView: View {
        
        @Binding var data: [Video]
        @State var isPlaying = false
        
        var body: some View {
            VStack(spacing: 0) {
                ForEach(self.data) { video in
                    ZStack {
                        Player(player: video.player)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .onTapGesture {
                                changePlayingState(video)
                            }
                        if isPlaying {
                            Button {
                                changePlayingState(video)
                            } label: {
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .onAppear {
                if self.data.isEmpty == false{
                    self.data[0].player.play()
                    isPlaying = false
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.data[0].player.currentItem, queue: .main) { [self] _ in
                        data[0].player.seek(to: .zero)
                        data[0].player.play()
                    }
                    
                }
            }
        }
        
        private func changePlayingState(_ video: Video) {
            isPlaying.toggle()
            if isPlaying {
                video.player.pause()
            } else {
                video.player.play()
            }
            print("data=", data.count)
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
    
    
    struct PlayerScrollView: UIViewRepresentable {
        
        @Binding var data: [Video]
        
        func makeCoordinator() -> Coordinator {
            return PlayerScrollView.Coordinator(parent: self)
        }
        
        func makeUIView(context: Context) -> UIScrollView {
            let view = UIScrollView()
            let childView = UIHostingController(rootView: PlayerView(data: self.$data))
            childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
            view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
            view.addSubview(childView.view)
            view.showsVerticalScrollIndicator = false
            view.showsHorizontalScrollIndicator = false
            view.contentInsetAdjustmentBehavior = .never
            view.isPagingEnabled = true
            view.delegate = context.coordinator
            view.bounces = false
            return view
        }
        
        func updateUIView(_ uiView: UIScrollView, context: Context) {
            refershData(view: uiView, context: context)
            uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        }
        
        func refershData(view:UIScrollView, context:Context){
        
            print("refershData=", data.count)
        }
        
        class Coordinator: NSObject, UIScrollViewDelegate {
            
            var parent: PlayerScrollView
            var index = 0
            
            init(parent: PlayerScrollView) {
                self.parent = parent
            }
            
            func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
                
                let currentIndex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
                for i in 0..<parent.data.count {
                    if index != currentIndex {
                        parent.data[i].player.seek(to: .zero)
                        parent.data[i].player.pause()
                    }
                }
                if index != currentIndex {
                    index = currentIndex
                    parent.data[index].player.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { [self] _ in
                        parent.data[index].player.seek(to: .zero)
                        parent.data[index].player.play()
                    }
                }
            }
        }
    }
}

struct Video: Identifiable {
    let id: String
    let player: AVPlayer
    let playing: Bool
}

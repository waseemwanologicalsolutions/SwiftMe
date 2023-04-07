//
//  ReelsDashboardSceneViewModel.swift
//  SwiftyMe
//
//  Created by MacBook on 30/03/2023.
//

import Foundation

enum ActiveAlert {
    case confirmation, error
}

class ReelsDashboardSceneViewModel:ObservableObject{
    @Published var isLoading:Bool = false
    @Published var isAPICall:Bool = false
    @Published var showSubmitEnttry:Bool = false
    @Published var showVideoFeeds:Bool = false
    @Published var datasource = [ReelsModel]()
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var errorMsgTitle: String = ""
    @Published var activeAlert: ActiveAlert = .error
}

class ReelsDashboardSceneViewModelData{
    static func initDataList()->[ReelsModel]{
        var array = [ReelsModel]()
        array.append(ReelsModel(id: UUID().uuidString,url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", location:"Rawal Lake, BaniGala Rawal Lake, BaniGala Rawal Lake, BaniGala Rawal Lake, BaniGala Rawal Lake, BaniGala Rawal Lake, BaniGala", caption: "Clouds Covering Kumrat Valley", votes: 100, autherName: "Gulo But", tag: 1))
        array.append(ReelsModel(id: UUID().uuidString,url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", location:"Kumrat Valley", caption: "The Golden Touch", votes: 100, autherName: "James Bond", tag: 2))
        
        array.append(ReelsModel(id: UUID().uuidString,url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", location:"Rawal Lake, BaniGala", caption: "Clouds Covering Kumrat Valley", votes: 100, autherName: "Gulo But", tag: 3))
        array.append(ReelsModel(id: UUID().uuidString,url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", location:"Kumrat Valley", caption: "The Golden Touch", votes: 100, autherName: "James Bond", tag: 4))
        
        return array
    }
}

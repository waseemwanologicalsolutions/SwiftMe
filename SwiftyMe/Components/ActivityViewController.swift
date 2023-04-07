//
//  ActivityViewController.swift
//  SwiftyMe
//
//  Created by MacBook on 04/04/2023.
//

import Foundation
import SwiftUI
import UIKit


struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [URL]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        
        controller.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            
            if activityType == .postToFacebook {
                shareLink(from: activityItems.first!)
            }
            
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

    func shareLink(from url: URL) {
        
        // controller was created so I would have a UIViewControllerType to put as a parameter for fromViewController in ShareDialog, even though I don't think it fits
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        
       
    }
    
}

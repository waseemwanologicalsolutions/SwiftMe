//
//  BackgroundTask.swift

import Foundation
import UIKit

class BackgroundTask: NSObject {

    private let application: UIApplication
    private var identifier = UIBackgroundTaskIdentifier.invalid
    
    init(application: UIApplication) {
        self.application = application
    }
    
    class func run(application: UIApplication, handler: (BackgroundTask) -> ()) {
        // NOTE: The handler must call end() when it is done
        
        let backgroundTask = BackgroundTask(application: application)
        backgroundTask.begin()
        handler(backgroundTask)
    }
    
    func begin() {
        self.identifier = application.beginBackgroundTask {
            self.end()
        }
    }
    
    func end() {
        if (identifier != UIBackgroundTaskIdentifier.invalid) {
            application.endBackgroundTask(identifier)
        }
        
        identifier = UIBackgroundTaskIdentifier.invalid
    }
}

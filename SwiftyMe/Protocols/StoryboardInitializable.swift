//
//  StoryboardInitializable.swift
//

import Foundation
import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
    static func storyboardName() -> String
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName(), bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}

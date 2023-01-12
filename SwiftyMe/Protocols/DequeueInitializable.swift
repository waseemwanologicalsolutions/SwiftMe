//
//  DequeueInitializable.swift
//


import Foundation
import UIKit

protocol DequeueInitializable {
    static var reuseableIdentifier: String { get }
    static var nib: UINib { get }
}

extension DequeueInitializable where Self: UITableViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseableIdentifier, bundle: nil)
    }
    
    static func dequeue(tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseableIdentifier) else {
            return UITableViewCell() as! Self
        }
        cell.selectionStyle = .none
        return cell as! Self
    }
    
    static func register(tableView: UITableView){
        tableView.register(self.nib, forCellReuseIdentifier: self.reuseableIdentifier)
    }
}

extension DequeueInitializable where Self: UICollectionViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseableIdentifier, bundle: nil)
    }
    
    static func dequeue(collectionView: UICollectionView,indexPath: IndexPath) -> Self {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseableIdentifier, for: indexPath)
        
        return cell as! Self
    }
    
    static func register(collectionView: UICollectionView) {
        collectionView.register(self.nib, forCellWithReuseIdentifier: self.reuseableIdentifier)
     }
}


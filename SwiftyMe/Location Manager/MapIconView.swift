//
//  MapIconView.swift
//  TripsCon
//
//  Created by MacBook on 07/12/2022.
//

import UIKit

class MapIconView: UIView {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var viewContainer:UIView!
    var id:Int?

    class func instanceFromNib(_ txt:String) -> MapIconView {
        
        let vw =  UINib(nibName: "MapIconView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MapIconView
        let font = UIFont(name: "Outfit", size: 17.0)!
        var w = 65.0
        w = font.calculateWidth(text: txt, height: 30.0) + 30.0
        vw.lblTitle.text = txt
        vw.frame = CGRect(x: 0, y: 0, width: min(w, 200), height: 40)
 
        return vw
    }
}

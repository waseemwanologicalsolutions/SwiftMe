//
//  ImagePickerView.swift
//  SwiftyMe
//
//  Created by MacBook on 03/04/2023.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        let image = selectedImage.rotateCameraImageToProperOrientation(scaledToWidth: 640)
        self.picker.selectedImage = image
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}

extension UIImage{
    func rotateCameraImageToProperOrientation(scaledToWidth : CGFloat) -> UIImage {
        let sourceImage = self
        let imgRef = sourceImage.cgImage
        let width = CGFloat(imgRef!.width)
        let height = CGFloat(imgRef!.height)
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        var scaleRatio : CGFloat = 1
        if width > scaledToWidth || height > scaledToWidth {
            scaleRatio = min(scaledToWidth / bounds.size.width, scaledToWidth / bounds.size.height)
            bounds.size.height = bounds.size.height * scaleRatio
            bounds.size.width = bounds.size.width * scaleRatio
        }
        var transform = CGAffineTransform.identity
        let orient = sourceImage.imageOrientation
        let imageSize = CGSize(width: imgRef!.width, height: imgRef!.height)
        
        switch sourceImage.imageOrientation {
        case .up :
            transform = CGAffineTransform.identity
            
        case .upMirrored :
            transform = CGAffineTransform(translationX: imageSize.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .down :
            transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
            transform = transform.rotated(by: CGFloat.pi)
            
        case .downMirrored :
            transform = CGAffineTransform(translationX: 0, y: imageSize.height)
            transform = transform.scaledBy(x: 1, y: -1)
            
        case .left :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(translationX: 0, y: imageSize.width)
            transform = transform.rotated(by: 3.0 * CGFloat.pi / 2.0)
            
        case .leftMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: 3.0 * CGFloat.pi / 2.0)
            
        case .right :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            
        case .rightMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(scaleX: -1, y: 1)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        let context = UIGraphicsGetCurrentContext()
        
        if orient == .right || orient == .left {
            
            context!.scaleBy(x: -scaleRatio, y: scaleRatio)
            context!.translateBy(x: -height, y: 0)
        } else {
            context!.scaleBy(x: scaleRatio, y: -scaleRatio)
            context!.translateBy(x: 0, y: -height)
        }
        
        context!.concatenate(transform)
        context!.draw(imgRef!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageCopy!.compressTo(4)!
    }
    func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
            if data.count < sizeInBytes {
                needCompress = false
                imgData = data
            } else {
                compressingValue -= 0.1
            }
        }
    }

    if let data = imgData {
        return UIImage(data: data)
    }
        return nil
    }

}


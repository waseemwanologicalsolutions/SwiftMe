//
//  AssetsPickerView.swift
//  SwiftyMe
//
//  Created by MacBook on 03/04/2023.
//

import SwiftUI
import PhotosUI

struct AssetsPickerView: UIViewControllerRepresentable {
    
    var mediaType:PHPickerFilter = .images
    @Binding var image:UIImage?
    @Binding var url:URL?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = mediaType
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: AssetsPickerView
        
        init(_ parent: AssetsPickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            guard let provider = results.first?.itemProvider else {
                picker.dismiss(animated: true)
                return
            }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    let image = image as? UIImage
                    self.parent.image = image
                    picker.dismiss(animated: true)
                }
            }else if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                self.dealWithVideo(results.first!, picker: picker)
            }else{
                picker.dismiss(animated: true)
            }
        }
        
        fileprivate func dealWithVideo(_ result: PHPickerResult, picker:PHPickerViewController) {
            
            let movie = UTType.movie.identifier
            let prov = result.itemProvider
            prov.loadFileRepresentation(forTypeIdentifier: movie) { url, err in
                if let url = url {
                    let fm = FileManager.default
                    let destination = fm.temporaryDirectory.appendingPathComponent("video123.mov")
                    try? fm.removeItem(at: destination)
                    try? fm.copyItem(at: url, to: destination)
                    DispatchQueue.main.async {
                        self.parent.url = nil
                        self.parent.url = destination
                        self.parent.image = self.generateThumbnail(url: destination)
                        picker.dismiss(animated: true)
                    }
                }
            }
        }
        func getOriginalImageFrmAsset(asset: PHAsset) -> UIImage {
            let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
            return thumbnail
        }
        
        func generateThumbnail(url: URL) -> UIImage? {
            do {
                let asset = AVURLAsset(url: url)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                imageGenerator.appliesPreferredTrackTransform = true
                // Select the right one based on which version you are using
                // Swift 4.2
                let cgImage = try imageGenerator.copyCGImage(at: .zero,
                                                             actualTime: nil)
                return UIImage(cgImage: cgImage)
            } catch {
                print(error.localizedDescription)

                return nil
            }
        }
    }
}

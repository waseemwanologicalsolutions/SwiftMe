//
//  FileDownloader.swift
//

import UIKit
import Foundation


class FileDownloader: NSObject, URLSessionDelegate,URLSessionDataDelegate, URLSessionDownloadDelegate {
    
    var name:String!
    var fileURL:String!
    var indexPath:IndexPath!
    var completionHandler:((Bool, String,IndexPath) -> Void)?
    var progressHandler:((CGFloat) -> Void)?
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        do {
             let documentsUrl =  AppUtility.getDocumentsDirectory()
             let destinationUrl = documentsUrl.appendingPathComponent(name)
             try FileManager.default.moveItem(at: location, to: destinationUrl)
             print("moved file to: \(destinationUrl.absoluteString)")
            _ = self.completionHandler?(true, self.name, self.indexPath)
        } catch {
            print ("file error: \(error)")
            _ = self.completionHandler?(false, self.name, self.indexPath)
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
        let progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        print("progress=",progress)
        self.progressHandler?(progress)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64){

    }

    func downloadFileWithProgress(fName:String, fileUrl:String, indexPath:IndexPath) {
        
        self.name = fName
        self.fileURL = fileUrl
        self.indexPath = indexPath
        if let audioUrl = URL(string: self.fileURL) {
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
            let downloadTask = session.downloadTask(with: audioUrl)
            downloadTask.resume()
            
        }else{
            _ = self.completionHandler?(false, self.name, self.indexPath)
        }
    }
    
    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = AppUtility.getDocumentsDirectory()
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }
    
    static func loadFileAsync(name:String, url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  AppUtility.getDocumentsDirectory()
        let destinationUrl = documentsUrl.appendingPathComponent(name)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler:
        {
            data, response, error in
            if error == nil
            {
                if let response = response as? HTTPURLResponse
                {
                    if response.statusCode == 200
                    {
                        if let data = data
                        {
                            if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                            {
                                completion(destinationUrl.path, error)
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                        else
                        {
                            completion(destinationUrl.path, error)
                        }
                    }else{
                        
                        completion(destinationUrl.path, error)
                    }
                }
            }
            else
            {
                if let error = error as NSError?, error.domain == NSURLErrorDomain, error.code == NSURLErrorNotConnectedToInternet {
                    print("not connected, stop recuresive download calls")
                    completion(destinationUrl.path, error)
                }else{
                    completion(destinationUrl.path, error)
                }
                
            }
        })
        task.resume()
      
    }
}
/*
DispatchQueue.main.async {
    
    print("uploadProgress",uploadProgress.fractionCompleted)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATIONS.FILE_UPLOAD_PROGRESS), object: nil, userInfo: ["file": fileName, "progress":uploadProgress.fractionCompleted])
    //self.activityIndicator.setProgress(progress: CGFloat(uploadProgress.fractionCompleted), animated: true)
}*/

//
//  FileReadandWrite.swift
//  EventBrowser
//
//  Created by Zeynep on 10.01.2022.
//

import Foundation
import FirebaseStorage
import UIKit


class FileReadandWrite{
    
    init(path: String, fileName: String){
 
        
    }
    
    func downloadImage(){
        
   // gs://iostermprojectv5.appspot.com/images/10@1x.png
//        // Create a reference to the file we want to download
//        let starsRef = Storage.storage().reference().child("images/10@1x.png")
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        print("StarsRef: \(starsRef)")
//        starsRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//          if let error = error {
//            // Uh-oh, an error occurred!
//              print("TEST 5 Error")
//          } else {
//            // Data for "images/island.jpg" is returned
//            let image = UIImage(data: data!)
//              //print("TEST 5 :\(image)")
//          }
//        }
        

        let Ref = Storage.storage().reference().child("images/10@3x.png")
        Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error@")
            } else {
                let image = UIImage(data: data!)
                print("YOOOOO")
            }
        }
        
//        let path = "Listings/Food/-M3g8pZDGmApicUAQtOi/MainImage.jpg"
//        let reference = Storage.storage().reference(withPath: path)
//
//        reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
//                if let err = error {
//                   print(err)
//              } else {
//                if let image  = data {
//                     let myImage: UIImage! = UIImage(data: image)
//
//                     // Use Image
//                }
//             }
//        }

    }
}
// Create a root reference
    
//
//        let path = "/Users/zeynepdundar/Library/Developer/XCPGDevices/B0CAE719-4242-4E52-B933-37406C6744EF/data/Containers/Data/Application/1FCD56BE-E824-4E16-830B-DF3EB2C6DADA/Documents/7/"
//
//        var fileName = "dayi@2x"
//        let storageRef = Storage.storage().reference()
//        // File located on disk
//        let localFile = URL(string: path)!
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("images/\(fileName).png")
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//            // uncomment for download
////          riversRef.downloadURL { (url, error) in
////            guard let downloadURL = url else {
////              // Uh-oh, an error occurred!
////              return
////            }
////          }
//        }
//
//
//
//    }
//


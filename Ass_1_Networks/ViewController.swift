//
//  ViewController.swift
//  Ass_1_Networks
//
//  Created by Kareem Ismail on 10/16/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ViewController: UIViewController {
    let howManyPacketsToSend = 2 //constant for how many packets you wish to send
    var howManyPacketsSent = 0 // counter for how many packets sent
    let delayBetweenPackets = 10.0 // 10 seconds delay between each packet
    let compressionValue = 0.7 //change the compterssion value to get different sizes
    @IBOutlet weak var progressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImage()
    }
    func uploadImage(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("Images/\(arc4random())")
        if let imageToBeUploaded = UIImage(named: "IMG_3616"){
            guard let imageDataToBeUploaded = UIImageJPEGRepresentation(imageToBeUploaded, CGFloat(self.compressionValue)) else {return}
            
            let uploadTask = imagesRef.putData(imageDataToBeUploaded, metadata: nil)
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                self.progressLabel.text = "\(Int(percentComplete)) % Completed"
            }
            uploadTask.observe(.success) { snapshot in
                // Upload completed successfully
                self.howManyPacketsSent += 1
                self.progressLabel.text = "Uploaded Packet \(self.howManyPacketsSent) Successfully !!"
                if self.howManyPacketsSent < self.howManyPacketsToSend {
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.delayBetweenPackets, execute: {
                        self.uploadImage()
                    })
                }
            }
            uploadTask.observe(.failure) { snapshot in
                self.progressLabel.text = "Falied To Upload !!"
            }
            
        }
    }

}


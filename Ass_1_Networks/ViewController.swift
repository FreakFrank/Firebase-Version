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

    @IBOutlet weak var progressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("Images/Reykjavic Lake.jpg")
        if let imageToBeUploaded = UIImage(named: "IMG_3616"){
            guard let imageDataToBeUploaded = UIImageJPEGRepresentation(imageToBeUploaded, 0.7) else {return}
            let uploadTask = imagesRef.putData(imageDataToBeUploaded, metadata: nil)
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                    self.progressLabel.text = "\(Int(percentComplete)) % Completed"
            }
            uploadTask.observe(.success) { snapshot in
                // Upload completed successfully
                self.progressLabel.text = "Uploading Completed Successfully !!"
            }
            uploadTask.observe(.failure) { snapshot in
                self.progressLabel.text = "Falied To Upload !!"
            }

        }
        

        
        
    }

}


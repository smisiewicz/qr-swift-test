//
//  ViewController.swift
//  QRSwiftTestExample
//
//  Created by Bastek on 9/5/18.
//  Copyright © 2018 PeerStream, Inc. All rights reserved.
//

import UIKit
import QRSwiftTest


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generate { (image) in
            guard let image = image else { return }
            self.read(image: image)
        }
    }

    /////////////////////////
    private func generate(completion: ((UIImage?) -> Swift.Void)) {
        switch QRTools.generateQR(from: "https://google.com") {
        case .success(let image):
            self.onSuccess(image: image)
            completion(image)

        case .failure(error: let error):
            self.onFailure(error: error)
        }

        completion(nil)
    }

    private func read(image: UIImage) {
        switch QRTools.readQR(from: image) {
        case .success(let val):
            self.onSuccess(val: val)

        case .failure(error: let error):
            self.onFailure(error: error)
        }
    }

    private func onSuccess(image: UIImage) {
        NSLog(">>>>>>>>>>>>>>>>> SUCCESS QR: \(image)")
        imageView.image = image
    }

    private func onSuccess(val: String) {
        NSLog(">>>>>>>>>>>>>>>>> SUCCESS QR STRING: \(val)")
        label.text = val
    }

    private func onFailure(error: Error) {
        NSLog(">>>>>>>>>>>>>>>>> FAILURE QR: \(error)")
    }
}


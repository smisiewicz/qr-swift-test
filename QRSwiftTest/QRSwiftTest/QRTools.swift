//
//  QRTools.swift
//  QRSwiftTest
//
//  Created by Bastek on 9/6/18.
//  Copyright © 2018 PeerStream, Inc. All rights reserved.
//

import UIKit
import EFQRCode


struct QRToolError: Error, CustomStringConvertible {
    public let message: String
    public let internalError: Error?

    init(message: String, error: Error? = nil) {
        self.message = message
        self.internalError = error
    }

    public var description: String {
        return message
    }
}

enum QRToolGenerateResult {
    case success(UIImage)
    case failure(error: Error)
}

enum QRToolDecodeResult {
    case success(String)
    case failure(error: Error)
}


class QRTools {
    static func generateQR(from string: String) -> QRToolGenerateResult {
        if let qr = EFQRCode.generate(content: string) {
            let image = UIImage(cgImage: qr)
            return .success(image)
        }

        return .failure(error: QRToolError(message: "Failed to generate QR from: \(string)"))
    }

    static func readQR(from image: UIImage) -> QRToolDecodeResult {
        guard let image = image.cgImage else {
            return .failure(error: QRToolError(message: "Failed to read QR image"))
        }

        if let result = EFQRCode.recognize(image: image)?.first {
            return .success(result)
        }

        return .failure(error: QRToolError(message: "Failed to read QR image"))
    }

    // empty constructor
    private init() {}
}

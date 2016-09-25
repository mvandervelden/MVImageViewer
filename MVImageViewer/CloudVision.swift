//  Copyright © 2016 mmvdv. All rights reserved.

import UIKit

let apiKey = "YOU_API_KEY_HERE"
let apiLimit = 2097152

struct CloudVisionResult {
}

enum CloudVisionFinished {
    case success(CloudVisionResult)
    case error(Error)
}

enum CloudVisionError: Error {
    case resizeFailed
    case base64EncodingFailed
}

class CloudVision {
    func process(image: UIImage, completion: (_: CloudVisionFinished) -> Void ) {
        do {
            let binaryData = try image.base64Encoding()
            createRequest(with: binaryData, completion)
        } catch {
            completion(.error(error))
        }
    }
    
    private func createRequest(with data: String, _ completion: (_: CloudVisionFinished) -> Void) {
        completion(.error(CloudVisionError.resizeFailed))
    }
}


extension UIImage {
    func base64Encoding() throws -> String {
        guard var imagedata = UIImagePNGRepresentation(self) else {
            throw CloudVisionError.base64EncodingFailed
        }
        
        if imagedata.count > apiLimit {
            let oldSize = size
            let newSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = try resize(newSize)
        }
        
        return imagedata.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    private func resize(_ newSize: CGSize) throws -> Data {
        UIGraphicsBeginImageContext(newSize)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext(),
                let resizedImage = UIImagePNGRepresentation(newImage) else {
                    UIGraphicsEndImageContext()
                    throw CloudVisionError.resizeFailed
        }
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

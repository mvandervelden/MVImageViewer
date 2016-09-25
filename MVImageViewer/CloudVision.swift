//  Copyright © 2016 mmvdv. All rights reserved.

import UIKit

let apiKey = "YOU_API_KEY_HERE"
let apiLimit = 2097152

struct LabelAnnotation: CustomStringConvertible {
    let label: String
    let score: Double
    
    init?(json: [String: Any]) {
        guard let label = json["description"] as? String,
              let score = json["score"] as? Double
        else {
            return nil
        }
        self.label = label
        self.score = score
    }
    
    var description: String {
        return "<label: \(label), score: \(score)>"
    }
}

struct CloudVisionResult: CustomStringConvertible {
    let annotations: [LabelAnnotation]
    
    init?(json: [String: Any]) {
        print(json)

        guard let responses = json["responses"] as? [[String: Any]] else {
            return nil
        }
        let response = responses[0]
        guard let labelAnnotations = response["labelAnnotations"] as? [[String: Any]] else {
            return nil
        }
        
        annotations = labelAnnotations.map() { (json) -> LabelAnnotation? in
            LabelAnnotation(json: json)
            }.flatMap() { $0 }
    }
    
    var description: String {
        return annotations.description
    }
}

enum CloudVisionFinished: CustomStringConvertible {
    case success(CloudVisionResult)
    case failure(Error)
    
    var description: String {
        switch self {
        case .failure(let error):
            return error.localizedDescription
        case .success(let result):
            return result.description
        }
    }
}

enum CloudVisionError: Error {
    case resizeFailed
    case base64EncodingFailed
    case noData
    case deserializationError(String)
}

class CloudVision {
    
    private var url: URL {
        get {
            return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(apiKey)")!
        }
    }
    
    func process(image: UIImage, completion: @escaping (_: CloudVisionFinished) -> Void ) {
        do {
            let binaryData = try image.base64Encoding()
            createRequest(with: binaryData, completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    private func createRequest(with imageData: String, _ completion: @escaping (_: CloudVisionFinished) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        let json: [String: Any] = [
            "requests":[
                "image": [
                    "content": imageData],
                "features": [
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 10
                    ], [
                        "type": "FACE_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        DispatchQueue.global().async {
            self.perform(request, completion)
        }
    }
    
    private func perform(_ request: URLRequest, _ completion: @escaping (_: CloudVisionFinished) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data,
                   let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any],
                   let result = CloudVisionResult(json: json) {
                    completion(.success(result))
                } else {
                    completion(.failure(CloudVisionError.noData))
                }
                
            }
        }
        task.resume()
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

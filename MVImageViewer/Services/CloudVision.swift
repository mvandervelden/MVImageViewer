//  Copyright © 2016 mmvdv. All rights reserved.

import UIKit

let apiLimit = 2097152

class CloudVision {
    private var apiKey: String {
        get {
            if let key = Bundle.main.infoDictionary?["CloudVisionAPIKey"] as? String {
                return key
            }
            return "NoApiKeyConfigured"
        }
    }
    
    private var url: URL {
        get {
            return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(apiKey)")!
        }
    }
    
    func process(image: UIImage, completion: @escaping (_: CloudVisionResponse) -> Void ) {
        do {
            let binaryData = try image.base64Encoding()
            let requestJson = try createJson(with: binaryData)
            createRequest(withJson: requestJson, completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    private func createJson(with imageData: String) throws -> Data {
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
        return try JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    private func createRequest(withJson json: Data, _ completion: @escaping (_: CloudVisionResponse) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        request.httpBody = json
        
        DispatchQueue.global().async {
            self.perform(request, completion)
        }
    }
    
    private func perform(_ request: URLRequest, _ completion: @escaping (_: CloudVisionResponse) -> Void) {
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

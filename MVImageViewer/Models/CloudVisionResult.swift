//  Copyright © 2016 mmvdv. All rights reserved.

import Foundation

struct CloudVisionResult: CustomStringConvertible {
    let annotations: [LabelAnnotation]
    
    init?(json: [String: Any]) {
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

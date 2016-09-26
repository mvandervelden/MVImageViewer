//  Copyright © 2016 mmvdv. All rights reserved.

import Foundation

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

//  Copyright © 2016 mmvdv. All rights reserved.

import Foundation

enum CloudVisionResponse: CustomStringConvertible {
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

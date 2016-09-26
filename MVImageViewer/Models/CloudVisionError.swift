//  Copyright © 2016 mmvdv. All rights reserved.

import Foundation

enum CloudVisionError: Error {
    case resizeFailed
    case base64EncodingFailed
    case noData
    case deserializationError(String)
}

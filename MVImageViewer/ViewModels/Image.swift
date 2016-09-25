//  Copyright © 2016 mmvdv. All rights reserved.

import UIKit

class Image {
    var image: UIImage?
    var analysis: CloudVisionResult?
    
    required init(image: UIImage) {
        self.image = image
    }
}

// Created by mmvdv on 13/07/16.

import UIKit

protocol Detail {
    var image: UIImage? { get }
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var vision = CloudVision()
    
    var detailItem: Detail? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        detailImageView.image = detailItem?.image
        if let image = detailItem?.image {
            fetchInformation(image: image)
        }
    }
    
    private func fetchInformation(image: UIImage) {
        vision.process(image: image) { (result) in
            print(result)
        }
    }
}

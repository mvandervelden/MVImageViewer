// Created by mmvdv on 13/07/16.

import UIKit

protocol Detail {
    var image: UIImage? { get }
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var detailItem: Detail? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        if let imageView = detailImageView {
            imageView.image = detailItem?.image
        }
    }
}

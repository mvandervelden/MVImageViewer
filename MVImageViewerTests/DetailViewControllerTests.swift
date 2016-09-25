import Quick
import Nimble
@testable import MVImageViewer

class DetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("detail view controller") {
            var subject: DetailViewController!
            
            beforeEach() {
                subject = UIViewController.loadViewController(withIdentifier: "DetailViewController",
                                                              fromStoryboard: "Main") as? DetailViewController
                subject.show()
            }
            
            context("given a detail item") {
                let detail = Image(image:UIImage())
                
                beforeEach() {
                    subject.detailItem = detail
                }
                
                it("sets the item's description in the detail label") {
                    expect(subject.detailImageView.image) == detail.image
                }
                
                context("detail item is changed") {
                    let changed = Image(image:UIImage())
                    
                    beforeEach() {
                        subject.detailItem = changed
                    }
                    
                    it("updates the label") {
                        expect(subject.detailImageView.image) == changed.image
                    }
                }
            }
            
            context("given no detail item") {
                it("has an empty label") {
                    expect(subject.detailImageView.image).to(beNil())
                }
            }
        }
    }
}

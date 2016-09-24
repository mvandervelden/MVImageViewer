import Quick
import Nimble
@testable import MVImageViewer


extension String: Detail {
    func description() -> String {
        return description
    }
}

class DetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("detail view controller") {
            var subject: DetailViewController!
            
            beforeEach() {
                subject = UIViewController.loadViewController(withIdentifier: "DetailViewController",
                                                              fromStoryboard: "Main") as? DetailViewController
            }
            
            context("given a detail item") {
                beforeEach() {
                    subject.detailItem = "some item"
                }
                
                context("when detail screen is shown") {
                    beforeEach() {
                        subject.show()
                    }
                    
                    it("sets the item's description in the detail label") {
                        expect(subject.detailDescriptionLabel.text) == "some item"
                    }
                    
                    context("detail item is changed") {
                        beforeEach() {
                            subject.detailItem = "changed"
                        }
                        
                        it("updates the label") {
                            expect(subject.detailDescriptionLabel.text) == "changed"
                        }
                    }
                }
            }
            
            context("given no detail item") {
                context("when detail screen is shown") {
                    beforeEach() {
                        subject.show()
                    }
                    
                    it("has an empty label") {
                        expect(subject.detailDescriptionLabel.text) == ""
                    }
                }
            }
        }
    }
}

// Created by mmvdv on 13/07/16.

import Quick
import Nimble
@testable import MVImageViewer

class MasterViewControllerSpec: QuickSpec {
    override func spec() {
        describe("master view controller") {
            var subject: MasterViewController!
            
            beforeEach() {
                subject = UIViewController.loadViewController(withIdentifier: "MasterViewController",
                                                              fromStoryboard: "Main") as? MasterViewController
            }
            
            context("showing the screen") {
                beforeEach() {
                    subject.show()
                }
                
                describe("adding a new object") {
                    var tableView: InsertionTableView!
                    
                    beforeEach() {
                        tableView = InsertionTableView()
                        subject.tableView = tableView
                        
                        subject.insertNewObject(self)
                    }
                    
                    it("adds an object to the view model") {
                        expect(subject.objects).to(haveCount(1))
                    }
                    
                    it("adds an object the start of the table") {
                        expect(tableView.insertedIndexPath) == IndexPath(row: 0, section: 0)
                    }
                }
            }
        }
    }
}

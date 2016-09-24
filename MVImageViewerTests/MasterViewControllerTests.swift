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
            
            it("has an image picker") {
                expect(subject.imagePicker).toNot(beNil())
            }
            
            context("showing the screen") {
                beforeEach() {
                    subject.show()
                }

                it("is the delegate of the image picker") {
                    expect(subject.imagePicker.delegate).to(beIdenticalTo(subject))
                }
                
                describe("adding a new object to the table") {
                    var tableView: InsertionTableView!
                    
                    beforeEach() {
                        tableView = InsertionTableView()
                        subject.tableView = tableView
                        
                        subject.insert(UIImage())
                    }
                    
                    it("adds an object to the view model") {
                        expect(subject.objects).to(haveCount(1))
                    }
                    
                    it("adds an object the start of the table") {
                        expect(tableView.insertedIndexPath) == IndexPath(row: 0, section: 0)
                    }
                }
            }
            
            describe("tapping the add button") {
                beforeEach {
                    subject.addButtonTapped(subject.addButton)
                }
                
                it("opens a gallery browser screen") {
                    expect(subject.imagePicker.allowsEditing) == false
                    expect(subject.imagePicker.sourceType) == UIImagePickerControllerSourceType.photoLibrary
                    expect(subject.imagePicker.isViewLoaded) == true
                }
            }
        }
    }
}

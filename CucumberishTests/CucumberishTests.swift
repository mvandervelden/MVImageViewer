import Foundation
import Cucumberish

class CucumberishTests: NSObject {
    override init() {
        super.init()
        KIFEnableAccessibility()
        loadSteps()
        startTests(for:nil)
    }

    func loadSteps() {
        beforeStart() {
            () -> Void in
            StepDefinitions().setup()
        }
    }

    func startTests(for tags: Array<String>?) {
        let bundle = Bundle(for: CucumberishTests.self)
        Cucumberish.instance().parserFeatures(inDirectory: "Features",
                                              from: bundle,
                                              includeTags: tags,
                                              excludeTags: nil)
        Cucumberish.instance().testTargetFolderName = "CucumberishTests"
        Cucumberish.instance().beginExecution()
    }
}

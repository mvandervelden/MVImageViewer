import KIF
import Cucumberish
import Foundation

extension NSObject: KIFTestActorDelegate {
    public func fail(withExceptions exceptions: [Any]!, stopTest stop: Bool) {
        CCISAssert(false, exceptions.map({($0 as AnyObject).debugDescription}).joined(separator: "\n"))
    }

    public func fail(with exception: NSException!, stopTest stop: Bool) {
        CCISAssert(false, exception.debugDescription)
    }
}

import Foundation

private class NSTimerActor {
    var block: () -> ()

    init(_ block: () -> ()) {
        self.block = block
    }

    @objc func callback() {
        block()
    }
}

extension NSTimer {

    public class func scheduled(ti: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, _ block: () -> Void) {
        NSTimer.scheduledTimerWithTimeInterval(ti, target: NSTimerActor(block), selector: #selector(NSTimerActor.callback), userInfo: userInfo, repeats: repeats)
    }

}
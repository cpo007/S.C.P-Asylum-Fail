import Foundation

private class NSTimerActor {
    var block: () -> ()

    init(_ block: @escaping () -> ()) {
        self.block = block
    }

    @objc func callback() {
        block()
    }
}

extension Timer {

    public class func scheduled(_ ti: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, _ block: @escaping () -> Void) {
        Timer.scheduledTimer(timeInterval: ti, target: NSTimerActor(block), selector: #selector(NSTimerActor.callback), userInfo: userInfo, repeats: repeats)
    }

}

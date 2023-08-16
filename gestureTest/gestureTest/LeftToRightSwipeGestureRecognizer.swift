import UIKit

final class LeftToRightSwipeGestureRecognizer: UIPanGestureRecognizer{
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        guard let view = self.view, self.state == .began else {return}
        
        if velocity(in: view).x.magnitude > velocity(in: view).y.magnitude{
            velocity(in: view).x < 0 ? print("우->좌") :  print("좌->우")
        }else{
            velocity(in: view).y < 0 ? print("하->상") : print("상->하")
        }
        
        guard
            velocity(in: view).x.magnitude > velocity(in: view).y.magnitude,
            velocity(in: view).x > 0 //좌 -> 우 스와이프
        else{
            self.state = .failed
            return
        }
    }
}

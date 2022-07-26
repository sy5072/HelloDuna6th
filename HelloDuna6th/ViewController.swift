//
//  ViewController.swift
//  HelloDuna6th
//
//  Created by Seungyun Kim on 2022/07/25.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var tabView: UIView!
    var animator: UIViewPropertyAnimator?
    var isTapped: Bool = false
    
    // lazy를 통해 선언을 늦게해서 인지시키는 경우도 있음
    // 필요할때만 메모리를 차지해라!! 할때 lazy 를 사용
    lazy var lottieView: AnimationView = {
        let animationView = AnimationView(name: "sample")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        return animationView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAnimator()
        initGesture()
        view.addSubview(lottieView)
        lottieView.play(completion: {  _ in
            print("completion")
        })
        
    }
    
    func initGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(gestureRecognizer:)))
        tabView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapGestureAction(gestureRecognizer: UIGestureRecognizer) {
        isTapped.toggle()
        tabView.backgroundColor = isTapped ? .red : .orange
        
    }
    
    func initAnimator() {
        animator = UIViewPropertyAnimator(duration: 3, curve: .easeInOut) {
            //후행 클로저 todo study
            self.targetView.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 100, height: 100)
        }
        
        animator?.addAnimations {
            self.targetView.backgroundColor = .orange
        }
        
        animator?.addCompletion { position in
//            누가 봐도 확실한 경우에만 $ 사용
//            print($0.rawValue)
            print(position.rawValue)
            print("completion 블록호출")
        }
    }

    @IBAction func touchUpToStartAnimation(_ sender: Any) {
        animator?.startAnimation()
        animator?.addAnimations {
            self.animator?.startAnimation()
        }
    }
    
    @IBAction func touchUpToPauseAnimation(_ sender: Any) {
        animator?.pauseAnimation()
    }
    @IBAction func touchUpToStopAnimation(_ sender: Any) {
        animator?.stopAnimation(true)
        
        // 위와 둘 중 하나만 작성하면 됨
        animator?.stopAnimation(false)
        animator?.finishAnimation(at: .current)
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        print("탭했다")
    }
}


//
//  PanDismissableVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

class BottomModalVC: UIViewController {
    
    var containerView: UIView { UIView() }
    var containerHeight: CGFloat { UIScreen.main.bounds.height / 2 }

    private let containerTopOffset = CGFloat(24)
    private var containerTotalHeight: CGFloat { containerTopOffset + containerHeight + UIView.bottomSafeAreaHeight }

    private lazy var backdropView: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var bottomContainerView: UIView = {
        
        let line = UIView()
        line.backgroundColor = UIColor.Pallete.black.withAlphaComponent(0.1)
        line.layer.cornerRadius = 3
        
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.background
        view.addSubview(containerView)
        [line, containerView].forEach(view.addSubview)
        
        line.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(6)
            $0.width.equalTo(44)
        }
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(containerTopOffset)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(containerHeight)
        }
        return view
    }()
    

    private let interactor = Interactor()
    
    var isPresenting = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)

        view.backgroundColor = .clear
        [backdropView, bottomContainerView].forEach(view.addSubview)
        
        bottomContainerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(containerTotalHeight)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 14)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleGesture(_ sender: UIPanGestureRecognizer) {
        
        let percentThreshold: CGFloat = 0.3
        
        let translation = sender.translation(in: bottomContainerView)
        let verticalMovement = translation.y / containerTotalHeight
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)

        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)

        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()

        default:
            break
        }
    }
    
}

extension BottomModalVC: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactor.hasStarted ? interactor : nil
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        isPresenting.toggle()
        
        if isPresenting == true {
            transitionContext.containerView.addSubview(toVC.view)
            
            bottomContainerView.frame.origin.y += containerTotalHeight
            backdropView.alpha = 0
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    self.bottomContainerView.frame.origin.y -= self.containerTotalHeight
                    self.backdropView.alpha = 1
                },
                completion: { (finished) in
                    transitionContext.completeTransition(true)
                }
            )
        } else {
            
            let showedY = self.bottomContainerView.frame.origin.y
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    self.bottomContainerView.frame.origin.y += self.containerTotalHeight
                    self.backdropView.alpha = 0
                },
                completion: { (finished) in
                    if transitionContext.transitionWasCancelled {
                        transitionContext.completeTransition(false)

                        self.bottomContainerView.frame.origin.y = showedY
                        self.backdropView.alpha = 1
                        self.isPresenting = true
                        
                    } else {
                        transitionContext.completeTransition(true)
                    }
                }
            )
        }
    }
}


class Interactor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}


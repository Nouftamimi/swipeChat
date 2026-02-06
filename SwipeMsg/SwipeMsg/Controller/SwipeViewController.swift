//
//  SwipeViewController.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 05/02/2026.
//
import UIKit
import SwiftUI

final class SwipeViewController<Content: View>: UIViewController {

    let direction: SwipeDirection
    let screenWidth: CGFloat
    let threshold: CGFloat

    var onPan: ((CGFloat, UIGestureRecognizer.State) -> Void)?
    var onCommit: (() -> Void)?

    var hostingController: UIHostingController<Content>?

    init(
        direction: SwipeDirection,
        screenWidth: CGFloat,
        threshold: CGFloat = 0.3
    ) {
        self.direction = direction
        self.screenWidth = screenWidth
        self.threshold = threshold
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        let pan = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)
        )
        view.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let rawX = translation.x * direction.sign
        let clampedX = max(0, rawX)
        let progress = min(1, clampedX / screenWidth)

        onPan?(progress, gesture.state)

        if gesture.state == .ended || gesture.state == .cancelled {
            if progress > threshold {
                onCommit?()
            }
        }
    }
}



struct SwipeContainer<Content: View>: UIViewControllerRepresentable {

    let content: Content
    let direction: SwipeDirection
    let screenWidth: CGFloat
    @Binding var offsetX: CGFloat
    let onCommit: (() -> Void)?

    func makeUIViewController(context: Context) -> SwipeViewController<Content> {

        let vc = SwipeViewController<Content>(
            direction: direction,
            screenWidth: screenWidth
        )

        let hosting = UIHostingController(rootView: content)
        hosting.view.backgroundColor = .clear
        hosting.view.frame = vc.view.bounds
        hosting.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        vc.setNeedsUpdateOfHomeIndicatorAutoHidden()
        vc.hostingController = hosting
        vc.addChild(hosting)
        vc.view.addSubview(hosting.view)
        hosting.didMove(toParent: vc)

        vc.onPan = { progress, state in
            DispatchQueue.main.async {
                switch state {
                case .changed:
                    offsetX = direction == .rightToLeft
                        ? -progress * screenWidth
                        : -screenWidth + progress * screenWidth

                case .ended, .cancelled:
                    let shouldCommit = progress > 0.3
                    withAnimation(.interactiveSpring()) {
                        offsetX = shouldCommit
                            ? (direction == .rightToLeft ? -screenWidth : 0)
                            : (direction == .rightToLeft ? 0 : -screenWidth)
                    }
                default:
                    break
                }
            }
        }

        vc.onCommit = onCommit
        return vc
    }

    func updateUIViewController(
        _ uiViewController: SwipeViewController<Content>,
        context: Context
    ) {
        uiViewController.hostingController?.rootView = content
    }
}

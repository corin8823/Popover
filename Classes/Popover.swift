//
//  Popover.swift
//  Popover
//
//  Created by corin8823 on 8/16/15.
//  Copyright (c) 2015 corin8823. All rights reserved.
//  Swift 3 translation by Martin on 6/27/16
//

import UIKit

public enum PopoverOption {
  case ArrowSize(CGSize)
  case AnimationIn(TimeInterval)
  case AnimationOut(TimeInterval)
  case CornerRadius(CGFloat)
  case SideEdge(CGFloat)
  case BlackOverlayColor(UIColor)
  case OverlayBlur(UIBlurEffectStyle)
  case PtType(PopoverType)
  case Color(UIColor)
}

@objc public enum PopoverType: Int {
    case Up
    case Down
}

public class Popover: UIView {

  // custom property
  public var arrowSize: CGSize = CGSize(width: 16.0, height: 10.0)
  public var animationIn: TimeInterval = 0.6
  public var animationOut: TimeInterval = 0.3
  public var cornerRadius: CGFloat = 6.0
  public var sideEdge: CGFloat = 20.0
  public var popoverType: PopoverType = .Down
  public var blackOverlayColor: UIColor = UIColor(white: 0.0, alpha: 0.2)
  public var overlayBlur: UIBlurEffect?
  public var popoverColor: UIColor = UIColor.white()

  // custom closure
  private var didShowHandler: (() -> ())?
  private var didDismissHandler: (() -> ())?

  private var blackOverlay: UIControl = UIControl()
  private var containerView: UIView!
  private var contentView: UIView!
  private var contentViewFrame: CGRect!
  private var arrowShowPoint: CGPoint!

  public init() {
    super.init(frame: CGRect.zero)
    self.backgroundColor = UIColor.clear()
  }

  public init(showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
    super.init(frame: CGRect.zero)
    self.backgroundColor = UIColor.clear()
    self.didShowHandler = showHandler
    self.didDismissHandler = dismissHandler
  }

  public init(options: [PopoverOption]?, showHandler: (() -> ())? = nil, dismissHandler: (() -> ())? = nil) {
    super.init(frame: CGRect.zero)
    self.backgroundColor = UIColor.clear()
    self.setOptions(options: options)
    self.didShowHandler = showHandler
    self.didDismissHandler = dismissHandler
  }

  private func setOptions(options: [PopoverOption]?){
    if let options = options {
      for option in options {
        switch option {
        case let .ArrowSize(value):
          self.arrowSize = value
        case let .AnimationIn(value):
          self.animationIn = value
        case let .AnimationOut(value):
          self.animationOut = value
        case let .CornerRadius(value):
          self.cornerRadius = value
        case let .SideEdge(value):
          self.sideEdge = value
        case let .BlackOverlayColor(value):
          self.blackOverlayColor = value
        case let .OverlayBlur(style):
          self.overlayBlur = UIBlurEffect(style: style)
        case let .PtType(value):
          self.popoverType = value
        case let .Color(value):
          self.popoverColor = value
        }
      }
    }
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func create() {
    var frame = self.contentView.frame
    frame.origin.x = self.arrowShowPoint.x - frame.size.width * 0.5

    var sideEdge: CGFloat = 0.0
    if frame.size.width < self.containerView.frame.size.width {
      sideEdge = self.sideEdge
    }

    let outerSideEdge = frame.maxX - self.containerView.bounds.size.width
    if outerSideEdge > 0 {
      frame.origin.x -= (outerSideEdge + sideEdge)
    } else {
      if frame.minX < 0 {
        frame.origin.x += abs(frame.minX) + sideEdge
      }
    }
    self.frame = frame

    let arrowPoint = self.containerView.convert(self.arrowShowPoint, to: self)
    let anchorPoint: CGPoint
    switch self.popoverType {
    case .Up:
      frame.origin.y = self.arrowShowPoint.y - frame.height - self.arrowSize.height
      anchorPoint = CGPoint(x: arrowPoint.x / frame.size.width, y: 1)
    case .Down:
      frame.origin.y = self.arrowShowPoint.y
      anchorPoint = CGPoint(x: arrowPoint.x / frame.size.width, y: 0)
    }

    let lastAnchor = self.layer.anchorPoint
    self.layer.anchorPoint = anchorPoint
    let x = self.layer.position.x + (anchorPoint.x - lastAnchor.x) * self.layer.bounds.size.width
    let y = self.layer.position.y + (anchorPoint.y - lastAnchor.y) * self.layer.bounds.size.height
    self.layer.position = CGPoint(x: x, y: y)

    frame.size.height += self.arrowSize.height
    self.frame = frame
  }

  public func show(contentView: UIView, fromView: UIView) {
    self.show(contentView, fromView: fromView, inView: UIApplication.shared().keyWindow!)
  }

  public func show(_ contentView: UIView, fromView: UIView, inView: UIView) {
    let point: CGPoint
    switch self.popoverType {
    case .Up:
        point = inView.convert(CGPoint(x: fromView.frame.origin.x + (fromView.frame.size.width / 2), y: fromView.frame.origin.y), from: fromView.superview)
    case .Down:
        point = inView.convert(CGPoint(x: fromView.frame.origin.x + (fromView.frame.size.width / 2), y: fromView.frame.origin.y + fromView.frame.size.height), from: fromView.superview)
    }
    self.show(contentView, point: point, inView: inView)
  }

  public func show(contentView: UIView, point: CGPoint) {
    self.show(contentView, point: point, inView: UIApplication.shared().keyWindow!)
  }

  public func show(_ contentView: UIView, point: CGPoint, inView: UIView) {
    self.blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.blackOverlay.frame = inView.bounds

    if let overlayBlur = self.overlayBlur {
      let effectView = UIVisualEffectView(effect: overlayBlur)
      effectView.frame = self.blackOverlay.bounds
      effectView.isUserInteractionEnabled = false
      self.blackOverlay.addSubview(effectView)
    } else {
      self.blackOverlay.backgroundColor = self.blackOverlayColor
      self.blackOverlay.alpha = 0
    }

    inView.addSubview(self.blackOverlay)
    self.blackOverlay.addTarget(self, action: #selector(Popover.dismiss), for: .touchUpInside)

    self.containerView = inView
    self.contentView = contentView
    self.contentView.backgroundColor = UIColor.clear()
    self.contentView.layer.cornerRadius = self.cornerRadius
    self.contentView.layer.masksToBounds = true
    self.arrowShowPoint = point
    self.show()
  }

  private func show() {
    self.setNeedsDisplay()
    switch self.popoverType {
    case .Up:
      self.contentView.frame.origin.y = 0.0
    case .Down:
      self.contentView.frame.origin.y = self.arrowSize.height
    }
    self.addSubview(self.contentView)
    self.containerView.addSubview(self)

    self.create()
    self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    UIView.animate(withDuration: self.animationIn, delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 3,
      options: UIViewAnimationOptions.curveEaseIn,
      animations: {
        self.transform = CGAffineTransform.identity
      }){ _ in
        self.didShowHandler?()
    }
    UIView.animate(withDuration: self.animationIn / 3,
      delay: 0,
      options: .curveLinear,
      animations: { _ in
        self.blackOverlay.alpha = 1
      }, completion: { _ in
    })
  }

  public func dismiss() {
    if self.superview != nil {
      UIView.animate(withDuration: self.animationOut, delay: 0,
        options: UIViewAnimationOptions.curveEaseOut,
        animations: {
          self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
          self.blackOverlay.alpha = 0
        }){ _ in
          self.contentView.removeFromSuperview()
          self.blackOverlay.removeFromSuperview()
          self.removeFromSuperview()
          self.didDismissHandler?()
      }
    }
  }

  override public func draw(_ rect: CGRect) {
    super.draw(rect)
    let arrow = UIBezierPath()
    let color = self.popoverColor
    let arrowPoint = self.containerView.convert(self.arrowShowPoint, to: self)
    switch self.popoverType {
    case .Up:
      arrow.move(to: CGPoint(x: arrowPoint.x, y: self.bounds.height))
      arrow.addLine(
        to: CGPoint(
          x: arrowPoint.x - self.arrowSize.width * 0.5,
          y: isCornerLeftArrow() ? self.arrowSize.height : self.bounds.height - self.arrowSize.height
        )
      )

      arrow.addLine(to: CGPoint(x: self.cornerRadius, y: self.bounds.height - self.arrowSize.height))
      arrow.addArc(
        withCenter: CGPoint(
          x: self.cornerRadius,
          y: self.bounds.height - self.arrowSize.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 90),
        endAngle: self.radians(degrees: 180),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: 0, y: self.cornerRadius))
      arrow.addArc(
        withCenter: CGPoint(
          x: self.cornerRadius,
          y: self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 180),
        endAngle: self.radians(degrees: 270),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: self.bounds.width - self.cornerRadius, y: 0))
      arrow.addArc(
        withCenter: CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 270),
        endAngle: self.radians(degrees: 0),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - self.arrowSize.height - self.cornerRadius))
      arrow.addArc(
        withCenter: CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.bounds.height - self.arrowSize.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 0),
        endAngle: self.radians(degrees: 90),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: arrowPoint.x + self.arrowSize.width * 0.5,
        y: isCornerRightArrow() ? self.arrowSize.height : self.bounds.height - self.arrowSize.height))

    case .Down:
      arrow.move(to: CGPoint(x: arrowPoint.x, y: 0))
      arrow.addLine(
        to: CGPoint(
          x: arrowPoint.x + self.arrowSize.width * 0.5,
          y: isCornerRightArrow() ? self.arrowSize.height + self.bounds.height : self.arrowSize.height
        ))

      arrow.addLine(to: CGPoint(x: self.bounds.width - self.cornerRadius, y: self.arrowSize.height))
      arrow.addArc(
        withCenter: CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.arrowSize.height + self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 270.0),
        endAngle: self.radians(degrees: 0),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - self.cornerRadius))
      arrow.addArc(
        withCenter: CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.bounds.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 0),
        endAngle: self.radians(degrees: 90),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: 0, y: self.bounds.height))
      arrow.addArc(
        withCenter: CGPoint(
          x: self.cornerRadius,
          y: self.bounds.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 90),
        endAngle: self.radians(degrees: 180),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: 0, y: self.arrowSize.height + self.cornerRadius))
      arrow.addArc(
        withCenter: CGPoint(x: self.cornerRadius,
          y: self.arrowSize.height + self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(degrees: 180),
        endAngle: self.radians(degrees: 270),
        clockwise: true)

      arrow.addLine(to: CGPoint(x: arrowPoint.x - self.arrowSize.width * 0.5,
        y: isCornerLeftArrow() ? self.arrowSize.height + self.bounds.height : self.arrowSize.height))
    }

    color.setFill()
    arrow.fill()
  }

  private func isCornerLeftArrow() -> Bool {
    return self.arrowShowPoint.x == self.frame.origin.x
  }

  private func isCornerRightArrow() -> Bool {
    return self.arrowShowPoint.x == self.frame.origin.x + self.bounds.width
  }

  private func radians(degrees: CGFloat) -> CGFloat {
    return (CGFloat(M_PI) * degrees / 180)
  }
}

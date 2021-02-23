//
//  UIView.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit.UIView

private enum UIViewAssociatedKeys {
    static var onTapCallback: UInt8 = 1
}

extension UIView {
    /// Tap gesture closure
    var onTap: (() -> Void)? {
        get {
            guard let callbackWrapper = objc_getAssociatedObject(self, &UIViewAssociatedKeys.onTapCallback) as? CallbackWrapper else { return nil }
            return callbackWrapper.callback
        }
        set {
            guard let newValue = newValue else { return }
            let callbackWrapper = CallbackWrapper(callback: newValue)
            addGestureRecognizer(UITapGestureRecognizer(target: callbackWrapper, action: #selector(CallbackWrapper.callCallback)))
            objc_setAssociatedObject(self, &UIViewAssociatedKeys.onTapCallback, callbackWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Adds a views to the end of the receiver's list of subviews.
    ///
    /// - Parameter views: Array of views to be added.
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

typealias Constraint = (_ layoutView: UIView) -> NSLayoutConstraint

//
// Solution based on http://chris.eidhof.nl/post/micro-autolayout-dsl/
//
extension UIView {
    /// Adds constraints using NSLayoutAnchors, based on description provided in params.
    /// Please refer to helper equal funtions for info how to generate constraints easily.
    ///
    /// - Parameter constraintDescriptions: constrains array
    /// - Returns: created constraints
    @discardableResult func addConstraints(_ constraintDescriptions: [Constraint]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = constraintDescriptions.map { $0(self) }
        constraints.forEach {
            $0.priority = UILayoutPriority(rawValue: 999)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    func constraint(withIdentifier: String) -> NSLayoutConstraint? {
        constraints.filter { $0.identifier == withIdentifier }.first
    }
}

/// Describes constraint that is equal to constraint from different view.
/// Example: `equal(superView, \.centerXAnchor) will align view centerXAnchor to superview centerXAnchor`
///
/// - Parameters:
///   - view: that constrain should relate to
///   - to: constraints key path
/// - Returns: created constraint
func equal<Anchor, Axis>(_ view: UIView, _ to: KeyPath<UIView, Anchor>) -> Constraint where Anchor: NSLayoutAnchor<Axis> { { layoutView in
        layoutView[keyPath: to].constraint(equalTo: view[keyPath: to])
    }
}

/// Describes constraint that will be equal to constant
/// Example: `equal(\.heightAnchor, to: 36) will create height constraint with value 36`
///
/// - Parameters:
///   - keyPath: constraint key path
///   - constant: value
/// - Returns: created constraint
func equal<LayoutDimension>(_ keyPath: KeyPath<UIView, LayoutDimension>, to constant: CGFloat, identifier: String? = nil) -> Constraint where LayoutDimension: NSLayoutDimension { { layoutView in
        let constraint = layoutView[keyPath: keyPath].constraint(equalToConstant: constant)
        constraint.identifier = identifier
        return constraint
    }
}

/// Describes constraint that will be greater or equal to constant
/// Example: `equal(\.heightAnchor, greaterOrEqual: 36) will create height constraint with value 36`
///
/// - Parameters:
///   - keyPath: constraint key path
///   - greaterOrEqual: value
/// - Returns: created constraint
func equal<LayoutDimension>(_ keyPath: KeyPath<UIView, LayoutDimension>, greaterOrEqual: CGFloat = 0, identifier: String? = nil) -> Constraint where LayoutDimension: NSLayoutDimension { { layoutView in
        let constraint = layoutView[keyPath: keyPath].constraint(greaterThanOrEqualToConstant: greaterOrEqual)
        constraint.identifier = identifier
        return constraint
    }
}

/// Describes relation between constraints of two views
/// Example: `equal(mapPlaceholder, \.heightAnchor, to: \.widthAnchor, constant: 0.0, multiplier: 0.7) will create height constraint equal to width with multiplier value 0.7`
///
/// - Parameters:
///   - keyPath: constraint key path
///   - from: constraint key path of current view
///   - to: constraint key path of related view
///   - constant: offset value
///   - multiplier: value
/// - Returns: created constraint
func equal<LayoutDimension>(_ view: UIView, _ from: KeyPath<UIView, LayoutDimension>, to: KeyPath<UIView, LayoutDimension>, constant: CGFloat = 0, multiplier: CGFloat = 1, identifier: String? = nil) -> Constraint where LayoutDimension: NSLayoutDimension { { layoutView in
        let constraint = layoutView[keyPath: from].constraint(equalTo: view[keyPath: to], multiplier: multiplier, constant: constant)
        constraint.identifier = identifier
        return constraint
    }
}

/// Describes relation between constraints of two views
/// Example: `equal(logoImageView, \.topAnchor, \.bottomAnchor, constant: 80)`
/// will create constraint where topAnchor of current view is linked to bottomAnchor of passed view with offset 80
///
/// - Parameters:
///   - view: view that constraint is related from
///   - from: constraint key path of current view
///   - to: constraint key path of related view
///   - constant: value
/// - Returns: created constraint
func equal<Anchor, Axis>(_ view: UIView, _ from: KeyPath<UIView, Anchor>, _ to: KeyPath<UIView, Anchor>, constant: CGFloat = 0, identifier: String? = nil) -> Constraint where Anchor: NSLayoutAnchor<Axis> { { layoutView in
        let constraint = layoutView[keyPath: from].constraint(equalTo: view[keyPath: to], constant: constant)
        constraint.identifier = identifier
        return constraint
    }
}

/// Describes relation between constraints of two views
/// Example: `equal(logoImageView, \.topAnchor, \.bottomAnchor, constant: 80)`
/// will create constraint where topAnchor of current view is linked to bottomAnchor of passed view with offset less or equal 80
///
/// - Parameters:
///   - view: view that constraint is related from
///   - from: constraint key path of current view
///   - to: constraint key path of related view
///   - constant: value
/// - Returns: created constraint
func equal<Anchor, Axis>(_ view: UIView, _ from: KeyPath<UIView, Anchor>, _ to: KeyPath<UIView, Anchor>, lessOrEqual: CGFloat = 0, identifier: String? = nil) -> Constraint where Anchor: NSLayoutAnchor<Axis> { { layoutView in
        let constraint = layoutView[keyPath: from].constraint(lessThanOrEqualTo: view[keyPath: to], constant: lessOrEqual)
        constraint.identifier = identifier
        return constraint
    }
}

/// Describes relation between constraints of two views
/// Example: `equal(logoImageView, \.topAnchor, \.bottomAnchor, constant: 80)`
/// will create constraint where topAnchor of current view is linked to bottomAnchor of passed view with offest greater or equal to 80
///
/// - Parameters:
///   - view: view that constraint is related from
///   - from: constraint key path of current view
///   - to: constraint key path of related view
///   - constant: value
/// - Returns: created constraint
func equal<Anchor, Axis>(_ view: UIView, _ from: KeyPath<UIView, Anchor>, _ to: KeyPath<UIView, Anchor>, greaterOrEqual: CGFloat = 0, identifier: String? = nil) -> Constraint where Anchor: NSLayoutAnchor<Axis> { { layoutView in
        let constraint = layoutView[keyPath: from].constraint(greaterThanOrEqualTo: view[keyPath: to], constant: greaterOrEqual)
        constraint.identifier = identifier
        return constraint
    }
}

/// Describes constraints from diffrent views where anchors should match with passed offset
/// Example: `equal(self, \.bottomAnchor, constant: -37)` will align bottomAnchors of current and passed view with offset -37
///
/// - Parameters:
///   - view: view that constraint is related from
///   - keyPath: constraint key path
///   - constant: value
/// - Returns: created constraint
func equal<Axis, Anchor>(_ view: UIView, _ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    equal(view, keyPath, keyPath, constant: constant)
}

/// Describes array of constraints that will pin view to its superview.
/// If invoked on iOS 11, this method will pin top and bottom view edges to `safeAreaLayoutGuide`!
/// Example `view.addConstraints(equalToSuperview())`
///
/// - Parameter insets: Optional insets parameter. By default it's set to .zero.
/// - Returns: Array of `Constraint`.
/// - Warning: This method uses force-unwrap on view's superview!
/// - Warning: Pins top and bottom edges to `safeAreaLayoutGuide`!
func equalToSuperview(with insets: UIEdgeInsets = .zero, usingSafeArea: Bool = true) -> [Constraint] {
    let top: Constraint
    let bottom: Constraint
    if #available(iOS 11, *), usingSafeArea {
        top = { layoutView in
            layoutView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: layoutView.superview!.safeAreaLayoutGuide.topAnchor, constant: insets.top)
        }

        bottom = { layoutView in
            layoutView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: layoutView.superview!.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
        }
    } else {
        top = { layoutView in
            layoutView.topAnchor.constraint(equalTo: layoutView.superview!.topAnchor, constant: insets.top)
        }

        bottom = { layoutView in
            layoutView.bottomAnchor.constraint(equalTo: layoutView.superview!.bottomAnchor, constant: insets.bottom)
        }
    }

    let leading: Constraint = { layoutView in
        layoutView.leadingAnchor.constraint(equalTo: layoutView.superview!.leadingAnchor, constant: insets.left)
    }

    let trailing: Constraint = { layoutView in
        layoutView.trailingAnchor.constraint(equalTo: layoutView.superview!.trailingAnchor, constant: insets.right)
    }

    return [leading, top, trailing, bottom]
}

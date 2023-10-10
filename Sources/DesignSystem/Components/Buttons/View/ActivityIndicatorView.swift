import UIKit
import SnapKit

class ActivityIndicatorView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let activityImage: UIImage = .ic24SpinnerLoader
        static let kRotationAnimationKey = "bankok.RotationAnimation"
        static let animationDuration: CGFloat = 0.3
    }
    
    // MARK: - Properties
    
    private(set) var isAnimating = false
    private var indicatorView: UIImageView?
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitActivityIndicator(image: Constants.activityImage)
    }

    convenience init() {
        let activityImage = Constants.activityImage
        self.init(frame: CGRect(x: 0.0,
                                y: 0.0,
                                width: activityImage.size.width,
                                height: activityImage.size.height))
    }

    init(image: UIImage) {
        super.init(frame: .zero)
        commonInitActivityIndicator(image: image)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()

        indicatorView?.frame = CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: self.bounds.height)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if isAnimating {
            startAnimating()
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil && isAnimating {
            startAnimating()
        }
    }
    
    // MARK: - Private Methods

    private func commonInitActivityIndicator(image: UIImage) {
        indicatorView = UIImageView(image: image)

        indicatorView?.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin
        ]

        indicatorView?.center = CGPoint(
            x: bounds.midX,
            y: bounds.midY)

        if let indicatorView = indicatorView {
            addSubview(indicatorView)
        }
    }
    
    private func runSpinAnimation(
        on view: UIView?,
        duration: CGFloat,
        rotations: CGFloat,
        repeat: Bool
    ) {
        var rotationAnimation: CABasicAnimation?
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation?.toValue = .pi * 2.0 * rotations * duration
        rotationAnimation?.duration = CFTimeInterval(duration)
        rotationAnimation?.isCumulative = true
        rotationAnimation?.repeatCount = `repeat` ? .greatestFiniteMagnitude : 0
        
        if let rotationAnimation = rotationAnimation {
            view?.layer.add(rotationAnimation, forKey: Constants.kRotationAnimationKey)
        }
    }
    
    // MARK: - Public Methods

    func startAnimating() {
        runSpinAnimation(
            on: indicatorView,
            duration: Constants.animationDuration,
            rotations: 1,
            repeat: true)
        isAnimating = true
    }
    
    func stopAnimating() {
        indicatorView?.layer.removeAnimation(forKey: Constants.kRotationAnimationKey)
        isAnimating = false
    }
}

import UIKit
import SnapKit
import Components
import ImagesService

private class ImageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let vStack = vStack()
        
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .icon24(.ic24Bill),
                    color: .primary)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .letters("AB".attributed),
                    color: .primary)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .image(.ic24Euro.withTintColor(.contentInfo).centered(in: .circle(backgroundColor: .backgroundInfoLight, diameter: 40))),
                    color: .primary)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            return hStack
        }())
        
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .icon24(.ic24Ban),
                    color: .main)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .letters("CD".attributed),
                    color: .main)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            return hStack
        }())
        
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .icon24(.ic24Globe),
                    color: .mainInverse)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .letters("EF".attributed),
                    color: .mainInverse)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            return hStack
        }())
        
        for color in [ImageVariables.Color.additional1, .additional2, .additional3, .additional4, .additional5, .additional6, .additional7, .additional8] {
            
            vStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    variant: .icon24(.ic24Bill),
                    color: color)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
        }
        
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func vStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }
    
    private func hStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }
}

import UIKit
import SnapKit
import Components
import ImagesService
import Colors

private class TileVC: UIViewController {
    
    private let tileView = TileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let vStack = vStack()
        
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(
                size: .sizeL,
                style: .action)
            var viewProperties = TileView.ViewProperties(
                icon: style.centeredIcon(.ic24Book.tinted(with: .contentPrimaryInverse)),
                text: .init(string: "Example"),
                action: { print("Example") })
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(
                size: .sizeL,
                style: .main)
            var viewProperties = TileView.ViewProperties(
                icon: style.styledCenteredIcon(.ic24Car),
                text: .init(string: "Example"),
                action: { print("Example") })
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(
                size: .sizeL,
                style: .primary)
            var viewProperties = TileView.ViewProperties(
                icon: style.styledCenteredIcon(.ic24Call),
                text: .init(string: "Example"),
                action: { print("Example") })
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
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
}

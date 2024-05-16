import UIKit
import SnapKit
import Components

private class RowExampleVC: UIViewController {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStackView()
        createRows()
    }
    
    private func addStackView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func createRows() {
        let row1 = createTitleRow()
        let row2 = createImageWithTitleRow()
        let row3 = createImageWithTitleSubtitleRow()
        let row4 = createImageWithButtonRow()
        let row5 = createImageWithToggleRow()
        let row6 = createImageWithCheckboxRow()
        let row7 = createImageWithIndexRow()
        let row8 = createImageWithIndexIcons20Row()
        
        let row = createWithRowsService()

        stackView.addArrangedSubview(row1)
        stackView.addArrangedSubview(row2)
        stackView.addArrangedSubview(row3)
        stackView.addArrangedSubview(row4)
        stackView.addArrangedSubview(row5)
        stackView.addArrangedSubview(row6)
        stackView.addArrangedSubview(row7)
        stackView.addArrangedSubview(row8)
        
        stackView.addArrangedSubview(row)
    }
    
    private func createTitleRow() -> UIView {
        let titleStyle = LabelViewStyle(variant: .title)
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.title("Title", titleStyle))
        )
    }
    
    private func createImageWithTitleRow() -> UIView {
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .atom(.title("Title", nil))
        )
    }
    
    private func createImageWithTitleSubtitleRow() -> UIView {
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.titleWithSubtitle(("Title", nil), ("Subtitle", nil)))
        )
    }
    
    private func createImageWithButtonRow() -> UIView {
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil))),
            trailing: .atom(.button("Label", { }, nil))
        )
    }
    
    private func createImageWithToggleRow() -> UIView {
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil))),
            trailing: .atom(.toggle(true, { _ in }, nil))
        )
    }
    
    private func createImageWithCheckboxRow() -> UIView {
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil))),
            trailing: .atom(.checkbox(true, { }, nil))
        )
    }
    
    private func createImageWithIndexRow() -> UIView {
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil))),
            trailing: .molecule(.indexWithcIcon24(("Index", nil), (.ic24ChevronSmallRight, nil)))
        )
    }
    
    private func createImageWithIndexIcons20Row() -> UIView {
        return DSCreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil))),
            trailing: .molecule(.indexWithIcons20(("Index", nil), [(.ic24BoxFilled, nil), (.ic24BoxFilled, nil)]))
        )
    }
    
    // пример с ручной настройкой
    private func createWithRowsService() -> UIView {
        var radioViewProperties = RadioView.ViewProperties()
        let radioViewStyle = RadioViewStyle(
            size: .large,
            action: .on,
            state: .default
        )
        radioViewStyle.update(viewProperties: &radioViewProperties)
        
        var titleViewProperties = LabelView.ViewProperties(text: "Title".attributed)
        let titleViewStyle = LabelViewStyle(variant: .title)
        titleViewStyle.update(viewProperties: &titleViewProperties)
        
        
        var buttonViewProperties = ButtonView.ViewProperties()
        buttonViewProperties.attributedText = "Button".attributed
        let buttonViewStyle = ButtonViewStyle(
            context: .action(.ghost),
            state: .default,
            size: .sizeM
        )
        buttonViewStyle.update(viewProperties: &buttonViewProperties)
        
        let row = CreationRowsViewService.createViewRowWithBloks(
            leading: .atom(.radio(radioViewProperties)),
            center: .atom(.title(titleViewProperties)),
            trailing: .atom(.button(buttonViewProperties))
        )
        return row
    }
}

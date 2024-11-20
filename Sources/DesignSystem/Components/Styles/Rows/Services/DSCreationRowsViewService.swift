import UIKit
import Components
import AccessibilityIds

public struct DSCreationRowsViewService {
    public init() { }
    
    public func createCellRowWithBlocks(
        tableView: UITableView,
        indexPath: IndexPath,
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil,
        centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment = .leading,
        verticalAlignment: RowBaseContainer.ViewProperties.VerticalAlignment = .center,
        cellIdentifier: String = "RowCell",
        cellSelectionStyle: UITableViewCell.SelectionStyle = .gray
    ) -> UITableViewCell {
        // Проверяем, зарегистрирована ли ячейк а
        if tableView.dequeueReusableCell(withIdentifier: cellIdentifier) == nil {
            tableView.register(RowCell.self, forCellReuseIdentifier: cellIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RowCell
        cell?.selectionStyle = cellSelectionStyle
        cell?.accessibilityIdentifier = DesignSystemAccessibilityIDs.RowView.rowCell + "\(indexPath)"
        
        let rowView = createViewRowWithBlocks(
            leading: leading,
            center: center,
            trailing: trailing,
            centralBlockAlignment: centralBlockAlignment,
            verticalAlignment: verticalAlignment
        )
        
        cell?.customView = rowView
        
        return cell ?? UITableViewCell()
    }
    
    public func createViewRowWithBlocks(
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil,
        centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment = .leading,
        verticalAlignment: RowBaseContainer.ViewProperties.VerticalAlignment = .center,
        margins: RowBaseContainer.ViewProperties.Margins? = nil
    ) -> UIView {
        let container = RowBaseContainer()
        container.backgroundColor = .clear
        
        let newMargins = margins ?? RowBaseContainer.ViewProperties.Margins(
            leading: 16,
            trailing: 16,
            top: 14,
            bottom: 14,
            spacing: 16
        )
        
        let leadingView = DSRowBlocksService().createRowBlock(leading)
        leadingView?.isOpaque = true
        leadingView?.isAccessibilityElement = true
        leadingView?.accessibilityIdentifier = "\(String(describing: leadingView?.accessibilityIdentifier ?? ""))_leading_block"
        let centerView = DSRowBlocksService().createRowBlock(center)
        centerView?.isOpaque = true
        centerView?.isAccessibilityElement = true
        centerView?.accessibilityIdentifier = "\(String(describing: centerView?.accessibilityIdentifier ?? ""))_center_block"
        let trailingView = DSRowBlocksService().createRowBlock(trailing)
        trailingView?.isOpaque = true
        trailingView?.isAccessibilityElement = true
        trailingView?.accessibilityIdentifier = "\(String(describing: trailingView?.accessibilityIdentifier ?? ""))_trailing_block"
        
        let containerViewProperty = RowBaseContainer.ViewProperties(
            leadingView: leadingView,
            centerView: centerView,
            trailingView: trailingView,
            centralBlockAlignment: centralBlockAlignment,
            verticalAlignment: verticalAlignment,
            margins: newMargins,
            accessibilityIds: .init(
                id: DesignSystemAccessibilityIDs.RowView.rowCellContainer
            )
        )
        
        container.update(with: containerViewProperty)
        
        return container
    }
}

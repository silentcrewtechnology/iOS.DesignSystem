import UIKit
import Components

public struct DSCreationRowsViewService {
    public init() { }
    
    public func createCellRowWithBlocks(
        tableView: UITableView,
        indexPath: IndexPath,
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil,
        centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment = .leading,
        cellIdentifier: String = "RowCell"
    ) -> UITableViewCell {
        // Проверяем, зарегистрирована ли ячейка
        if tableView.dequeueReusableCell(withIdentifier: cellIdentifier) == nil {
            tableView.register(RowCell.self, forCellReuseIdentifier: cellIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RowCell
        
        let rowView = createViewRowWithBlocks(leading: leading,
                                              center: center,
                                              trailing: trailing,
                                              centralBlockAlignment: centralBlockAlignment)
        
        cell?.customView = rowView
        
        return cell ?? UITableViewCell()
    }
    
    public func createViewRowWithBlocks(
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil,
        centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment = .leading,
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
        let centerView = DSRowBlocksService().createRowBlock(center)
        centerView?.isOpaque = true
        let trailingView = DSRowBlocksService().createRowBlock(trailing)
        trailingView?.isOpaque = true
        
        let containerViewProperty = RowBaseContainer.ViewProperties(
            leadingView: leadingView,
            centerView: centerView,
            trailingView: trailingView,
            centralBlockAlignment: centralBlockAlignment,
            margins: newMargins)
        
        container.update(with: containerViewProperty)
        
        return container
    }
}

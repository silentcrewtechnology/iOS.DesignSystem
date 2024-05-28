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
        cellIdentifier: String = "RowCell"
    ) -> UITableViewCell {
        // Проверяем, зарегистрирована ли ячейка
        if tableView.dequeueReusableCell(withIdentifier: cellIdentifier) == nil {
            tableView.register(RowCell.self, forCellReuseIdentifier: cellIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RowCell
        
        let rowView = createViewRowWithBlocks(leading: leading,
                                              center: center,
                                              trailing: trailing)
        
        cell?.customView = rowView
        
        return cell ?? UITableViewCell()
    }
    
    public func createViewRowWithBlocks(
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil,
        margins: RowBaseContainer.ViewProperties.Margins? = nil,
        viewsHeight: CGFloat = 44
    ) -> UIView {
        let container = RowBaseContainer()
        
        let newMargins = margins ?? RowBaseContainer.ViewProperties.Margins(
            leading: 16,
            trailing: 16,
            top: 14,
            bottom: 14,
            spacing: 16
        )
        
        let leadingView = DSRowBlocksService().createRowBlock(leading)
        let centerView = DSRowBlocksService().createRowBlock(center)
        let trailingView = DSRowBlocksService().createRowBlock(trailing)
        
        let containerViewProperty = RowBaseContainer.ViewProperties(
            leadingView: leadingView,
            centerView: centerView,
            trailingView: trailingView,
            viewsHeight: viewsHeight,
            margins: newMargins)
        
        container.update(with: containerViewProperty)
        
        return container
    }
}

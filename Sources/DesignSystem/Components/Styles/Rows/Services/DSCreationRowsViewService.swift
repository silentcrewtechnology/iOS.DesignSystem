import UIKit
import Components

public struct DSCreationRowsViewService {
    public static func createCellRowWithBloks(
        tableView: UITableView,
        indexPath: IndexPath,
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DSRowCell", for: indexPath) as? RowCell
        
        let rowView = createViewRowWithBloks(leading: leading,
                                             center: center,
                                             trailing: trailing)
        
        cell?.customView = rowView
        
        return cell ?? UITableViewCell()
    }
    
    public static func createViewRowWithBloks(
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
        
        let leadingView = DSRowBlocksService.createRowBlock(leading)
        let centerView = DSRowBlocksService.createRowBlock(center)
        let trailingView = DSRowBlocksService.createRowBlock(trailing)
        
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

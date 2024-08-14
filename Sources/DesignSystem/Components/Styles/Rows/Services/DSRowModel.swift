import Components
import UIKit

final public class DSRowModel {
    public let leading: DSRowBlocks?
    public let center: DSRowBlocks?
    public let trailing: DSRowBlocks?
    public let centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment
    public let cellIdentifier: String
    public let cellSelectionStyle: UITableViewCell.SelectionStyle
    
    public init(
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil,
        centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment = .leading,
        cellIdentifier: String = "RowCell",
        cellSelectionStyle: UITableViewCell.SelectionStyle = .gray
    ) {
        self.leading = leading
        self.center = center
        self.trailing = trailing
        self.centralBlockAlignment = centralBlockAlignment
        self.cellIdentifier = cellIdentifier
        self.cellSelectionStyle = cellSelectionStyle
    }
}

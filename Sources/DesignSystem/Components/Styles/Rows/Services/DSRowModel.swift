import Components
import UIKit

public final class DSRowModel {
    public let leading: DSRowBlocks?
    public let center: DSRowBlocks?
    public let trailing: DSRowBlocks?
    public let centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment
    public let margings: RowBaseContainer.ViewProperties.Margins?
    public let cellIdentifier: String
    public let cellSelectionStyle: UITableViewCell.SelectionStyle
    /// Для разной высоты ячеек в одной секции.
    /// Если нужна одинаковая высота у всех ячеек в секции - использовать rowsHeight у SectionRowModelService
    public let height: CGFloat?
    public let backgroundColor: UIColor?
    public let didTap: ((UITableView, IndexPath) -> Void)?
    
    public init(
        leading: DSRowBlocks? = nil,
        center: DSRowBlocks? = nil,
        trailing: DSRowBlocks? = nil,
        centralBlockAlignment: RowBaseContainer.ViewProperties.BlockAlignment = .leading,
        margings: RowBaseContainer.ViewProperties.Margins? = nil,
        cellIdentifier: String = "RowCell",
        cellSelectionStyle: UITableViewCell.SelectionStyle = .gray,
        height: CGFloat? = nil,
        backgroundColor: UIColor? = nil,
        didTap: ((UITableView, IndexPath) -> Void)? = nil
    ) {
        self.leading = leading
        self.center = center
        self.trailing = trailing
        self.centralBlockAlignment = centralBlockAlignment
        self.margings = margings
        self.cellIdentifier = cellIdentifier
        self.cellSelectionStyle = cellSelectionStyle
        self.height = height
        self.backgroundColor = backgroundColor
        self.didTap = didTap
    }
}

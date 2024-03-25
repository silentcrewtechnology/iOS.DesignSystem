import UIKit
import Colors
import Components

private class Example {
    
    private let segmentView = SegmentView()
    private var viewProperties = SegmentView.ViewProperties()
    
    private func example() {
        let style = SegmentViewStyle.Style.action
        viewProperties = .init(
            items: [
                "321".attributed,
                "654".attributed,
                "987".attributed
            ].map { .init(text: $0) },
            selectedSegmentIndex: 2,
            onSelect: { [weak self] index in
                guard let self else { return }
                guard index != self.viewProperties.selectedSegmentIndex else { return }
                self.viewProperties.selectedSegmentIndex = index
                self.viewProperties = SegmentViewStyle.update(style: style, viewProperties: self.viewProperties)
                self.segmentView.update(with: self.viewProperties)
            }
        )
        viewProperties = SegmentViewStyle.update(background: .primary, viewProperties: viewProperties)
        viewProperties = SegmentViewStyle.update(size: .medium, viewProperties: viewProperties)
        viewProperties = SegmentViewStyle.update(style: style, viewProperties: viewProperties)
        segmentView.update(with: viewProperties)
    }
}

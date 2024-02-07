//
//  TextareaView.swift
//  
//
//  Created by Ilnur Mugaev on 07.11.2023.
//

import UIKit
import SnapKit
import Architecture

public final class TextareaView: UIView, ViewProtocol {
    
    // MARK: - ViewProperties
    
    public enum Counter: Equatable {
        case undefined
        case number(Int)
    }
    
    public enum TextViewHeight {
        case minimal
        case custom(lines: Int, autoResizeHeight: Bool)
    }
    
    public struct ViewProperties {
        public var header: NSMutableAttributedString?
        public var text: NSMutableAttributedString = .init(string: "")
        public var textViewHeight: TextViewHeight = .custom(lines: 4, autoResizeHeight: false)
        public var typingText: NSMutableAttributedString = .init(string: " ")
        public var isUserInteractionEnabled = true
        public var placeholder: NSMutableAttributedString = .init(string: "")
        public var hint: NSMutableAttributedString = .init(string: "")
        public var isHintHidden = true
        public var counter: NSMutableAttributedString = .init(string: "")
        public var isCounterHidden = true
        public var maxCount: Counter = .undefined
        public var borderColor: UIColor = .clear
        public var backgroundColor: UIColor = .clear
    }
    
    private var viewProperties: ViewProperties = .init()
    
    // MARK: - UI
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.headerInset)
        }
        return view
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editTextView)))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true
        textView.textContainerInset = Constants.textViewContainerInset
        textView.delegate = self
        return textView
    }()
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var bottomLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hintLabel,
            counterLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerView,
            textView,
            bottomLabelsStackView
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Public methods
    
    public func create(with viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        self.viewProperties = viewProperties
        setTextViewHeight()
        updateView(with: viewProperties)
    }
    
    public func update(with viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        updateView(with: viewProperties)
        self.viewProperties = viewProperties
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        setupPlaceholderLabel(for: textView)
        setupGestureRecognizer()
    }
    
    private func setTextViewHeight() {
        let boundingRect = viewProperties.typingText.boundingRect(
            with: .init(
                width: textView.bounds.width,
                height: CGFloat.greatestFiniteMagnitude),
            context: nil)
        let lineHeight = boundingRect.height
        
        switch viewProperties.textViewHeight {
        case .minimal:
            textView.isScrollEnabled = false
            textView.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(lineHeight + Constants.textViewVerticalPadding)
            }
        case let .custom(lines, autoResizeHeight):
            textView.isScrollEnabled = !autoResizeHeight
            let height = lineHeight * CGFloat(lines) + Constants.textViewVerticalPadding
            textView.snp.makeConstraints {
                if autoResizeHeight {
                    $0.height.greaterThanOrEqualTo(height)
                } else {
                    $0.height.equalTo(height)
                }
            }
        }
    }
    
    private func setupPlaceholderLabel(for textView: UITextView) {
        let textViewInset = textView.textContainerInset
        let placeholderLabelInset = UIEdgeInsets(
            top: textViewInset.top,
            left: textViewInset.left + Constants.placeholderHorizontalOffset,
            bottom: textViewInset.bottom,
            right: textViewInset.right + Constants.placeholderHorizontalOffset
        )
        
        textView.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints {
            $0.edges.equalTo(textView).inset(placeholderLabelInset)
        }
        
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    private func setupGestureRecognizer() {
        let gr = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(gr)
    }
    
    private func updateView(with viewProperties: ViewProperties) {
        
        headerLabel.attributedText = viewProperties.header
        headerView.isHidden = viewProperties.header?.string.isEmpty != false
        
        placeholderLabel.attributedText = viewProperties.placeholder
        placeholderLabel.isHidden = !viewProperties.text.string.isEmpty
        
        textView.typingAttributes = viewProperties.typingText.attributes(at: 0, effectiveRange: nil)
        textView.attributedText = viewProperties.text
        textView.layer.borderColor = viewProperties.borderColor.cgColor
        textView.backgroundColor = viewProperties.backgroundColor
        textView.isUserInteractionEnabled = viewProperties.isUserInteractionEnabled
        
        hintLabel.attributedText = viewProperties.hint
        hintLabel.isHidden = viewProperties.isHintHidden
        
        counterLabel.attributedText = viewProperties.counter
        counterLabel.isHidden = viewProperties.isCounterHidden
    }
    
    @objc private func editTextView() {
        textView.becomeFirstResponder()
    }
    
    @objc private func dismissKeyboard() {
        textView.resignFirstResponder()
    }
}

// MARK: - UITextViewDelegate

extension TextareaView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        updateViewProperties(for: textView, style: .active)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        updateViewProperties(for: textView, style: .active)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        updateViewProperties(for: textView, style: .default)
    }
    
    private func updateViewProperties(
        for textView: UITextView,
        style: TextareaViewStyle.Style
    ) {
        var updatedProperties = viewProperties
        let currentStyle: TextareaViewStyle.Style
        
        if case .number(let maxCount) = updatedProperties.maxCount {
            let characterCount = textView.text.count
            updatedProperties.counter = "\(characterCount)/\(maxCount)".attributed
            currentStyle = characterCount > maxCount ? .error : style
        } else {
            currentStyle = style
        }
        
        updatedProperties.text = textView.text.attributed
        updatedProperties.isHintHidden = currentStyle != .error
        updatedProperties.isCounterHidden = currentStyle != .error && currentStyle != .active
        
        updatedProperties = TextareaViewStyle.restyle(
            style: currentStyle,
            viewProperties: updatedProperties)
        
        update(with: updatedProperties)
    }
}

private enum Constants {
    static let headerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    static let textViewContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    static let textViewVerticalPadding: CGFloat = 16
    static let placeholderHorizontalOffset: CGFloat = 5
}

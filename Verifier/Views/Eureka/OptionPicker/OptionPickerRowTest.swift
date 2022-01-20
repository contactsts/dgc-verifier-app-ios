import Foundation
import Eureka
import SnapKit

public class OptionPickerCellTest: Cell<[String]>, CellType {
    
    let titleLabel = UILabel()
    let dummyView = UIView()

    
    public override func setup() {
        super.setup()
        
        height = { UITableView.automaticDimension }
        //        height = { return 200 }

        selectionStyle = .none
        
        self.backgroundColor = .brown
        titleLabel.text = "Initial text"
        titleLabel.backgroundColor = .magenta
        

        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(10)
        }
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        
        self.contentView.addSubview(dummyView)
        dummyView.backgroundColor = .green
        dummyView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(210)
        }
    }

    
    open override func didSelect() {
        super.didSelect()
    }
    
    public override func update() {
        super.update()
        titleLabel.text = row.title ?? "No title"
//        self.contentView.layoutIfNeeded()
    }
    
    
}


public final class OptionPickerRowTest: Row<OptionPickerCellTest>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<OptionPickerCellTest>()
    }

    
}

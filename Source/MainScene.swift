import Foundation

class MainScene: CCScene, CCTableViewDataSource {
    private var renderTexture : CCRenderTexture!
    private let shopTableView = CCTableView()
    private var tableViewItems = [CCTableViewCell]()
    override init!() {
        super.init()
        
        let size = contentSizeInPoints
        let w = Int32(size.width)
        let h = Int32(size.height)
        
        createCells()
        shopTableView.dataSource = self
        shopTableView.setTarget(self, selector: #selector(MainScene.onRowSelected(_:)))
        shopTableView.contentSizeType = CCSizeTypeMake(.Normalized, .Normalized)
        shopTableView.contentSize = CGSize(width: 1.0, height: 1.0)
        shopTableView.anchorPoint = ccp(0.5, 0.5)
        shopTableView.position = ccp(0.5, 0.5)
        shopTableView.positionType = CCPositionType( xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        
        renderTexture = CCRenderTexture(width: w, height: h)
        renderTexture.addChild(shopTableView)
        renderTexture.sprite.shaderUniforms["u_MaskTexture"] = CCTexture(file: "mask.png")
        renderTexture.sprite.shader = CCShader(named: "MaskPositive")
        renderTexture.autoDraw = true
        renderTexture.clearColor = CCColor.clearColor()
        renderTexture.clearFlags = GLbitfield(GL_COLOR_BUFFER_BIT)
        
        renderTexture.position = ccp(CGFloat(w) / 2.0, CGFloat(h) / 2.0)
        addChild(renderTexture)
    }

    private func createCells() {
        for _ in 0...15 {
            let cell = CCTableViewCell()
            
            cell.contentSizeType = CCSizeTypeMake(.Normalized, .UIPoints);
            cell.contentSize = CGSizeMake(1, 50.0);
            
            let bg = CCNodeColor(color: CCColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
            
            bg.userInteractionEnabled = false;
            bg.contentSizeType = CCSizeTypeMake(.Normalized, .Normalized)
            bg.contentSize = CGSizeMake(1, 0.95);
            cell.addChild(bg)
            
            // Create a label with the row number
            let lbl = CCLabelTTF(string:"MASK ME PLEASE", fontName: "Helvectica", fontSize: 17.0);
            lbl.positionType = CCPositionType( xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
            lbl.position = ccp(0.5, 0.5);
            
            cell.addChild(lbl)
            
            tableViewItems.append(cell)
        }
        
    }
    
    //
    // DATA SOURCE
    //
    func tableView(tableView: CCTableView!, heightForRowAtIndex index: UInt) -> Float {
        return Float(tableViewItems[Int(index) % tableViewItems.count].contentSizeInPoints.height)
    }
    
    func tableView(tableView: CCTableView!, nodeForRowAtIndex index: UInt) -> CCTableViewCellProtocol! {
        return tableViewItems[Int(index)]
    }
    
    func tableViewNumberOfRows(tableView: CCTableView!) -> UInt {
        return UInt(tableViewItems.count)
    }
    
    func onRowSelected(sender: AnyObject!) {
        let rowNumber = shopTableView.selectedRow
        
        print(rowNumber)
    }
}

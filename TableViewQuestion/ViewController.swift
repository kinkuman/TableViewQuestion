//
//  ViewController.swift
//  TableViewQuestion
//
//  Created by user on 2018/09/06.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    // 表示用データ 自作のデータ型Itemの配列
    var tableData:[[Item]]!
    
    // 表示用タイトル
    var tableTitles = ["干支","星座"]
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 表示データ準備
        let etoArray = createEtoItems()
        let starArray = createStarItems()
        
        // 表示用データ
        tableData = [etoArray,starArray]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.section][indexPath.row].name
        cell.detailTextLabel?.text = tableData[indexPath.section][indexPath.row].reading
        cell.imageView?.image = tableData[indexPath.section][indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitles[section]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 選ばれたindexPathのデータをデータソースのArrayから削除
        tableData[indexPath.section].remove(at: indexPath.row)
        
        // テーブルビューから削除（消したいものはそのIndexPathをArrayにいれて渡す)、フェードのアニメーション付き
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // セクションごとに移動可能かどうか
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        //        // セクションを調べて移動の許可をするならばtrueを返す
        //        if indexPath.section == 0 {
        //            return true
        //        } else {
        //            return false
        //        }
        
        return true
    }
    
    // 移動した時の入れ替え処理
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 移動元のデータを切り取り
        let srcString = tableData[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        // 切り取ったデータを挿入
        tableData[destinationIndexPath.section].insert(srcString, at: destinationIndexPath.row)
    }
    
    // MARK: - Delegate
    
    // 移動先の移動先の許可、不許可
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        // 移動先セクションが同じだった場合は
        if sourceIndexPath.section == proposedDestinationIndexPath.section {
            // 移動先の位置を返して移動する事を許可する
            return proposedDestinationIndexPath;
        } else {
            // 干支ー＞星座の場合は、元の位置をもどして移動を許さない。
            return sourceIndexPath
        }
    }
    
    
    // MARK: - targetAction
    
    // 編集ボタン
    @IBAction func edit(_ sender: UIButton) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    // MARK: - 自分メソッド
    
    // 干支情報(Itemインスタンスの詰まったArray)の作成
    func createEtoItems() -> [Item] {
        // 干支
        let etoArray = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
        
        // 干支詳細テキスト
        let detailArray = ["ね","うし","とら","う","たつ","み","うま","ひつじ","さる","とり","いぬ","いのしし"]
        // 画像ファイル名
        let etoImageNames = ["eto_ca_025.png","eto_ca_026.png","eto_ca_027.png","eto_ca_028.png","eto_ca_029.png","eto_ca_030.png","eto_ca_031.png","eto_ca_032.png","eto_ca_033.png","eto_ca_034.png","eto_ca_035.png","eto_ca_036.png"]
        
        // 干支アイテムの入れ物
        var etoItemArray:[Item] = []
        
        // 干支のデータが入ったItemを作る
        for i in 0..<etoArray.count {
            
            let etoItem = Item(number: i, image: UIImage(named: etoImageNames[i]) ?? nil, name: etoArray[i], reading: detailArray[i])
            // 追加
            etoItemArray.append(etoItem)
        }
        
        return etoItemArray
    }
    
    // 星座のItemを作る
    func createStarItems() -> [Item] {
        let starArray = ["牡羊座", "牡牛座", "双子座", "蟹座", "獅子座", "乙女座", "天秤座", "蠍座", "蛇使い座", "射手座", "山羊座", "水瓶座", "魚座"]
        
        // 星座アイテムを作る
        var starItemArray:[Item] = []
        
        for i in 0..<starArray.count {
            
            let starItem = Item(number: i, image: nil, name: starArray[i], reading: "")
            starItemArray.append(starItem)
        }
        
        return starItemArray
    }
}

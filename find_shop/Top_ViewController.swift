//
//  Top_ViewController.swift
//  find_shop
//
//  Created by Yuya Aoki on 2020/03/30.
//  Copyright © 2020 Yuya Aoki. All rights reserved.
//

import UIKit

class Top_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var distance: UIPickerView!
    //pickerにセットする配列
    var distance_data = ["2km","5km","8km","10km","20km"]
    var select_shop : String = ""
    
    //スタバのボタンが押された時に発動
    @IBAction func starbucks_label(_ sender: Any) {
        select_shop="スターバックス"
    }
    //コンビニのボタンが押された時に発動
    @IBAction func convenience_store_label(_ sender: Any) {
        select_shop="コンビニ"
    }
    //ガソリンスタンドのボタンが押された時に発動
    @IBAction func gas_station_label(_ sender: Any) {
        select_shop="ガソリンスタンド"
    }
    //バーのボタンが押された時に発動
    @IBAction func bar_label(_ sender: Any) {
        select_shop="バー"
    }
    //ラーメンのボタンが押された時に発動
    @IBAction func ramen_label(_ sender: Any) {
        select_shop="ラーメン"
    }
    //タリーズコーヒーのボタンが押された時に発動
    @IBAction func tullys_coffee_label(_ sender: Any) {
        select_shop="タリーズコーヒー"
    }
    //pickerの個数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //セットする個数（今回はdistance_dataの個数）
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distance_data.count
    }
    //distance_dataの内容をpickerにセット
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return distance_data[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.distance.delegate = self
        self.distance.dataSource = self
    }
    //ViewControllerのselected_shop、そしてselected_distanceへ代入
    override func prepare(for segue: UIStoryboardSegue,sender:Any?){
           if(segue.identifier == "result_segue"){
               let next: ViewController = segue.destination as! ViewController
                //ViewControllerのselected_distanceにはdistance(これはpicker)の順番を代入
               next.selected_distance = distance.selectedRow(inComponent:0)
            
            //各店舗情報をselected_shopへ引き継ぐ
            if(select_shop=="スターバックス"){
                next.selected_shop = "スターバックス"
            }
            else if(select_shop=="コンビニ"){
                next.selected_shop = "コンビニ"
            }
            else if(select_shop=="ガソリンスタンド"){
                next.selected_shop = "ガソリンスタンド"
            }
            else if(select_shop=="バー"){
                next.selected_shop = "バー"
            }
            else if(select_shop=="ラーメン"){
                next.selected_shop = "ラーメン"
            }
            else if(select_shop=="タリーズコーヒー"){
                next.selected_shop = "タリーズコーヒー"
            }
            
                
           }
        
    
       }
}

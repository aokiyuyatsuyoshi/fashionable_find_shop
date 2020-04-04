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
    var shop_select_array = ["スターバックス","コンビニ","ガソリンスタンド","バー","ラーメン","タリーズコーヒー"]
    //各ボタン
    @IBOutlet weak var starbuck_button: UIButton!
    @IBOutlet weak var convenience_store_button: UIButton!
    @IBOutlet weak var gas_station: UIButton!
    @IBOutlet weak var bar_button: UIButton!
    @IBOutlet weak var ramen_button: UIButton!
    @IBOutlet weak var tullys_button: UIButton!
    //枠線の色を変える関数
    func change_border(ui:UIButton){
        ui.layer.borderWidth = 3
        ui.layer.borderColor = UIColor.yellow.cgColor
        ui.setTitleColor(UIColor.black, for: .normal)
    }
    //枠線の色を消す関数
    func delite_border(ui:UIButton){
           ui.layer.borderWidth = 0
           ui.layer.borderColor = UIColor.white.cgColor
           ui.setTitleColor(UIColor.white, for: .normal)
       }
    //アイテムが選択されたとき
    func vanish_All_border(){
        delite_border(ui: starbuck_button)
        delite_border(ui: convenience_store_button)
        delite_border(ui: gas_station)
        delite_border(ui: bar_button)
        delite_border(ui: ramen_button)
        delite_border(ui: tullys_button)
    }
    //スタバのボタンが押された時に発動
    @IBAction func starbucks_label(_ sender: Any) {
        select_shop="スターバックス"
        vanish_All_border()
        change_border(ui: starbuck_button)
    }
    //コンビニのボタンが押された時に発動
    @IBAction func convenience_store_label(_ sender: Any) {
        select_shop="コンビニ"
        vanish_All_border()
        change_border(ui: convenience_store_button)
    }
    //ガソリンスタンドのボタンが押された時に発動
    @IBAction func gas_station_label(_ sender: Any) {
        select_shop="ガソリンスタンド"
        vanish_All_border()
        change_border(ui: gas_station)
    }
    //バーのボタンが押された時に発動
    @IBAction func bar_label(_ sender: Any) {
        select_shop="バー"
        vanish_All_border()
        change_border(ui: bar_button)
    }
    //ラーメンのボタンが押された時に発動
    @IBAction func ramen_label(_ sender: Any) {
        select_shop="ラーメン"
        vanish_All_border()
        change_border(ui: ramen_button)
    }
    //タリーズコーヒーのボタンが押された時に発動
    @IBAction func tullys_coffee_label(_ sender: Any) {
        select_shop="タリーズコーヒー"
        vanish_All_border()
        change_border(ui: tullys_button)
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
               next.picker_selected_distance = distance.selectedRow(inComponent:0)
            print(distance.selectedRow(inComponent: 0))
            //各店舗情報をselected_shopへ引き継ぐ
            var  counter : Int = 0
            while counter < shop_select_array.count{
                if(select_shop == shop_select_array[counter]){
                    next.selected_shop = shop_select_array[counter]
                    print("pre.flag")
                    print(shop_select_array[counter])
                }
                counter = counter + 1
            }
              
           }
        
        }
 
       

}

//
//  DateDisplayViewController.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 30/12/2023.
//

import UIKit

class DateDisplayViewController: UIViewController {
    
    var lblDate = ""
    var lblDateRecords = [ "Month-Day-Year-With-leading-zeros" : "MM-dd-yyyy", 
                            "Day-Month-Year-with-leading-zeros" : "dd-MM-yyyy",
                            "Year-Month-Day-with-leading-zeros" : "yyyy-MM-dd",
                            "Month-name-Day-Year-with-no-leading-zeros" : "MMMM d, yyyy",
                            "Month name-Day-Year-with-no-leading-zeros" : "M-d-yyyy",
                            "Day-Month-Year-with-no-leading-zeros" : "d-M-yyyy",
                            "Year-Month-Day-with-no-leading-zeros" : "y-M-d",
                            "Month-Day-Year-with-spaces-instead-of-leading-zeros" : "MMMM d yyyy",
                            "Day-Month-Year-with-spaces-instead-of-leading-zeros" : "d MMMM y",
                            "Year-Month-Day-with-spaces-instead-of-leading-zeros" : "yyyy/ M/d",
                            "Month-Day-Year-with-no-separators" : "MMddyyyy",
                            "Day-Month-Year-with-no-separators" : "dMMyyyy",
                            "Year-Month-Day-with-no-separators" : "yyyyMMdd",
                            "Day-Month-abbreviation-Year-with-leading-zeros" : "dd-MMM-yyyy",
                            "Month-abbreviation-Day-Year-with-leading-zeros" : "MMM-dd-yyyy",
                            "Year-Month abbreviation-Day-with-leading-zeros" : "yyyy-MMM-dd",
                            "Day-of-year-(counting-consecutively-from-January-1)-Year" : "d-yyyy",
                            "Year-Day-of-Year-(counting-consecutively-from-January-1—often-called-the-Julian-date-format)" : "yyyy-ddd",
                            "Day-Month-name-Year" : "d-MMMM-yyyy",
                            "Year-Month-name-Day" : "yyyy-MMMM-d",
                            "Month-abbreviation-Day-with-leading-zeros-Year" : "MMM dd, yyyy",
                            "Day-with-leading-zeros-Month-abbreviation-Year" : "dd MMM, yyyy",
                            "Year-Month-abbreviation-Day-with-leading-zero" : "yyyy, MMM dd",
                            "Month-abbreviation-Day-with-leading-zeros-Yar" : "MMM dd, yyyy",
                            "Day-with-leading-zeros-Month-abbreviation-Yer" : "dd MMM, yyyy",
                            "Year-Month-abbreviation-Day-with-leading-zeros" : "yyyy, MMM dd",
                            "hexadecimal" : "%08X",
                            "Format-type-1" : "MM/YY/dd",
                            "Format-type-1-with-dashes" : "M-d-yyyy",
                            "Format-type-1-with-backslashes" : "M/d/yy",
                            "Format-type-1-with-a-four-digit-year" : "M/d/yyyy",
                            "Format-type-B-with-a-four-digit-year" : "MMddyyyy",
                            
                           "4@CAD":"fr_CA"]
    
    var lblFormattedDateRecords = [String: String]()
    
    lazy var lblPick: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pick a DATE:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var txtFieldDatePicker: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        txtField.delegate = self
        for (key,value) in lblDateRecords{
            var formattedDate = formatDate(date: Date(), lblDateFormat: key)
            lblFormattedDateRecords[key] = formattedDate
        }
        
        return txtField
    }()
    
    lazy var datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        txtFieldDatePicker.inputView = datePicker
        txtFieldDatePicker.text = lblDate
        var date = datePicker.date
       return datePicker
    }()
    
    lazy var DateListCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "DateCollectionViewCell")
        collectionView.backgroundColor = .none
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = true
        
        return collectionView
    }()
    
    //MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        view.backgroundColor = UIColor.white
    }
    
    //MARK: - AutoLayouts
    func setUpLayout() {
        autoLayoutForLabel()
        autoLayoutForTxtField()
        //autoLayoutForDatePicker()
        autoLayoutForCollectionView()
    }
    
    func autoLayoutForLabel() {
        view.addSubview(lblPick)
        NSLayoutConstraint.activate([
            lblPick.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lblPick.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lblPick.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            lblPick.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
    func autoLayoutForTxtField() {
        view.addSubview(txtFieldDatePicker)
        NSLayoutConstraint.activate([
            txtFieldDatePicker.leadingAnchor.constraint(equalTo: lblPick.leadingAnchor, constant: 20),
            txtFieldDatePicker.trailingAnchor.constraint(equalTo: lblPick.trailingAnchor, constant: -20),
            txtFieldDatePicker.topAnchor.constraint(equalTo: lblPick.bottomAnchor, constant: 10),
            txtFieldDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
    }
    
//    func autoLayoutForDatePicker() {
//        view.addSubview(datePicker)
//        txtFieldDatePicker.inputView = datePicker
//    }
    
    func autoLayoutForCollectionView() {
        view.addSubview(DateListCollection)
        NSLayoutConstraint.activate([
            DateListCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            DateListCollection.topAnchor.constraint(equalTo: txtFieldDatePicker.bottomAnchor, constant: 20),
            DateListCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            DateListCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    //MARK: - DatePicker functions
    @objc func dateChanged(datePicker: UIDatePicker)
    {
        
        lblDate = formatDate(date: datePicker.date, lblDateFormat: "MM/dd/YYYY")
    }
    
    func formatDate(date: Date, lblDateFormat: String) -> String
    {
//        print(lblDateRecords["Month-Day-Year"])
        let formatter = DateFormatter()
        formatter.dateFormat = lblDateRecords[lblDateFormat]
        
        let formattedDateString = formatter.string(from: Date())
    
        if (lblDateFormat == "fr_CA") {
            formatter.locale = Locale(identifier: "fr_CA")
        }
        
        if (lblDateFormat == "hexadecimal") {
            formatter.locale = Locale(identifier: "%08X")
        }
        
        return formatter.string(from: date)
    }
} 
    
    //MARK: - CollectionView Extension
    extension DateDisplayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return lblFormattedDateRecords.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            var array1 = Array(lblFormattedDateRecords.keys)
            var array2 = Array(lblFormattedDateRecords.values)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
            cell.layer.cornerRadius = 12
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.2
            cell.layer.backgroundColor = UIColor(Color.pink).cgColor
            cell.lblConvertedDate.text = array1[indexPath.row]
            cell.lblDateFormat.text = array2[indexPath.row]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellWidth: CGFloat = 300.0
            let cellHeight: CGFloat = 100.0
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }

//MARK: - TextField Delegate
extension DateDisplayViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFieldDatePicker {
            // Show the date picker when the text field is being edited
            datePicker.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtFieldDatePicker {
            // Hide the date picker when editing ends
            datePicker.isHidden = true
        }
        datePicker.isHidden = true
    }
}

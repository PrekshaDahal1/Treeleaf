//
//  DateDisplayViewController.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 30/12/2023.
//

import UIKit

class DateDisplayViewController: UIViewController {
    
    var lblDate = ""
    var lblDateRecords = [ "Mon-Day-Year" : "MM/DD/YY", "Day-Month-Yea" : "DD/MM/YY", "YY/MM/DD" : "Year-Mnth-Day", "MonthName-Day-Year" : "Month D, Yr", "Month-DayYear" : "M/D/YY", "Day-MonthYea" : "D/M/YY", "YearMontDay" : "YY/M/D", "onth-Day-Year" : "bM/bD/YY", "DayMonth-Year" : "bD/bM/YY", "YearMonthDay" : "YY/bM/bD", "Month-Day-Year" : "MMDDYY", "DayMonthYear" : "DDMMYY", "YearMonthDy" : "YYMMDD", "abbreviation-Day-Year" : "MonDDYY", "Day-MonthAbbreviation-Year" : "DDMonYY", "Year-Month abbreviation-Day" : "YYMonDD", "DayOfYear" : "day/YY", "Year-DayOfYear" : "YY/day", "Day-MonthName-Year" : "D Month, Yr", "Year-MonthName-Day" : "Yr, Month D", "MonthAbbreviationDayYear" : "Mon-DD-YYYY", "MonthAbbreviationYea" : "DD-Mon-YYYY", "YeaMonthAbbreviationDay" : "YYYYY-Mon-DD", "MonthAbbreviation" : "Mon DD, YYYY", "MohAbbreviationYea" : "DD Mon, YYYY", "YearMonthAbbreviationDay" : "YYYY, Mon DD"]
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
            DateListCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            DateListCollection.topAnchor.constraint(equalTo: txtFieldDatePicker.bottomAnchor, constant: 20),
            DateListCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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
        print(formattedDateString)
        
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
            cell.layer.backgroundColor = UIColor(Color.gray).cgColor
            cell.lblConvertedDate.text = array1[indexPath.row]
            cell.lblDateFormat.text = array2[indexPath.row]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellWidth: CGFloat = 160.0
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

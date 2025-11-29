////
////  Empty.swift
////  iProfi_new
////
////  Created by Artyom Vlasov on 22.01.2021.
////
//
//import Foundation
//
//
//func sheduleSort() {
//    for index in 0..<weekDays.count {
//        let item = weekDays[index]
//        let bufferRecords = item.records
//        let days = serverShadule?.datatimes?[item.dayWeekNumber]
//        let weeks = serverShadule?.weekends
//        var totalArray: [Records] = []
//
//        if weeks?.contains(item.dateFormated) ?? false {
//            weekDays[index].weekend = true
//        } else {
//            weekDays[index].weekend = false
//        }
//
//        if !weekDays[index].weekend {
//            for i in 0..<timesList.count {
//                let time = timesList[i]
//                //попадает в расписание
//                if time.convertTime() >= days?.beginTime?.convertTime() ?? 0 && time.convertTime() <= days?.endTime?.convertTime() ?? 0 {
//                    //есть перерыв
//                    if days?.breakTimes.count ?? 0 == 2 {
//                        if time.convertTime() < days?.breakTimes[0].convertTime() ?? 0 || time.convertTime() >= days?.breakTimes[1].convertTime() ?? 0 {
//                            //с перерывом
//                            totalArray.append(Records(id: 0, userID: 0, clientID: 0, price: 0, discount: 0, duration: 0, date: "\(item.dateFormated) \(time)", note: "", imageBefore: "", reminder: 0, imageAfter: "", status: 666, createdAt: "", updatedAt: "", client: nil, services: nil, expandables: nil))
//
//
//                            if bufferRecords.contains(where: { "\($0.date?.split(separator: " ")[1] ?? "")".convertTime() == time.convertTime() }) {
//                                for record in bufferRecords {
//                                    let beginTime = "\(record.date?.split(separator: " ")[1] ?? "")".convertTime()
//                                    if beginTime == time.convertTime() {
//
//                                        if i < ((timesList.count) - 1) {
//                                            if (beginTime + (record.duration ?? 0)) < (timesList[i + 1].convertTime()) {
//                                                totalArray.append(record) // если не последнее и вписывается
//                                                print("если не последнее и вписывается")
//                                            } else {
//                                                //если наплыв
//                                                totalArray.append(record)
//                                                print("если наплыв")
//                                            }
//                                        } else {
//                                            totalArray.append(record) // если последнее
//                                            print("если последнее")
//                                        }
//                                    }
//                                }
//                            } else {
//                                totalArray.append(Records(id: 0, userID: 0, clientID: 0, price: 0, discount: 0, duration: 0, date: "\(item.dateFormated) \(time)", note: "", imageBefore: "", reminder: 0, imageAfter: "", status: 666, createdAt: "", updatedAt: "", client: nil, services: nil, expandables: nil))
//                            }
//
//                        }
//                    } else {
//                        //с без
//                        if bufferRecords.contains(where: { "\($0.date?.split(separator: " ")[1] ?? "")".convertTime() == time.convertTime() }) {
//                            for record in bufferRecords {
//                                let beginTime = "\(record.date?.split(separator: " ")[1] ?? "")".convertTime()
//                                if beginTime == time.convertTime() {
//                                    if i < ((timesList.count) - 1) {
//                                        if (beginTime + (record.duration ?? 0)) < (timesList[i + 1].convertTime()) {
//                                            totalArray.append(record) // если не последнее и вписывается
//                                            print("если не последнее и вписывается")
//                                        } else {
//                                            //если наплыв
//                                            totalArray.append(record)
//                                            print("если наплыв")
//                                        }
//                                    } else {
//                                        totalArray.append(record) // если последнее
//                                        print("если последнее")
//                                    }
//                                }
//                            }
//                        } else {
//                            totalArray.append(Records(id: 0, userID: 0, clientID: 0, price: 0, discount: 0, duration: 0, date: "\(item.dateFormated) \(time)", note: "", imageBefore: "", reminder: 0, imageAfter: "", status: 666, createdAt: "", updatedAt: "", client: nil, services: nil, expandables: nil))
//                        }
//                    }
//                }
//            }
//        }
//
//
//        var filteredArray: [Records] = []
//
//        if totalArray.contains(where: {($0.status ?? 0) < 665}) {
//            for pos in 0..<totalArray.count {
//                let it = totalArray[pos]
//                if pos > 0 {
//                    if it.status == 666 {
//                        let nowTime = "\(it.date?.split(separator: " ")[1] ?? "")".convertTime()
//                        let endTime = "\(filteredArray.last?.date?.split(separator: " ")[1] ?? "")".convertTime() + (filteredArray.last?.duration ?? 0)
//                        if nowTime >= endTime {
//                            filteredArray.append(it)
//                        }
//                    } else {
//                        filteredArray.append(it)
//                        if it.status == 1 {
//                            if pos < (totalArray.count - 1) {
//                                if totalArray[pos + 1].status ?? 0 == 666 {
//                                    filteredArray.append(Records(id: 0, userID: 0, clientID: 0, price: 0, discount: 0, duration: 0, date: it.date, note: "", imageBefore: "", reminder: 0, imageAfter: "", status: 666, createdAt: "", updatedAt: "", client: nil, services: nil, expandables: nil))
//                                }
//                            }
//                        }
//
//                    }
//                } else {
//                    filteredArray.append(it)
//                }
//            }
//        } else {
//            filteredArray = totalArray
//        }
//        weekDays[index].records = filteredArray
//    }
//}



//func sheduleSort() {
//    for index in 0 ..< weekDays.count {
//        var totalArray = baseSort(index: index)
//
//        let canceled = totalArray.filter({ $0.status == 1 })
//        totalArray.removeAll(where: { $0.status == 1 })
//
//        weekDays[index].records = totalArray
//        var filteredArray: [Records] = []
//
//        if totalArray.contains(where: { ($0.status ?? 0) < 665 }) {
//            for pos in 0 ..< totalArray.count {
//                let it = totalArray[pos]
//                if pos > 0 {
//                    if it.status == 666 {
//                        let nowTime = "\(it.date?.split(separator: " ")[1] ?? "")".convertTime()
//                        let endTime = "\(filteredArray.last?.date?.split(separator: " ")[1] ?? "")".convertTime() + (filteredArray.last?.duration ?? 0)
//                        if nowTime >= endTime {
//                            filteredArray.append(it)
//                        }
//                    } else {
//                        filteredArray.append(it)
//                    }
//                } else {
//                    filteredArray.append(it)
//                }
//            }
//        } else {
//            filteredArray = totalArray
//        }
//
//        for item in canceled {
//            filteredArray.append(item)
//        }
//
//        filteredArray.sort {$0.status ?? 0 > $1.status ?? 0}
//        filteredArray.sort {$0.date?.convertDateToDate().timeIntervalSince1970 ?? 0 < $1.date?.convertDateToDate().timeIntervalSince1970 ?? 0}
//        weekDays[index].records = filteredArray
//    }
//    tableView.reloadData()
//}
//
//func baseSort(index: Int) -> [Records] {
//    let item = weekDays[index]
//    let bufferRecords = item.records
//    let days = serverShadule?.datatimes?[item.dayWeekNumber]
//    let weeks = serverShadule?.weekends
//    var totalArray: [Records] = []
//
//    if weeks?.contains(item.dateFormated) ?? false {
//        weekDays[index].weekend = true
//    } else {
//        weekDays[index].weekend = false
//    }
//
//    if !weekDays[index].weekend {
//        for i in 0 ..< timesList.count {
//            let time = timesList[i]
//            // попадает в расписание
//            if time.convertTime() >= days?.beginTime?.convertTime() ?? 0 && time.convertTime() <= days?.endTime?.convertTime() ?? 0 {
//                // есть перерыв
//                if days?.breakTimes.count ?? 0 == 2 {
//                    if time.convertTime() < days?.breakTimes[0].convertTime() ?? 0 || time.convertTime() >= days?.breakTimes[1].convertTime() ?? 0 {
//                        // с перерывом
//                        totalArray.append(Records(id: 0, userID: 0, clientID: 0, price: 0, discount: 0, duration: 0, date: "\(item.dateFormated) \(time)", note: "", imageBefore: "", reminder: 0, imageAfter: "", status: 666, createdAt: "", updatedAt: "", client: nil, services: nil, expandables: nil))
//
//                        if bufferRecords.contains(where: { "\($0.date?.split(separator: " ")[1] ?? "")".convertTime() == time.convertTime() }) {
//                            for record in bufferRecords {
//                                let beginTime = "\(record.date?.split(separator: " ")[1] ?? "")".convertTime()
//                                if beginTime == time.convertTime() {
//                                    if i < (timesList.count - 1) {
//                                        if (beginTime + (record.duration ?? 0)) < timesList[i + 1].convertTime() {
//                                            totalArray.append(record) // если не последнее и вписывается
//                                            if record.status == 1 {
//                                                var rec = record
//                                                rec.status = 666
//                                                totalArray.append(rec)
//                                            }
//                                            print("если не последнее и вписывается")
//                                        } else {
//                                            // если наплыв
//                                            totalArray.append(record)
//                                            if record.status == 1 {
//                                                var rec = record
//                                                rec.status = 666
//                                                totalArray.append(rec)
//                                            }
//                                            print("если наплыв")
//                                        }
//                                    } else {
//                                        totalArray.append(record) // если последнее
//                                        if record.status == 1 {
//                                            var rec = record
//                                            rec.status = 666
//                                            totalArray.append(rec)
//                                        }
//                                        print("если последнее")
//                                    }
//                                }
//                            }
//                        } else {
//                            totalArray.append(Records(id: 0, userID: 0, clientID: 0, price: 0, discount: 0, duration: 0, date: "\(item.dateFormated) \(time)", note: "", imageBefore: "", reminder: 0, imageAfter: "", status: 666, createdAt: "", updatedAt: "", client: nil, services: nil, expandables: nil))
//                        }
//                    }
//                } else {
//                    // с без
//                    if bufferRecords.contains(where: { "\($0.date?.split(separator: " ")[1] ?? "")".convertTime() == time.convertTime() }) {
//                        for record in bufferRecords {
//                            let beginTime = "\(record.date?.split(separator: " ")[1] ?? "")".convertTime()
//                            if beginTime == time.convertTime() {
//                                if i < (timesList.count - 1) {
//                                    if (beginTime + (record.duration ?? 0)) < timesList[i + 1].convertTime() {
//                                        totalArray.append(record) // если не последнее и вписывается
//                                        print("если не последнее и вписывается")
//                                        if record.status == 1 {
//                                            var rec = record
//                                            rec.status = 666
//                                            totalArray.append(rec)
//                                        }
//                                    } else {
//                                        // если наплыв
//                                        totalArray.append(record)
//                                        print("если наплыв")
//                                        if record.status == 1 {
//                                            var rec = record
//                                            rec.status = 666
//                                            totalArray.append(rec)
//                                        }
//                                    }
//                                } else {
//                                    totalArray.append(record) // если последнее
//                                    if record.status == 1 {
//                                        var rec = record
//                                        rec.status = 666
//                                        totalArray.append(rec)
//                                    }
//                                    print("если последнее")
//                                }
//                            }
//                        }
//                    } else {
//                        totalArray.append(Records(id: 0, userID: 0, clientID: 0, price: 0, discount: 0, duration: 0, date: "\(item.dateFormated) \(time)", note: "", imageBefore: "", reminder: 0, imageAfter: "", status: 666, createdAt: "", updatedAt: "", client: nil, services: nil, expandables: nil))
//                    }
//                }
//            }
//        }
//    }
//    return totalArray
//}

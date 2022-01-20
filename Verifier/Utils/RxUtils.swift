//
//  DateUtils.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/31/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class RxUtils {
    
    // -----
    
//    static func bind<T>(source: BehaviorRelay<T>, destination: BehaviorRelay<T>, disposeBag: DisposeBag) -> Void where T : Equatable {
//        source
//            //            .skip(1)
//            .subscribe(onNext: { value in
//                if value != destination.value {
//                    destination.accept(value)
//                }
//            }).disposed(by: disposeBag)
//    }
//
//    // -----
//
//    //    static func bindUnique<A,B>(
//    //        source: BehaviorRelay<A>,
//    //        destination: BehaviorRelay<B>,
//    //        transformer: @escaping (A) -> B,
//    //        disposeBag: DisposeBag)
//    //
//    //    -> Void where A : Equatable, B : Equatable {
//    //
//    //        source.subscribe(onNext: { sourceValue in
//    //            let transformedSourceValue = transformer(sourceValue)
//    //            if transformedSourceValue != destination.value {
//    //                destination.accept(transformedSourceValue)
//    //            }
//    //        }).disposed(by: disposeBag)
//    //
//    //    }
//
//    // -----
//
//    static func bidirectionalBind<A,B>(
//        source: BehaviorRelay<A>,
//        destination: BehaviorRelay<B>,
//        transformerSource: @escaping (A) -> B,
//        transformerDestination: @escaping (B) -> A,
//        disposeBag: DisposeBag)
//    -> Void where A : Equatable, B : Equatable {
//
//        destination
//            .subscribe(onNext: { value in
//                let transformedValue = transformerDestination(value)
//                if transformedValue != source.value {
//                    source.accept(transformedValue)
//                }
//            }).disposed(by: disposeBag)
//
//        source
//            .subscribe(onNext: { value in
//                let transformedValue = transformerSource(value)
//                if transformedValue != destination.value {
//                    destination.accept(transformedValue)
//                }
//            }).disposed(by: disposeBag)
//    }
//
//
//    static func bidirectionalBind<A>(
//        source: BehaviorRelay<A>,
//        destination: BehaviorRelay<A>,
//        disposeBag: DisposeBag)
//    -> Void where A : Equatable {
//
//        RxUtils.bidirectionalBind(
//            source: source,
//            destination: destination,
//            transformerSource: { $0 },
//            transformerDestination: { $0 },
//            disposeBag: disposeBag)
//    }
    
    
    static func relayAcceptUnique<A>(relay: BehaviorRelay<A>, value: A) where A : Equatable {
        if value != relay.value {
            relay.accept(value)
        }
    }
    
}

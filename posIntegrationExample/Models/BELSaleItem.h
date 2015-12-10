//
//  BELSaleItem.h
//  posIntegrationExample
//
//  Created by Sean Wolter on 12/9/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "BELPOSModel.h"

@interface BELSaleItem : NSObject <BELPOSModel>

- (instancetype)initWithPrice:(NSNumber *)price
                     discount:(NSNumber *)discount
                         name:(NSString *)name;

@end

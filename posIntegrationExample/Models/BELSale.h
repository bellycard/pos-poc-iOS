//
//  BELSale.h
//  posIntegrationExample
//
//  Created by Sean Wolter on 12/9/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "BELPOSModel.h"

@class BELSaleItem;

@interface BELSale : NSObject <BELPOSModel>

- (void)addItem:(BELSaleItem *)item;

@end

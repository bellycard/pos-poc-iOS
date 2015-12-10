//
//  BELSaleItem.m
//  posIntegrationExample
//
//  Created by Sean Wolter on 12/9/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "BELSaleItem.h"

@interface BELSaleItem ()

@property (nonatomic, strong) NSNumber *originalPrice;
@property (nonatomic, strong) NSNumber *discount;
@property (nonatomic, strong) NSNumber *finalPrice;
@property (nonatomic, copy) NSString *name;

@end

@implementation BELSaleItem

- (instancetype)initWithPrice:(NSNumber *)price
                     discount:(NSNumber *)discount
                         name:(NSString *)name {
    self = [super init];
    if (self) {
        _originalPrice = price;
        _discount = discount;
        _name = [name copy];
        _finalPrice = @(price.doubleValue - discount.doubleValue);
    }
    return self;
}

- (NSDictionary *)foundationRepresentation {
    return @{
             @"loyalty_value" : @0,
             @"quantity" : @1,
             @"sequence" : @"2",
             @"sale_product_original_price" : self.originalPrice,
             @"sale_product_discount" : self.discount,
             @"sale_product_new_price" : self.finalPrice,
             @"variants_string" : @"",
             @"name" : self.name,
             };
}

@end

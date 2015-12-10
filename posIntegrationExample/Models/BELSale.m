//
//  BELSale.m
//  posIntegrationExample
//
//  Created by Sean Wolter on 12/9/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "BELSale.h"
#import "BELSaleItem.h"

@interface BELSale ()

@property (nonatomic, copy) NSArray<BELSaleItem *> *saleProducts;

@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *subtotal;
@property (nonatomic, strong) NSNumber *tax;
@property (nonatomic, assign) double taxRate;

@end

@implementation BELSale

- (instancetype)init {
    self = [super init];
    if (self) {
        _saleProducts = @[];
        _total = @0;
        _subtotal = @0;
        _tax = @0;
        _taxRate = 0.07;
    }
    return self;
}

- (void)addItem:(BELSaleItem *)item {
    NSArray *updatedArray = [self.saleProducts arrayByAddingObject:item];
    self.saleProducts = updatedArray;
    self.subtotal = [updatedArray valueForKeyPath:@"@sum.finalPrice"];
    self.tax = @(self.taxRate * self.subtotal.doubleValue);
    self.total = @(self.tax.doubleValue + self.subtotal.doubleValue);
}

- (NSDictionary *)foundationRepresentation {
    NSArray *saleProductsAsDictionaries = [self.saleProducts valueForKey:@"foundationRepresentation"];
    return @{
             @"sale" : @{
                     @"id" : @"some-uuid-for-this-sale",
                     @"sale_discount" : @"",
                     @"register_sale_products" : saleProductsAsDictionaries,
                     @"total" : self.total,
                     @"balance" : self.total,
                     @"sale_discount_amount" : @0,
                     @"subtotal" : self.subtotal,
                     @"total_tax" : self.tax,
                     @"taxes" : @[
                             @{
                                 @"id" : @"some uuid for a tax",
                                 @"removable" : @NO,
                                 @"name" : @"Sales Tax",
                                 @"total" : self.tax,
                                 @"rate" : @(self.taxRate),
                                 }
                             ],
                     @"sendReceipt" : @0,
                     @"register_sale_payments" : @[

                             ],
                     @"payment_total" : @0,
                     @"status" : @"OPEN",
                     @"recipient_email" : @""
                     }
             };
}

@end

//
//  ViewController.m
//  posIntegrationExample
//
//  Created by Sean Wolter on 9/28/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "ViewController.h"
#import "BELBonjourServer.h"

@interface ViewController ()
@property (nonatomic, strong) BELBonjourServer *bonjourServer;
@property (nonatomic, copy) NSDictionary *currentSale;
@end

@implementation ViewController

- (void)viewDidLoad {
    // display code is hard coded here, but in an actual app it should be editable
    self.bonjourServer = [[BELBonjourServer alloc] initWithDisplayCode:@"1928"];
    BOOL couldStart = [self.bonjourServer start];
    if (!couldStart) {
        NSLog(@"very bad!");
    }
    [self resetCurrentSale];
}

#pragma mark - Actions

- (IBAction)tappedAddItemButton:(id)sender {
    [self addItemToSale];
    [self updateClient];
}

- (IBAction)tappedResetSaleButton:(id)sender {
    // tap this to start and restart a sale
    [self resetCurrentSale];
}

- (IBAction)tappedCloseConnectionButton:(id)sender {
    [self.bonjourServer stop];
}

#pragma mark - Utilities

- (void)updateClient {
    [self.bonjourServer sendPayload:self.currentSale];
}

- (void)addItemToSale {
    if (!self.currentSale) {
        [self defaultSale];
    }
    NSArray *currentListOfSaleItems = self.currentSale[@"sale"][@"register_sale_products"];

    NSDictionary *someItem = @{
                               @"loyalty_value" : @0,
                               @"quantity" : @1,
                               @"sequence" : @"2",
                               @"sale_product_original_price" : @400.0,
                               @"sale_product_discount" : @0,
                               @"sale_product_new_price" : @400.0,
                               @"variants_string" : @"",
                               @"name" : @"precision product",
                               };
    NSMutableDictionary *mutableCurrentSale = [self.currentSale[@"sale"] mutableCopy];
    mutableCurrentSale[@"register_sale_products"] = [currentListOfSaleItems arrayByAddingObject:someItem];
    self.currentSale = @{
                         @"sale" : [mutableCurrentSale copy],
                         };
}

- (void)defaultSale {
    self.currentSale = @{
                         @"sale" : @{
                                 @"id" : @"some-uuid-for-this-sale",
                                 @"sale_discount" : @"",
                                 @"register_sale_products" : @[

                                         ],
                                 @"total" : @2.37,
                                 @"balance" : @2.37,
                                 @"sale_discount_amount" : @0,
                                 @"subtotal" : @2.06,
                                 @"total_tax" : @0.31,
                                 @"taxes" : @[
                                         @{
                                             @"id" : @"some uuid for a tax",
                                             @"removable" : @YES,
                                             @"name" : @"New Tax",
                                             @"total" : @0.35,
                                             @"rate" : @0.15,
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

- (void)resetCurrentSale {
    [self.bonjourServer sendPayload:@{@"sale" : @{}}];
    self.currentSale = nil;
}

@end

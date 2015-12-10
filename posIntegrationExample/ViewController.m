//
//  ViewController.m
//  posIntegrationExample
//
//  Created by Sean Wolter on 9/28/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "ViewController.h"
#import "BELBonjourServer.h"

#import "BELSale.h"
#import "BELSaleItem.h"

@interface ViewController ()

@property (nonatomic, strong) BELBonjourServer *bonjourServer;
@property (nonatomic, strong) BELSale *currentSale;

@end

@implementation ViewController

- (void)viewDidLoad {
    // display code is hard coded here, but in an actual app it should be editable
    self.bonjourServer = [[BELBonjourServer alloc] initWithDisplayCode:@"1928"];
    BOOL couldStart = [self.bonjourServer start];
    if (!couldStart) {
        NSLog(@"very bad!");
    }
    self.currentSale = [BELSale new];
}

#pragma mark - Actions

- (IBAction)tappedResetSaleButton:(id)sender {
    // tap this to start and restart a sale
    self.currentSale = [BELSale new];
    [self updateClient];
}

- (IBAction)tappedVeggiePizza:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@12.99 discount:@0 name:@"Veggie Pizza"]];
    [self updateClient];
}

- (IBAction)tappedMeatPizza:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@12.99 discount:@0 name:@"Meat Pizza"]];
    [self updateClient];
}

- (IBAction)tappedSupremoPizza:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@8.99 discount:@0 name:@"Supremo Pizza"]];
    [self updateClient];
}

- (IBAction)tappedAlfredo:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@8.99 discount:@0 name:@"Chicken Alfredo"]];
    [self updateClient];
}

- (IBAction)tappedCheeseSticks:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@4.99 discount:@1 name:@"Cheese Sticks"]];
    [self updateClient];
}

- (IBAction)tappedCrystalPepsi:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@1.38 discount:@0.5 name:@"Crystal Pepsi"]];
    [self updateClient];
}

- (IBAction)tappedSierraMist:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@1.38 discount:@0 name:@"Sierra Mist"]];
    [self updateClient];
}

- (IBAction)tappedSupremePizza:(id)sender {
    [self.currentSale addItem:[[BELSaleItem alloc] initWithPrice:@14.99 discount:@0 name:@"Supreme Pizza"]];
    [self updateClient];
}

#pragma mark - Utilities

- (void)updateClient {
    [self.bonjourServer sendPayload:self.currentSale.foundationRepresentation];
}

@end

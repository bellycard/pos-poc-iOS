//
//  BELBonjourServer.m
//  posIntegrationExample
//
//  Created by Sean Wolter on 9/28/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "BELBonjourServer.h"

@import UIKit;

@interface BELBonjourServer ()
@property (nonatomic, copy) DTBonjourDataConnection *currentConnection;
@end

@implementation BELBonjourServer

- (instancetype)initWithDisplayCode:(NSString *)displayCode {
    // this string is the unique identifier for our merchant app
    NSString *bonjourType = [NSString stringWithFormat:@"_bellypos_display_%@._tcp", displayCode];
    return [super initWithBonjourType:bonjourType];
}

- (void)connection:(DTBonjourDataConnection *)connection didReceiveObject:(id)object {
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:object options:0 error:nil];

    if ([self.currentConnection isEqual:connection]) {
        [self receivedPayload:jsonObject];
    } else {
        // if the sender is not already approved this should be a pairing request
        NSDictionary *pairingRequest = jsonObject[@"pairingRequest"];
        if (pairingRequest) {
            [self connection:connection receivedPairingRequest:pairingRequest];
        }
    }
}

- (void)connection:(DTBonjourDataConnection *)connection receivedPairingRequest:(NSDictionary *)pairingRequest {
    NSString *deviceID = pairingRequest[@"deviceIdentifier"];
    NSString *deviceName = pairingRequest[@"deviceName"];
    NSString *message = [NSString stringWithFormat:@"A %@ named %@ wants to connect with you.", deviceName, deviceID];
    // In the real app you should probably allow the user to deny the connection
    [[[UIAlertView alloc] initWithTitle:@"Connecting!" //I know this is deprecated. This is just a proof of concept. :P
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    self.currentConnection = connection;
    // if the user denied the connection in production
    // you would say [connection close] and wait for the next request

    // since this request to connect is "approved" send the configuration next
    [self sendConfiguration];
}

- (void)sendConfiguration {
    // This is hard coded for this example only
    NSDictionary *config = @{
                             @"config" : @{
                                     @"cashier_name" : @"Sean",
                                     @"register_name" : @"A Register",
                                     @"enableLoyalty" : @1,
                                     @"outlet_name" : @"An Outlet",
                                     @"retailer_name" : @"The Best Store Ever",
                                     @"displayRetailPriceTaxInclusive" : @1,
                                     }
                             };
    [self sendPayload:config];
}

- (void)receivedPayload:(NSDictionary *)payload {
    NSLog(@"received payload/n%@", payload);
}

- (BOOL)sendPayload:(NSDictionary *)payload {
    NSError *error;
    BOOL success = [self.currentConnection sendObject:payload error:&error];
    if (!success) {
        NSLog(@"ERROR SENDING PAYLOAD!/n%@", error);
    }
    return success;
}

@end

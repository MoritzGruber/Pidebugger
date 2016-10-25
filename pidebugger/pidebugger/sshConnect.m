//
//  sshConnect.m
//  pidebugger
//
//  Created by Moritz Gruber on 25/10/16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NMSSH/NMSSH.h>


NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:22"
                                       withUsername:@"user"];

if (session.isConnected) {
    [session authenticateByPassword:@"pass"];
    
    if (session.isAuthorized) {
        NSLog(@"Authentication succeeded");
    }
}

NSError *error = nil;
NSString *response = [session.channel execute:@"ls -l /var/www/" error:&error];
NSLog(@"List of my sites: %@", response);

BOOL success = [session.channel uploadFile:@"~/index.html" to:@"/var/www/9muses.se/"];

[session disconnect];

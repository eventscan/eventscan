#import <Foundation/Foundation.h>
#import "HTTPOperation.h"
#import "ProcessingParams.h"
#import <UIKit/UIKit.h>
#import "NSString+Base64.h"
#import "NSData+Base64.h"


@protocol ClientDelegate;

@interface Client : NSObject<HTTPOperationAuthenticationDelegate> {

}

@property (strong, nonatomic) NSString* applicationID;
@property (strong, nonatomic) NSString* password;


@property (strong, nonatomic) id<ClientDelegate> delegate;

- (id)initWithApplicationID:(NSString*)applicationID password:(NSString*)password;

- (void)processImage:(UIImage*)image withParams:(ProcessingParams*)params;

@end

@protocol ClientDelegate <NSObject>

@optional

- (void)clientDidFinishUpload:(Client*)sender;
- (void)clientDidFinishProcessing:(Client*)sender;
- (void)client:(Client*)sender didFinishDownloadData:(NSData*)downloadedData;
- (void)client:(Client*)sender didFailedWithError:(NSError*)error;

@end

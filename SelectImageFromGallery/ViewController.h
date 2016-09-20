

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MBProgressHUD.h"
#import "BRRequestListDirectory.h"
#import "BRRequestCreateDirectory.h"
#import "BRRequestUpload.h"
#import "BRRequestDownload.h"
#import "BRRequestDelete.h"
#import "BRRequest+_UserData.h"

@import AssetsLibrary;  
NSString *const UIImagePickerControllerMediaType;
NSString *const UIImagePickerControllerOriginalImage;
NSString *const UIImagePickerControllerEditedImage;
NSString *const UIImagePickerControllerCropRect;
NSString *const UIImagePickerControllerMediaURL;
NSString *const UIImagePickerControllerReferenceURL;
NSString *const UIImagePickerControllerMediaMetadata;
@interface ViewController : UIViewController <UINavigationControllerDelegate,
UIImagePickerControllerDelegate, NSURLConnectionDelegate,BRRequestDelegate>{
    BRRequestCreateDirectory *createDir;
    BRRequestDelete * deleteDir;
    BRRequestListDirectory *listDir;
    
    BRRequestDownload * downloadFile;
    BRRequestUpload *uploadFile;
    BRRequestDelete *deleteFile;
    __weak IBOutlet UITextField *host;
    __weak IBOutlet UITextField *path;
    __weak IBOutlet UITextField *username;
    __weak IBOutlet UITextField *password;
    
    __weak IBOutlet UITextView *logview;
    
    __weak IBOutlet UIView *buttonContainerView;
    
    NSMutableData *downloadData;
    NSData *uploadData;

    IBOutlet UILabel *response;
    NSMutableData *_responseData;
    MBProgressHUD *hud;
}

 @property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIImageView* imageView;

- (IBAction) pickImage:(id)sender;


@end


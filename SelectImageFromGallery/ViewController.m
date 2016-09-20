
#import "ViewController.h"
#import "UIImage+Resize.h"
@interface ViewController () <NSURLSessionDelegate>
{
    NSURL *resourceURL;
    NSString *filenammestr;
    NSMutableData *receiveData;
    NSURLSession  *urlSession;
    NSMutableData *body;
    NSURL* localUrl;
    NSTimer *timeOff;
    NSString *localUrlStr;
}


//---------- enumerated data types
enum enunButtons
{
    eButtonGetFile,
    eButtonPutFile,
    eButtonDeleteFile,
    eButtonMakeDirectory,
    eButtonListDirectory,
    eButtonDeleteDirectory,
    eButtonCancelAction
};



@end

@implementation ViewController
{
    NSData *pngData;
    NSData *syncResData;
  //  NSMutableURLRequest *request;
    UIActivityIndicatorView *indicator;
    NSMutableArray *ImagesArr;
    
    #define URL            @"http://www.smartbaba.in/mitesh/Upload.php"
//http://miteshpatel.orgfree.com/UploadImage/Upload_Image.php"  // change this URL
    #define NO_CONNECTION  @"No Connection"
    #define NO_IMAGE      @"NO IMAGE SELECTED"
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ImagesArr = [[NSMutableArray alloc]init];
    pngData = nil;
   // [self initPB];
}
- (void) listDirectory
{
    //listDir = [[BRRequestListDirectory alloc] initWithDelegate:self];
   // host.text=@"182.50.151.85";
   // username.text = @"isquare224";
  //  password.text = @"M%M%ishu0808";
   // path.text = @"/smartbaba.in/mitesh";
    listDir.hostname = @"182.50.151.85";;//host.text;
    listDir.path = @"/smartbaba.in/mitesh";//path.text;
    listDir.username = @"isquare224";//username.text;
    listDir.password = @"M%M%ishu0808";//password.text;
    
    [listDir start];
}

- (IBAction) pickImage:(id)sender{
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    filenammestr =  [NSString stringWithFormat:@"%ld17",currentTime];
    NSLog(@"Filename: %@",filenammestr);
    localUrl = (NSURL *)[editingInfo valueForKey:UIImagePickerControllerReferenceURL];
     localUrlStr = [editingInfo valueForKey:UIImagePickerControllerReferenceURL];
    self.imageView.image = image;
pngData = UIImageJPEGRepresentation(image,1.0);
    NSData  *imageData    = UIImageJPEGRepresentation(image, 1);
    double   factor       = 1.0;
    double   adjustment   = 1.0 / sqrt(2.0);  // or use 0.8 or whatever you want
    CGSize   size         = image.size;
    CGSize   currentSize  = size;
    UIImage *currentImage = image;
    UIImage *imagesall = image;
    while (imageData.length >= (1024 * 1024))
    {
        factor      *= adjustment;
        currentSize  = CGSizeMake(roundf(size.width * factor), roundf(size.height * factor));
        currentImage = [imagesall resizedImage:currentSize interpolationQuality:1];
        imageData    = UIImageJPEGRepresentation(currentImage, 1);
    }
    pngData = UIImagePNGRepresentation(image);
//    if ((pngData.length/1024) >= 1024) {
//        
//        while ((pngData.length/1024) >= 1024) {
//            NSLog(@"While start - The imagedata size is currently: %f KB",roundf((pngData.length/1024)));
//            
//            // While the imageData is too large scale down the image
//            
//            // Get the current image size
//            CGSize currentSize = CGSizeMake(image.size.width, image.size.height);
//                        // Resize the image
//            image = [image resizedImage:CGSizeMake(roundf(((currentSize.width/100)*95)), roundf(((currentSize.height/100)*95))) interpolationQuality:1];
//            
//            // Pass the NSData out again
//            pngData = UIImageJPEGRepresentation(image, 1);
//            
//        }
//    }
//    else
//    {
//        pngData = UIImagePNGRepresentation(image);
//
//    }
    
    
    
    [ImagesArr addObject:pngData];
    [self dismissModalViewControllerAnimated:YES];
}



//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    //NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
//   
//    UIImage *image = info[UIImagePickerControllerEditedImage];
//    if(!image)image=info[UIImagePickerControllerOriginalImage];
//    image = info[UIImagePickerControllerOriginalImage];
//    self.imageView.image = image;
//    pngData = UIImagePNGRepresentation(image);
//    [self dismissModalViewControllerAnimated:YES];
//}
//
//-(BOOL) setParams{
//    
//    if(pngData != nil){
//        
//        [indicator startAnimating];
//        
//      //  request = [NSMutableURLRequest new];
//      //  request.timeoutInterval = 20.0;
//      //  [request setURL:[NSURL URLWithString:URL]];
//       // [request setHTTPMethod:@"POST"];
//       // [request setCachePolicy:NSURLCacheStorageNotAllowed];
//        
////        NSString *boundary = @"---------------------------14737809831466499882746641449";
////        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
////        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
////        [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
////        [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.26.14 (KHTML, like Gecko) Version/6.0.1 Safari/536.26.14" forHTTPHeaderField:@"User-Agent"];
////        
//        //NSMutableData *body = [NSMutableData data];
//       // [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//     //   [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"%@.png\"\r\n", filenammestr] dataUsingEncoding:NSUTF8StringEncoding]];
////        
////        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
////        
//     //   [body appendData:[NSData dataWithData:pngData]];
////        
////        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
////        
//        
//      //  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        //[request setHTTPMethod:@"POST"];
//        //[request setURL:[NSURL URLWithString:[NSString stringWithString:@"http://yoururl.domain"]]];
//       // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//       // NSString *postLength = [NSString stringWithFormat:@"%d", [pngData length]];
//
//      //  [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//      // [request setHTTPBody:pngData];
//
//       // [request setHTTPBody:body];
//       // [request addValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
//        
//         request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:240.0];
//
//    // request = [[NSMutableURLRequest alloc] init];
//        //[request setURL:[NSURL URLWithString:URL]];
//        // [request settimeoutse:60];
//       
//        [request setHTTPShouldHandleCookies:NO];
//        [request setHTTPMethod:@"POST"];
//       // [request setTimeoutInterval:60];
//     
//        NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//        
//        body = [NSMutableData data];
//      
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"%@.png\"\r\n", filenammestr] dataUsingEncoding:NSUTF8StringEncoding]];
//       // [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", 1]] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[NSData dataWithData:pngData]];
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [request setHTTPBody:body];
//      // [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//        return TRUE;
//        
//    }else{
//        
//        response.text = NO_IMAGE;
//     
//        return FALSE;
//    }
//}

- (IBAction) uploadImageSync:(id)sender
{
//    
//    if( [self setParams]){
//        
//        NSError *error = nil;
//        NSURLResponse *responseStr = nil;
//        syncResData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseStr error:&error];
//        NSString *returnString = [[NSString alloc] initWithData:syncResData encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"ERROR %@", error);
//        NSLog(@"RES %@", responseStr);
//        
//        NSLog(@"%@", returnString);
//        
//        if(error == nil){
//            response.text = returnString;
//        }
//    
//        [indicator stopAnimating];
//    
//    }
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(uploadFiles) userInfo:nil repeats:NO];
}
- (void) uploadFiles
{
    //----- get the file to upload as an NSData object
    NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filepath = [NSString stringWithFormat: @"%@/%@", applicationDocumentsDir, @"uploadData"];
    NSString *pp =[[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3"];
    uploadData = [NSData dataWithContentsOfFile:pp];
    
    uploadFile = [[BRRequestUpload alloc] initWithDelegate:self];
    //uploadFile.path = [NSString stringWithFormat:@"%@/UploadFile1",path.text];
    //    uploadFile.hostname = host.text;
    //    uploadFile.username = username.text;
    //    uploadFile.password = password.text;
    //
    uploadFile.hostname = @"182.50.151.85";//host.text;
    uploadFile.path = @"/smartbaba.in/mitesh/Image1.png";//path.text;
    uploadFile.username = @"isquare224";//username.text;
    uploadFile.password = @"M%M%ishu0808";//password.text;
    
    [uploadFile start];
}


//-----
//
//				requestDataAvailable
//
// synopsis:	[self requestDataAvailable:request];
//					BRRequestDownload *request	-
//
// description:	requestDataAvailable is used as part of the file download.
//
// important:   This is required to download data. If this method is missing
//              and you attempt to download, you will get a runtime error.
//
// errors:		none
//
// returns:		none
//

- (void) requestDataAvailable: (BRRequestDownload *) request;
{
    [downloadData appendData: request.receivedData];
}



//-----
//
//				shouldOverwriteFileWithRequest
//
// synopsis:	retval = [self shouldOverwriteFileWithRequest:request];
//					BOOL retval       	-
//					BRRequest *request	-
//
// description:	shouldOverwriteFileWithRequest is designed to determine if it is
//              okay to overwrite a file on the server. Currently, we can not
//              overwrite directories.
//
// errors:		none
//
// returns:		Variable of type BOOL
//

-(BOOL) shouldOverwriteFileWithRequest: (BRRequest *) request
{
    //----- set this as appropriate if you want the file to be overwritten
    if (request == uploadFile)
    {
        //----- if uploading a file, we set it to YES
        return YES;
    }
    
    //----- anything else (directories, etc) we set to NO
    return NO;
}



//-----
//
//				percentCompleted
//
// synopsis:	[self percentCompleted:request];
//					BRRequest *request	-
//
// description:	percentCompleted is designed to
//
// errors:		none
//
// returns:		none
//

- (void) percentCompleted: (BRRequest *) request
{
    NSLog(@"%f completed...", request.percentCompleted);
    NSLog(@"%ld bytes this iteration", request.bytesSent);
    NSLog(@"%ld total bytes", request.totalBytesSent);
}



//-----
//
//				requestDataSendSize
//
// synopsis:	retval = [self requestDataSendSize:request];
//					long retval             	-
//					BRRequestUpload *request	-
//
// description:	requestDataSendSize is designed to
//
// important:   This is an optional method when uploading. It is purely used
//              to help calculate the percent completed.
//
//              If this method is missing, then the send size defaults to LONG_MAX
//              or about 2 gig.
//
// errors:		none
//
// returns:		Variable of type long
//

- (long) requestDataSendSize: (BRRequestUpload *) request
{
    //----- user returns the total size of data to send. Used ONLY for percentComplete
    return [uploadData length];
}



//-----
//
//				requestDataToSend
//
// synopsis:	retval = [self requestDataToSend:request];
//					NSData *retval          	-
//					BRRequestUpload *request	-
//
// description:	requestDataToSend is designed to hand off the BR the next block
//              of data to upload to the FTP server. It continues to call this
//              method for more data until nil is returned.
//
// important:   This is a required method for uploading data to an FTP server.
//              If this method is missing, it you will get a runtime error indicating
//              this method is missing.
//
// errors:		none
//
// returns:		Variable of type NSData *
//

- (NSData *) requestDataToSend: (BRRequestUpload *) request
{
    //----- returns data object or nil when complete
    //----- basically, first time we return the pointer to the NSData.
    //----- and BR will upload the data.
    //----- Second time we return nil which means no more data to send
    NSData *temp = uploadData;                                                  // this is a shallow copy of the pointer, not a deep copy
    
    uploadData = nil;                                                           // next time around, return nil...
    
    return temp;
}



//-----
//
//				requestCompleted
//
// synopsis:	[self requestCompleted:request];
//					BRRequest *request	-
//
// description:	requestCompleted is designed to
//
// errors:		none
//
// returns:		none
//

-(void) requestCompleted: (BRRequest *) request
{
    if (request == createDir)
    {
        NSLog(@"%@ completed!", request);
        
        createDir = nil;
    }
    
    if (request == deleteDir)
    {
        NSLog(@"%@ completed!", request);
        
        deleteDir = nil;
    }
    
    if (request == listDir)
    {
        //called after 'request' is completed successfully
        NSLog(@"%@ completed!", request);
        
        //we print each of the files name
        for (NSDictionary *file in listDir.filesInfo)
        {
            NSLog(@"%@", [file objectForKey:(id)kCFFTPResourceName]);
            
            logview.text = [NSString stringWithFormat: @"%@\n%@", logview.text, [file objectForKey:(id)kCFFTPResourceName]];
        }
        
        logview.text = [NSString stringWithFormat: @"%@\n", logview.text];
        [logview scrollRangeToVisible: NSMakeRange([logview.text length] - 1, 1)];
        
        NSLog(@"%@", listDir.filesInfo);
        
        listDir = nil;
    }
    
    if (request == downloadFile)
    {
        //called after 'request' is completed successfully
        NSLog(@"%@ completed!", request);
        
        NSError *error;
        
        //----- save the downloadData as a file object
        NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filepath = [NSString stringWithFormat: @"%@/%@", applicationDocumentsDir, @"image.jpg"];
        
        [downloadData writeToFile: filepath options: NSDataWritingFileProtectionNone error: &error];
        downloadData = nil;
        downloadFile = nil;
    }
    
    if (request == uploadFile)
    {
        NSLog(@"%@ completed!", request);
        uploadFile = nil;
    }
    
    if (request == deleteFile)
    {
        NSLog(@"%@ completed!", request);
        deleteFile = nil;
    }
    
}



//-----
//
//				requestFailed
//
// synopsis:	[self requestFailed:request];
//					BRRequest *request	-
//
// description:	requestFailed is designed to
//
// errors:		none
//
// returns:		none
//

-(void) requestFailed:(BRRequest *) request
{
    if (request == createDir)
    {
        NSLog(@"%@", request.error.message);
        
        createDir = nil;
    }
    
    if (request == deleteDir)
    {
        NSLog(@"%@", request.error.message);
        
        deleteDir = nil;
    }
    
    if (request == listDir)
    {
        logview.text = [NSString stringWithFormat: @"%@\n\nList Dir Failed with %@", logview.text, request.error.message];
        
        //called if 'request' ends in error
        //we can print the error message
        NSLog(@"%@", request.error.message);
        
        listDir = nil;
    }
    
    if (request == downloadFile)
    {
        NSLog(@"%@", request.error.message);
        
        downloadFile = nil;
    }
    
    if (request == uploadFile)
    {
        NSLog(@"%@", request.error.message);
        
        uploadFile = nil;
    }
    
    if (request == deleteFile)
    {
        NSLog(@"%@", request.error.message);
        deleteFile = nil;
    }
}



//-----
//
//				clearLog
//
// synopsis:	retval = [self clearLog:button];
//					IBAction retval	-
//					id button      	-
//
// description:	clearLog is designed to
//
// errors:		none
//
// returns:		Variable of type IBAction
//

- (IBAction) clearLog: (id) button
{
    logview.text = nil;
}


//
//- (IBAction) uploadImageAsync1:(id)sender
//{
//
//     if( [self setParams]){
//    
//        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//        
//        // Loads the data for a URL request and executes a handler block on an operation queue when the request completes or fails.
//        [NSURLConnection sendAsynchronousRequest:request
//                                           queue:queue
//                               completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
//                                   NSLog(@"Completed");
//                                   
//                                   response.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   
//                                   [indicator stopAnimating];
//                                   [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
//                                   
//                                   if (error) {
//                                       NSLog(@"error:%@", error.localizedDescription);
//                                   }
//                                  
//                               }];
//     }
//    
//
//}
//
//- (IBAction) uploadImageAsync2:(id)sender{
//    
////     if( [self setParams]){
////    
////         // Returns an initialized URL connection and begins to load the data for the URL request.
////         if([[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES]){
////         
////         };
////         
//    // }
//      NSMutableURLRequest *request;
//    NSString *POST_BODY_BOURDARY = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
//NSURL *url =[NSURL URLWithString:@"http://www.smartbaba.in/mitesh/UploadFile.php"];
//    
//  //  NSURL *url =[NSURL URLWithString:@"http://www.taxipapa.com/mitesh//UploadFile.php"];
//
// //   [NSURL URLWithString:@"http://miteshpatel.orgfree.com/UploadImage/UploadFile.php"];
//    request = [NSMutableURLRequest requestWithURL:url]; //cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    [request setTimeoutInterval:3000];
//    
//        [request setHTTPMethod:@"POST"];
//        NSString *contentTypeValue = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", POST_BODY_BOURDARY];
//        [request addValue:contentTypeValue forHTTPHeaderField:@"Content-type"];
//        
//        NSMutableData *dataForm = [NSMutableData alloc];
//        [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",POST_BODY_BOURDARY] dataUsingEncoding:NSUTF8StringEncoding]];
//        [dataForm appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"param1\";\r\n\r\n%@", filenammestr] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//        if([ImagesArr count] > 0) {
//          
//            for(int i=0 ; i < ImagesArr.count; i++)
//            {
//                long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
//                filenammestr =  [NSString stringWithFormat:@"%ld17",currentTime];
//                NSLog(@"Filename: test%@%d",filenammestr,i);
//                
//                [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",POST_BODY_BOURDARY] dataUsingEncoding:NSUTF8StringEncoding]];
//                [dataForm appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileToUpload[]\"; filename=\"%@%@%d.jpg\"\r\n", @"test", filenammestr,i] dataUsingEncoding:NSUTF8StringEncoding]];
//                [dataForm appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//                [dataForm appendData:[NSData dataWithData:[ImagesArr objectAtIndex:i]]];
//                
//            }
//            
//        }
//        
//        [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",POST_BODY_BOURDARY] dataUsingEncoding:NSUTF8StringEncoding]];
////    
////    
////        NSURLSessionUploadTask *uploadTask = [urlSession uploadTaskWithRequest:request fromData:dataForm];
////        [uploadTask resume];
//    
//    
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    sessionConfiguration.timeoutIntervalForRequest = 3000.0;
//    sessionConfiguration.timeoutIntervalForResource = 3000.0;
//    urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
//    
//    NSURLSessionUploadTask *uploadTask = [urlSession uploadTaskWithRequest:request fromData:dataForm];
//    hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
//    [hud show:YES];
//    [uploadTask resume];
//    
////    
////    
////    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
////    [manager GET:@"foo" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
////        NSLog(@"%@", responseObject);
////        
////    } failure:^(NSURLSessionDataTask *task, NSError *error) {
////        NSLog(@"%@", error.localizedDescription);
////        
////    } retryCount:5 retryInterval:2.0 progressive:false fatalStatusCodes:@[@401, @403]];
////    
////    
////    
////    
////    
//    
//    
//    
//    
//  /*
//  if( [self setParams]){
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
//
//    NSURLSessionUploadTask *uploadTask = [urlSession uploadTaskWithRequest:request fromData:body];
//
//    [uploadTask resume];
//  }
//    else
//    {
//        [self setParams];
//       
//        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        sessionConfiguration.timeoutIntervalForRequest = 60.0;
//        sessionConfiguration.timeoutIntervalForResource = 200.0;
//        urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
//        
//        NSURLSessionUploadTask *uploadTask = [urlSession uploadTaskWithRequest:request fromData:body];
//        
//        [uploadTask resume];
//    }
//*/
//    
//}
//
//
//- (IBAction)Video:(id)sender{
//  
//   // [ftp addFile:@"file2" :@"ftppath"];
//    
//}
//
//- (IBAction) uploadImageAsync3:(id)sender{
//    
//    if( [self setParams]){
//        
//       //Creates and returns an initialized URL connection and begins to load the data for the URL request.
//        
//        if([NSURLConnection connectionWithRequest:request delegate:self]){
//            
//        };
//    }
//    
//}
////When a file is uploaded or failed, this function is called with the particular response code and string
//-(void) fileUploadResponse:(BOOL)success:(int)responseCode:(NSString*)responseString{}
//
////When all files have been uploaded this is called
//-(void) allFilesUploaded{}
//
////Exact progress of file being uploaded (currently does not support which file it is)
//-(void) progress:(float)progress{}
//
//-(void) initPB{
//    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)/2, ([UIScreen mainScreen].bounds.size.height)/2 , 40.0, 40.0);
//    indicator.center = self.view.center;
//    [self.view addSubview:indicator];
//    [indicator bringSubviewToFront:self.view];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
//}
//
//#pragma mark NSURLConnection Delegate Methods
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    // A response has been received, this is where we initialize the instance var you created
//    // so that we can append data to it in the didReceiveData method
//    // Furthermore, this method is called each time there is a redirect so reinitializing it
//    // also serves to clear it
//    _responseData = [[NSMutableData alloc] init];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    // Append the new data to the instance variable you declared
//    [_responseData appendData:data];
//}
//
//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
//                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
//    // Return nil to indicate not necessary to store a cached response for this connection
//    return nil;
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    // The request is complete and data has been received
//    // You can parse the stuff in your instance variable now
//    
//    
//    response.text = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"_responseData %@", response.text);
//    
//    [indicator stopAnimating];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
//    
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    // The request has failed for some reason!
//    // Check the error var
//    
//    NSLog(@"didFailWithError %@", error);
//    
//}


/*
 ViewController.h
 #import <uikit /UIKit.h>
 
 @interface ViewController : UIViewController <nsurlconnectiondatadelegate>
 
 @property (weak, nonatomic) IBOutlet UIProgressView *progressView;
 @property (weak, nonatomic) IBOutlet UIImageView *imageView;
 @property (nonatomic, weak) IBOutlet UIButton   *btn_download;
 @property (nonatomic, weak) IBOutlet UILabel   *lbl_download;
 
 @end
 ViewController.m
 
 #import "ViewController.h"
 
 @interface ViewController ()
 
 @property (strong, nonatomic) NSURLConnection *connectionManager;
 @property (strong, nonatomic) NSMutableData *downloadedMutableData;
 @property (strong, nonatomic) NSURLResponse *urlResponse;
 
 @end
 
 @implementation ViewController{
 
 #define IMAGE_URL @"http://img1.wikia.nocookie.net/__cb20111229061816/lego/images/b/b8/Ws-space-apple-logo.jpg"
 }
 
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 
 -(IBAction)downloadImage :(id)sender{
 
 self.btn_download.enabled = NO;
 self.downloadedMutableData = [[NSMutableData alloc] init];
 NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:IMAGE_URL]
 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
 timeoutInterval:60.0];
 self.connectionManager = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
 
 }
 
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 }
 
 #pragma mark - Delegate Methods
 -(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
 NSLog(@"%lld", response.expectedContentLength);
 self.urlResponse = response;
 }
 
 -(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
 [self.downloadedMutableData appendData:data];
 self.progressView.progress = ((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length)/100;
 
 float per = ((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length);
 self.lbl_download.text = [NSString stringWithFormat:@"%0.f%%", per];
 
 if (self.progressView.progress == 1) {
 self.progressView.hidden = YES;
 self.btn_download.enabled = YES;
 } else {
 self.progressView.hidden = NO;
 }
 
 }
 
 -(void)connectionDidFinishLoading:(NSURLConnection *)connection {
 self.imageView.image = [UIImage imageWithData:self.downloadedMutableData];
 self.lbl_download.text = @"Download Complete";
 }
 
 @end
 */

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    //    [self.downloadedMutableData appendData:data];
    // float per = ((100.0/totalBytesSent)*bytesSent);
    //int result = (int)roundf(per);
    //int total = 100 - result;
    ///  self.progressView.progress = result/100;
    
    // ((100.0/totalBytesExpectedToSend)*totalBytesSent)/100;
    //
    //float per = ((100.0/totalBytesSent)*bytesSent);
    //    self.lbl_download.text = [NSString stringWithFormat:@"%0.f%%", per];
    int64_t percentage = ( totalBytesSent * 100 )/ totalBytesExpectedToSend;
    
    
    hud.labelText = [NSString stringWithFormat:@"%lld",percentage];
   
    
    NSLog(@"Process: %lld,Sent %lld, Total sent: %lld, %lld, Not Sent %lld ",percentage, bytesSent, totalBytesSent, totalBytesExpectedToSend);
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    receiveData = [NSMutableData data];
    
    [receiveData setLength:0];
    
    completionHandler(NSURLSessionResponseAllow);
    NSLog(@"NSURLSession Starts to Receive Data");
    
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    [receiveData appendData:data];
  
    
    response.text = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    
    NSLog(@"NSURLSession Receive Data");
    
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    NSLog(@"URL Session Complete: %@", task.response.description);
    
    
    
    if(error != nil) {
        
        NSLog(@"Error %@",[error userInfo]);
        
    } else {
        
        NSLog(@"Uploading is Succesfull");
        
        
        
        NSString *result = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", result);
        
    }
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [hud hide:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

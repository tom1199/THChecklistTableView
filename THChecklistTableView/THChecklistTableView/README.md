THCheckboxList
==============

THChecklistItem:
- Subclass of NSObject
- It need be subclassed to work with THChecklistItemCell. 
- Abstracted function must be implemented in the subclass.
- When cells are asking for the content for displaying, the derived class is responsible for providing the information such as title, checkbox value.
- You can attach your own data modal to it for the future use.

THChecklistItemCell:
- Subclass of UITableViewCell.
- It provide customised title label and checkbox.
- Rely on THChecklistItem to provide content.
- User can customise the checkbox by providing their images.
  
THChecklistTableViewController:
- Subclass of UITableViewController.
- By passing an Array of THChecklistItem subclass as its data source.
- Users are able to insert item right on the built in text field.
- Auto sort items base on the boolean value from the checkbox 

THChecklistTableViewControllerDelegate:
- It responsible for providing the recognised data modal instance to table view
- it will be notified when user is about to exist the table view. (Typically, you need copy the changes user has been made)
 
Example:
//1. Creating data modal - MyDataModalItem is subclass of THChecklistItem
for (int i = 0; i < ITEM_COUNT; i++) {
     dataModal = [[MyDataModal alloc]init];            
     dataModalItem = [[MyDataModalItem alloc]initWithDataModal:dataModal];
     [dataSource addObject:dataModalItem];
}

//2. Instantiate THChecklistTableViewController and pass the data source to it
THChecklistTableViewController *checklistTableViewController = [[THChecklistTableViewController alloc]initWithStyle:UITableViewStylePlain];
    checklistTableViewController.data = self.dataSource;
    checklistTableViewController.delegate = self;

//3. In THChecklistItem subclass, implement below methods to tell Cell what kind of information you would like it to be shown
- (NSString *)title {
    return self.dataModal.name;
}
- (void)setTitle:(NSString *)title {
    self.dataModal.name = title;
}
- (BOOL)isChecked {
    return self.dataModal.hasAccomplished;
}
- (void)setIsChecked:(BOOL)isChecked {
    self.dataModal.hasAccomplished = isChecked;
}
// 4. You may need to retain the changes user has been made, so do it on the delegate callback
- (void)checklistTableViewController:(THChecklistTableViewController *)controller willExitWithData:(NSMutableArray *)data {
    self.dataSource = data;
}
// 5. Provide table view your own data modal(THChecklistItem subclass)
- (THChecklistItem *)checklistItem {
    MyDataModal *dataModal = [[MyDataModal alloc]init];    
    return [[MyDataModalItem alloc]initWithDataModal:dataModal];
}

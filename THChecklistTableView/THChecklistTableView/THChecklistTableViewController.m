//
//  THChecklistTableViewController.m
//  THChecklistTableView
//
//  Created by Tang Han on 30/1/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import "THChecklistTableViewController.h"
#import "THChecklistItem.h"
#import "NSMutableArray+ObjectMove.h"

@interface THChecklistTableViewController ()
@property (nonatomic,strong)UITextField *textField;
@end

#define TABLE_VIEW_ITEM_INDEX_START 1
#define TEXT_FIELD_OFFSET_X 14.0f
#define TABLE_VIEW_CELL_WIDTH   320.0f
#define TABLE_VIEW_CELL_HEIGHT  44.0f
static CGRect textFieldFrame = {TEXT_FIELD_OFFSET_X,0,TABLE_VIEW_CELL_WIDTH - 2 * TEXT_FIELD_OFFSET_X,TABLE_VIEW_CELL_HEIGHT};

@implementation THChecklistTableViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        self.tableView.separatorColor = [UIColor clearColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEdit:)];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.delegate checklistTableViewController:self willExitWithData:self.data];
}
- (void)setData:(NSMutableArray *)data {
    _data = data;
    
    [self sortData];
    
    //Group data source in to different array    
    [self.tableView reloadData];
}
- (void)sortData {
    //Sort data by checked/uncheck
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"isChecked" ascending:YES];
    [_data sortedArrayUsingDescriptors:@[sortDescriptor]];
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:textFieldFrame];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.placeholder = @"Add new item...";
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _textField.autocorrectionType = UITextAutocorrectionTypeYes;
        _textField.spellCheckingType = UITextSpellCheckingTypeYes;
        _textField.returnKeyType = UIReturnKeyNext;
    }
    return _textField;
}
- (void)toggleEdit:(id)sender {
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
    }else {
        [self.tableView setEditing:YES animated:YES];
    }
}
- (void)insertUncheckedItem:(THChecklistItem *)item {
    //update modal
    [self.data insertObject:item atIndex:0];
    
    //update table view
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:TABLE_VIEW_ITEM_INDEX_START inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count + 1;  //addtional 1 row is for input text field;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ChecklistItemCellIdentifier = @"ChecklistCell";
    static NSString *TextFieldCellIdentifier = @"TextFieldCell";
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 && indexPath.row == 0) {   //text field row
        cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextFieldCellIdentifier];
            [cell addSubview:self.textField];
        }
    }else { //item cells
        //retrive reusable cell
        cell = [tableView dequeueReusableCellWithIdentifier:ChecklistItemCellIdentifier];
        if (!cell) {
            cell = [[THChecklistItemCellDefault alloc]initWithUncheckImage:[UIImage imageNamed:[self.delegate uncheckedImage]]
                                                                checkImage:[UIImage imageNamed:[self.delegate checkedImage]]
                                                           reuseIdentifier:ChecklistItemCellIdentifier];
            ((THChecklistItemCellDefault *)cell).delegate = self;
        }
        
        //configure cell
        id item = [self.data objectAtIndex:indexPath.row - 1];
        if ([item isKindOfClass:[THChecklistItem class]]) {
            ((THChecklistItemCellDefault *)cell).titleLabel.text = ((THChecklistItem *)item).title;
            ((THChecklistItemCellDefault *)cell).isChecked = ((THChecklistItem *)item).isChecked;
        }
    }
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) { //text field row
        return NO;
    }
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) { //text field row
        return NO;
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete selected cell content from modal
        [self.data removeObjectAtIndex:indexPath.row - 1];
        
        //update table view
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Push in the detail view controller for the selected item
    
}

#pragma mark - THChecklistItemCellDelegate
- (void)cell:(THChecklistItemCellDefault *)cell checkboxValueDidChangeWithValue:(BOOL)value {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    
    //modify the data modal here
    THChecklistItem *checklistItem = [self.data objectAtIndex:cellIndexPath.row - 1];
    checklistItem.isChecked = value;
    
    if (value == YES) {
        [_data moveObjectFromIndex:cellIndexPath.row - 1 toIndex:_data.count - 1];
    }else {
        [_data moveObjectFromIndex:cellIndexPath.row - 1 toIndex:0];
    }

    //update table view
    [self.tableView beginUpdates];
    unsigned int sectionTo = 0;
    unsigned int rowTo = value == YES ? [self.tableView numberOfRowsInSection:0] - 1: TABLE_VIEW_ITEM_INDEX_START;
    NSIndexPath *indexPathTo = [NSIndexPath indexPathForItem:rowTo inSection:sectionTo];
    [self.tableView moveRowAtIndexPath:cellIndexPath toIndexPath:indexPathTo];
    [self.tableView endUpdates];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.textField.isEditing) {
        [self.textField resignFirstResponder];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [self.textField resignFirstResponder];
    }else {
        //add new item to list
        THChecklistItem *item = [self.delegate checklistItem];
        item.isChecked = NO;
        item.title = textField.text;
        [self insertUncheckedItem:item];
        textField.text = @"";
    }
    return YES;
}
@end





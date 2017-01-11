
// AUTHOR NOTE: This method returns the nearest number in an array relative to a specified targeted number

- (NSNumber*)getClosestNumber:(NSArray*)dataSet targetToGetNear:(NSNumber*)target shouldRoundUpIfNeedBe:(bool)shouldRoundUp {
    
    // Check to make sure data set is not empty
    if ([dataSet count] < 1) { return nil; }
    
    // Sort the data set from least to greatest
    dataSet = [dataSet sortedArrayUsingSelector: @selector(compare:)];
    
    // Declare range start and end points
    NSNumber *rangeStart = 0;
    NSNumber *rangeEnd = 0;
    
    // If target is greater than last object return the last object since it would be the closest
    if ([target doubleValue] > [(NSNumber*)[dataSet lastObject] doubleValue]) {
        return (NSNumber*)[dataSet lastObject];
    }
    
    // If target is less than first object return the last object since it would be the closest
    if ([target doubleValue] < [(NSNumber*)[dataSet firstObject] doubleValue]) {
        return (NSNumber*)[dataSet firstObject];
    }
    
    // Iterate through data set to evaluate closest number possibilities
    for (int i = 0; i < [dataSet count]; i++) {
        
        // Check for potential ranges
        if ([target doubleValue] > [(NSNumber*)dataSet[i] doubleValue]) {
            
            // Make sure next index exists
            if (dataSet[i + 1] != nil) {
                
                // Check if target is inbetween indicated range
                if ([target doubleValue] < [(NSNumber*)dataSet[i + 1] doubleValue]) {
                    
                    // Match for range found
                    rangeStart = (NSNumber*)dataSet[i];
                    rangeEnd = (NSNumber*)dataSet[i + 1];
                    break;
                }
            }
        }
        else if ((NSNumber*)dataSet[i] == target) {
            
            // Data set contains targeted number, return the matched index
            return (NSNumber*)dataSet[i];
        }
        
    }
    
    // Find out distance between each range index
    NSNumber *distanceFromStart = @([target intValue] - [rangeStart intValue]);
    NSNumber *distanceFromEnd = @([rangeEnd intValue] - [target intValue]);
    
    // Create var to store closest index
    NSNumber *closestIndex = 0;
    
    // Determine which index is closer
    if ([distanceFromStart doubleValue] < [distanceFromEnd doubleValue]) {
        closestIndex = rangeStart;
    }
    else if ([distanceFromStart doubleValue] == [distanceFromEnd doubleValue]) {
        // Number is dead between two indexes
        // Figure out whether to round up or down then do so
        if (shouldRoundUp) { closestIndex = rangeEnd; } else { closestIndex = rangeStart; }
        
    }
    else {
        closestIndex = rangeEnd;
    }
       
    return closestIndex;
}



// MARK: Usage

NSNumber *closestNumber = [self getClosestNumber:@[@0, @100, @200, @300, @400, @500, @600, @700, @800, @900, @1000] targetToGetNear:[NSNumber numberWithInt:123] shouldRoundUpIfNeedBe:true];
    
NSLog(@"%@", closestNumber); // Outputs "100"





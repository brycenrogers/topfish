
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
//Parse.Cloud.define("hello", function(request, response) {
//  response.success("Hello world!");
//});

Parse.Cloud.job("addUpBSVotes", function(request, status) {
    // Set up to modify user data
    Parse.Cloud.useMasterKey();
    var counter = 0;
                
    var BSVote = Parse.Object.extend("BSVote");
    var Catch = Parse.Object.extend("Catch");
                
    var catchVoteQuery = new Parse.Query(BSVote);
    
    catchVoteQuery.each(function(catchBSVote) {
        
        catchBSVote.catch.BSCount = catchBSVote.catch.BSCount + 1;
                        
        catchBSVote.catch.save()
               
           }).then(function() {
                   // Set the job's success status
                   status.success("Updated BSVotes");
                   }, function(error) {
                   // Set the job's error status
                   status.error("Uh oh, something went wrong.");
                   });
});
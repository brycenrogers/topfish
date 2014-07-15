Parse.Cloud.define("sendMail", function(request, response) {
  var Mandrill = require('mandrill');
  Mandrill.initialize('KFG4iDCWhDN7x07832G-tw');

  Mandrill.sendEmail({
    message: {
      text: request.params.text,
      subject: request.params.subject,
      from_email: request.params.fromEmail,
      from_name: request.params.fromName,
      to: [
        {
          email: request.params.toEmail1,
          name: request.params.toName1
        },
        {
          email: request.params.toEmail2,
          name: request.params.toName2
        }
      ]
    }, async: true},
    {
      success: function(httpResponse) {
        console.log(httpResponse);
        response.success("Email sent!"); 
      },
      error: function(httpResponse) {
        console.error(httpResponse);
        response.error("Uh oh, something went wrong");
      }
    });
});

Parse.Cloud.define("deleteUser", function(request, response) {
  Parse.Cloud.httpRequest({
    method: 'DELETE',
    url: 'https://api.parse.com/1/users/' + request.params.userObjectId,
    headers: {
      "X-Parse-Application-Id": "TrlIuUXUHR2J3B8SBRFO9uaE14ivibSUBFQOih0Z",
      "X-Parse-REST-API-Key": "GNTuCrdhTnQS5yQmrAqHppXqXAJxLfxA9rb60Dza",
      "X-Parse-Master-Key": "C9xs8b6QtJlOpZUbVHFnHBkD8g90ZE5FjNqrHbms"
    },
    success: function(httpResponse) {
      console.log(httpResponse.text);
      response.success("User Deleted"); 
    },
    error: function(httpResponse) {
      console.error('Request failed with response code ' + httpResponse.status);
      response.error("Could not delete user. Error code: " + httpResponse.status); 
    }
  });
});
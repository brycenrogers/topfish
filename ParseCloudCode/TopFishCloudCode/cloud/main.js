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
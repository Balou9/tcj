exports.handler = function(event) {

  var responseBody = {
    "message": "chale"
  }

  return {
    "statusCode": 200,
    "headers": { "Content-Type": "application/json" },
    "body": JSON.stringify(responseBody),
    "isBase64Encoded": false
  }

}

module.exports.handler = (event, context, callback) => {

  var response = {
    "statusCode": 204,
    "headers": {
      "content-type": "application/json",
    },
    "body": ''
  }

  callback(null, response)

}

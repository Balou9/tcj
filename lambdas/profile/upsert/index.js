module.exports.handler = (event, context, callback) => {
  var payload = {"profileUuid": "chalee914"}

  var response = {
    "statusCode": 204,
    "headers": {
      "content-type": "application/json",
    },
    "body": ''
  }

  callback(null, response)

}

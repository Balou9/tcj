module.exports.handler = (event, context, callback) => {
  var payload = {"profileId": "chalee914"}

  var response = {
    "statusCode": 200,
    "headers": {
      "content-type": "application/json",
    },
    "body": JSON.stringify(payload)
  }

  callback(null, response)

}

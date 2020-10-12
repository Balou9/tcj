module.exports.handler = (event, context, callback) => {
  var payload = {"profileUuid": "chalee914"}

  var response = {
    "statusCode": 200,
    "headers": {
      "content-type": "application/json",
    },
    "body": JSON.stringify(payload)
  }

  return { statusCode: 200 }

}

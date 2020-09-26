module.exports.handler = async function handler(event, context) => {

  var response = {
    "statusCode": 204,
    "headers": {
      "content-type": "application/json",
    },
    "body": ''
  }

  return response

}

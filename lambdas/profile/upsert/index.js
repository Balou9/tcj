const AWS = require('aws-sdk')
const { v4: uuidv4 } = require('uuid')
const dynamodb = new AWS.DynamoDB.DocumentClient({apiVersion: '2012-08-10'})

module.exports.handler = (event, context, callback) => {
  console.log("DEBUG:::", event)

  if (!event.body || !event.body.length) {
    callback(null, response(400))
  } else {

    const params = {
      TableName: process.env.PROFILE_TABLE_NAME,
      Item: {
        "profile_id": profileId(),
        "profile": JSON.parse(event.body)
      }
    }

    dynamodb.put(params, function (err, data) {
      if (err) callback(err)
      else callback(null, response(204))
    })
  }

}

function profileId () {
  var profile_ID = "mid_" + uuidv4()
  return profile_ID
}

function response (status) {
  return {
    "statusCode": status,
    "headers": {
      "content-type": "application/json"
    }
  }
}

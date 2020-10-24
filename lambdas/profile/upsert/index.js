const AWS = require('aws-sdk')
const { v4: uuidv4 } = require('uuid')
const dynamodb = new AWS.DynamoDB.DocumentClient({apiVersion: '2012-08-10'})

module.exports.handler = (event, context, callback) => {

  var params = {
    TableName: process.env.PROFILE_TABLE_NAME,
    Item: {
      "profile_id": uuidv4(),
      "profile": event.body
    }
  }


  var response = {
    "statusCode": 204,
    "headers": {
      "content-type": "application/json",
    },
    "body": ''
  }

  callback(null, response)

}

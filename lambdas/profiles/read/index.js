const AWS = require('aws-sdk')
const dynamodb = new AWS.DynamoDB.DocumentClient({apiVersion: '2012-08-10'})

module.exports.handler = async function handler ({
  pathParameters
}) {

  const params = {
    TableName : process.env.PROFILE_TABLE_NAME,
    Key: {
      "profile_id": pathParameters.profile_id
    }
  }

  const data = await dynamodb.get(params).promise()

  return {
    "statusCode": 200,
    "headers": {
      "content-type": "application/json",
    },
    "body": JSON.stringify(data)
  }

}

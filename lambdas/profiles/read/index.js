const AWS = require('aws-sdk')
const dynamodb = new AWS.DynamoDB.DocumentClient({apiVersion: '2012-08-10'})

module.exports.handler = async function handler ({
  pathParameters
}) {

  const params = {
    TableName : process.env.PROFILE_TABLE_NAME,
    Key: {
      "profileName": pathParameters.profileName
    }
  }

  const payload = await dynamodb.get(params).promise()

  if (!data || JSON.stringify(data) === "{}" ) {
    return { statusCode: 404 }
  }

  return {
    "statusCode": 200,
    "headers": {
      "content-type": "application/json",
    },
    "body": JSON.stringify(payload)
  }

}

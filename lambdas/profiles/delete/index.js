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

  await dynamodb.delete(params).promise()

  return { "statusCode": 204 }

}

if (!process.env.PROFILE_TABLE_NAME) {
  throw new Error("missing required env var PROFILE_TABLE_NAME");
}

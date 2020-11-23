const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01"
})

module.exports.handler = async function handler ({
  pathParameters
}) {

  const params = {
    Bucket: process.env.BUCKET_NAME,
    Key: pathParameters.profileName,
    Key: {
      "profileName": pathParameters.profileName
    }
  }

  const payload = await dynamodb.get(params).promise()

  if (!payload || JSON.stringify(payload) === "{}" ) {
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

if (!process.env.BUCKET_NAME) {
  throw new Error("missing required env var BUCKET_NAME");
}

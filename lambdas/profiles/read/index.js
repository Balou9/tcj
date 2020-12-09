const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01"
})

module.exports.handler = async function handler ({
  event,
  context
  headers,
  pathParameters
}) {

  const key = pathParameters.profileName
  const bucket = process.env.BUCKET_NAME

  const keyExists = await exists(key)

  console.log("DEBUG:::",
    "HEADERS:::", headers,
    "EVENT:::", event,
    "KEY:::", key,
    "BUCKET:::", bucket,
    "Key exists:::", keyExists
  )

  const params = {
    Bucket: process.env.BUCKET_NAME,
    Key: pathParameters.profileName,
  }

  const payload = await s3.getObject(params).promise()

  console.log("PAYLOAD:::", payload)
  //
  // if (!payload || JSON.stringify(payload) === "{}" ) {
  //   return { statusCode: 404 }
  // }

  return {
    "statusCode": 200,
    "headers": {
      "content-type": "application/json",
    },
    "body": JSON.stringify(payload)
  }

}

async function exists(key) {
  try {
    await s3.headObject({ Key: key }).promise();
    return true;
  } catch (err) {
    if (err.code === "NotFound") {
      return false;
    } else {
      throw err;
    }
  }
}

if (!process.env.BUCKET_NAME) {
  throw new Error("missing required env var BUCKET_NAME");
}

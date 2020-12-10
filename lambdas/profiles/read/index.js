const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01",
  params: { Bucket: process.env.BUCKET_NAME }
})

module.exports.handler = async function handler (event, context) {

  console.log("DEBUG:::",
    "EVENT:::", event,
    "BUCKET:::", s3,
  )

  const params = {
    Key: event.pathParameters.profileName,
  }

  // const payload = await s3.getObject(params).promise()

  // console.log("PAYLOAD:::", payload)


  try {

    const payload = await s3.getObject(params).promise()
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

  } catch (err) {
    return {
      "statusCode": err.code,
      "body": err.message
    }
  }

}

if (!process.env.BUCKET_NAME) {
  throw new Error("missing required env var BUCKET_NAME");
}

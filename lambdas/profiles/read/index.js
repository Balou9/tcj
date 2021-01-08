const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01",
  params: { Bucket: process.env.BUCKET_NAME }
})

module.exports.handler = async function (event, context) {
  try {
    if (!event.profileName) {
      return { statusCode: 400 }
    }

    const payload = await s3.getObject({
      Key: event.profileName
    }).promise()
    console.log("DEBUG:::Payload", payload)
    return {
      statusCode: 200,
      body: JSON.stringify(payload)
    }
  } catch (err) {
    if ( err.code === "NoSuchKey" ) {
      return { statusCode: 404 }
    }
    return { statusCode: 500 }
  }
}

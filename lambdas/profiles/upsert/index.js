const { S3 } = require('aws-sdk')
const s3 = new S3({
  apiVersion: '2006-03-01',
  params: { Bucket: process.env.BUCKET_NAME }
})

module.exports.handler = async function (event, context) {
  try {
    if (!event.profileName) {
      return { statusCode: 400 }
    }

    await s3.putObject({
      Key: event.profileName,
      Body: JSON.stringify({ score: 0 })
    }).promise()

    return { statusCode: 204 }
  } catch (err) {
    return { statusCode: 500 }
  }
}

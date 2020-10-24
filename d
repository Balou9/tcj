[1mdiff --git a/lambdas/profile/upsert/index.js b/lambdas/profile/upsert/index.js[m
[1mindex 9517efd..5ebc025 100644[m
[1m--- a/lambdas/profile/upsert/index.js[m
[1m+++ b/lambdas/profile/upsert/index.js[m
[36m@@ -2,7 +2,7 @@[m [mconst AWS = require('aws-sdk')[m
 const { v4: uuidv4 } = require('uuid')[m
 const dynamodb = new AWS.DynamoDB.DocumentClient({apiVersion: '2012-08-10'})[m
 [m
[31m-module.exports.handler = async function handler(event, context) => {[m
[32m+[m[32mmodule.exports.handler = function handler(event, context, callback) => {[m
 [m
   var params = {[m
     TableName: process.env.PROFILE_TABLE_NAME,[m
[36m@@ -12,8 +12,15 @@[m [mmodule.exports.handler = async function handler(event, context) => {[m
     }[m
   }[m
 [m
[31m-  await dynamodb.put(params).promise()[m
 [m
[31m-  return { "statusCode": 204 }[m
[32m+[m[32m  var response = {[m
[32m+[m[32m    "statusCode": 204,[m
[32m+[m[32m    "headers": {[m
[32m+[m[32m      "content-type": "application/json",[m
[32m+[m[32m    },[m
[32m+[m[32m    "body": ''[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m  callback(null, response)[m
 [m
 }[m
[1mdiff --git a/stack.yml b/stack.yml[m
[1mindex dc8bd3e..330e794 100644[m
[1m--- a/stack.yml[m
[1m+++ b/stack.yml[m
[36m@@ -143,7 +143,6 @@[m [mResources:[m
       HttpMethod: PUT[m
       RequestParameters:[m
         method.request.header.content-type: True[m
[31m-        # method.request.path.profileId: True[m
       RequestValidatorId: !Ref RequestValidator[m
       Integration:[m
         Type: AWS_PROXY[m
[36m@@ -159,7 +158,7 @@[m [mResources:[m
         - StatusCode: "415"[m
         - StatusCode: "500"[m
         - StatusCode: "502"[m
[31m-      ResourceId: !Ref ProfileResource[m
[32m+[m[32m      ResourceId: !Ref ProfileCollectionResource[m
       RestApiId: !Ref RestApi[m
 [m
   ReadProfileHandlerExecutionRole:[m
[36m@@ -286,7 +285,7 @@[m [mResources:[m
       Action: lambda:InvokeFunction[m
       FunctionName: !GetAtt UpsertProfileHandler.Arn[m
       Principal: apigateway.amazonaws.com[m
[31m-      SourceArn: !Sub arn:aws:execute-api:${AWS::Region}:${AWS::AccountId}:${RestApi}/*[m
[32m+[m[32m      SourceArn: !Sub arn:aws:execute-api:${AWS::Region}:${AWS::AccountId}:${RestApi}/*/*/*[m
 [m
   ApiGatewayAccount:[m
     Type: AWS::ApiGateway::Account[m

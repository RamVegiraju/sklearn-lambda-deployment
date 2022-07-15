#build image locally
docker build -t sklearn-lambda .

#locally run
docker run -p 9000:8080 sklearn-lambda

#sample invocation to local container
curl --request POST \
  --url http://localhost:9000/2015-03-31/functions/function/invocations \
  --header 'Content-Type: application/json' \
  --data '{"data": [[5,5,3,2], [2,4,3,5]]}'

#ECR steps

#replace this with your account ID for the URL: https://stackoverflow.com/questions/34689445/cant-push-image-to-amazon-ecr-fails-with-no-basic-auth-credentials
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474422712127.dkr.ecr.us-east-1.amazonaws.com

aws ecr create-repository --repository-name sklearn-lambda
--image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE

aws ecr describe-repositories --repository-names sklearn-lambda

#docker tag + push image to ECR
docker tag sklearn-lambda:latest 474422712127.dkr.ecr.us-east-1.amazonaws.com/sklearn-lambda:latest

#push image to ECR
docker push 474422712127.dkr.ecr.us-east-1.amazonaws.com/sklearn-lambda:latest

#confirm image pushed to ECR repo
aws ecr describe-images --repository-name sklearn-lambda


#Create Lambda function from image
aws lambda create-function --function-name sklearn-lambda --role arn:aws:iam::474422712127:role/lambda-deployment-role --package-type Image --code ImageUri=474422712127.dkr.ecr.us-east-1.amazonaws.com/sklearn-lambda:latest

#Create Function URL
aws lambda create-function-url-config --function-name sklearn-lambda --auth-type "NONE"
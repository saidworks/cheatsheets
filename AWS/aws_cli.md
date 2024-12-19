* command for aws lambda
--- list of functions : 
aws lambda list-functions --region us-east-1 --profile profileName

--- create lambda function findAllMovies
aws lambda create-function --profile student --function-name findOne --zip-file fileb://./deployment.zip --runtime go1.x --role arn:aws:iam::ACCOUNT_ID:role/FindAllMoviesRole --handler main --region us-east-1

--- create table named movies with ID as partiton key
aws dynamodb create-table --table-name movies  --profile student \
--attribute-definitions AttributeName=ID,AttributeType=N \
--key-schema AttributeName=ID,KeyType=HASH \
--billing-mode PAY_PER_REQUEST


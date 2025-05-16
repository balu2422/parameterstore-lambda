import boto3
import os

def lambda_handler(event, context):
    param_name = os.environ['PARAM_NAME']
    ssm = boto3.client('ssm')
    
    response = ssm.get_parameter(
        Name=param_name,
        WithDecryption=True
    )
    
    print("Secure Parameter Value:", response['Parameter']['Value'])
    return {
        'statusCode': 200,
        'body': response['Parameter']['Value']
    }

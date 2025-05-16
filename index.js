// index.js
const AWS = require('aws-sdk');
const ssm = new AWS.SSM();

exports.handler = async (event) => {
  const paramName = process.env.PARAM_NAME;

  try {
    const response = await ssm.getParameter({
      Name: paramName,
      WithDecryption: true,
    }).promise();

    console.log('Parameter Value:', response.Parameter.Value);
    return {
      statusCode: 200,
      body: JSON.stringify({ value: response.Parameter.Value }),
    };
  } catch (error) {
    console.error('Error fetching parameter:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  }
};

/**
 * @module healthcheck
 * @alias HealthCheck
 */

import awscred from "./awscredentials.js";
import utils from './utils.js';
const mod_hmac = require('crypto');

utils.requireEnvVar('S3_BUCKET_NAME');
utils.requireEnvVar('S3_SERVER');
utils.requireEnvVar('AWS_ACCESS_KEY_ID');
utils.requireEnvVar('AWS_SECRET_ACCESS_KEY');
utils.requireEnvVar('S3_REGION');

const DEFAULT_SIGNED_HEADERS = 'host;x-amz-content-sha256;x-amz-date';

const signatureV4 = (r, timestamp, region, service, uri, queryParams, host, credentials) => {
  const eightDigitDate = utils.getEightDigitDate(timestamp);
  const amzDatetime = utils.getAmzDatetime(timestamp, eightDigitDate);
  const canonicalRequest = _buildCanonicalRequest(r, 'HEAD', uri, queryParams, host, amzDatetime);
  const signature = _buildSignatureV4(r, amzDatetime, eightDigitDate, credentials, region, service, canonicalRequest);
  const authHeader = `AWS4-HMAC-SHA256 Credential=${credentials.accessKey}/${eightDigitDate}/${region}/${service}/aws4_request,SignedHeaders=${DEFAULT_SIGNED_HEADERS},Signature=${signature}`;
  utils.debug_log(r, `AWS v4 Auth header: [${authHeader}]`);
  return authHeader;
}

const _buildCanonicalRequest = (r, method, uri, queryParams, host, amzDatetime) => {
  const payloadHash = awsHeaderPayloadHash();
  let canonicalHeaders = `host:${host}\nx-amz-content-sha256:${payloadHash}\nx-amz-date:${amzDatetime}\n`;
  let canonicalRequest = method + '\n';
  canonicalRequest += uri + '\n';
  canonicalRequest += queryParams + '\n';
  canonicalRequest += canonicalHeaders + '\n';
  canonicalRequest += DEFAULT_SIGNED_HEADERS + '\n';
  canonicalRequest += payloadHash;
  return canonicalRequest;
}

const _buildSignatureV4 = (r, amzDatetime, eightDigitDate, creds, region, service, canonicalRequest) => {
  utils.debug_log(r, `AWS v4 Auth Canonical Request: [${canonicalRequest}]`);
  const canonicalRequestHash = mod_hmac.createHash('sha256').update(canonicalRequest).digest('hex');

  utils.debug_log(r, `AWS v4 Auth Canonical Request Hash: [canonicalRequestHash`);
  const stringToSign = _buildStringToSign(amzDatetime, eightDigitDate, region, service, canonicalRequestHash);

  utils.debug_log(r, `AWS v4 Auth Signing String: [${stringToSign}]`);

  let kSigningHash;

  kSigningHash = _buildSigningKeyHash(creds.secretKey, eightDigitDate, region, service);

  utils.debug_log(r, `AWS v4 Signing Key Hash: [${kSigningHash.toString('hex')}]`);

  const signature = mod_hmac.createHmac('sha256', kSigningHash).update(stringToSign).digest('hex');

  utils.debug_log(r, `AWS v4 Authorization Header: [${signature}]`);

  return signature;
}

const _buildStringToSign = (amzDatetime, eightDigitDate, region, service, canonicalRequestHash) => {
  return `AWS4-HMAC-SHA256\n${amzDatetime}\n${eightDigitDate}/${region}/${service}/aws4_request\n${canonicalRequestHash}`;
}

const _buildSigningKeyHash = (kSecret, eightDigitDate, region, service) => {
  const kDate = mod_hmac.createHmac('sha256', `AWS4${kSecret}`).update(eightDigitDate).digest();
  const kRegion = mod_hmac.createHmac('sha256', kDate).update(region).digest();
  const kService = mod_hmac.createHmac('sha256', kRegion).update(service).digest();
  const kSigning = mod_hmac.createHmac('sha256', kService).update('aws4_request').digest();
  return kSigning;
}

const awsHeaderDate = () => {
  return utils.getAmzDatetime(awscred.Now(), utils.getEightDigitDate(awscred.Now()));
}

const awsHeaderPayloadHash = () => {
  const reqBody = '';
  const payloadHash = mod_hmac.createHash('sha256', 'utf8').update(reqBody).digest('hex');
  return payloadHash;
}

const indexExists = async (r) => {
  const accessKey = process.env['AWS_ACCESS_KEY_ID'];
  const secretKey = process.env['AWS_SECRET_ACCESS_KEY'];
  const region = process.env['S3_REGION'];
  const bucketName = process.env['S3_BUCKET_NAME'];
  const server = process.env['S3_SERVER'];
  const regex = /^(\/(?:[^/]+\/)*[^/]+)\/health\/?$/;;
  const match = r.uri.match(regex);
  const objectKey = match ? `${match[1]}/index.html` : '';
  const timestamp = awscred.Now();
  const service = 's3';
  const host = `${bucketName}.${server}`;
  const credentials = { accessKey, secretKey };
  const queryParams = '';

  const authHeader = signatureV4(r, timestamp, region, service, objectKey, queryParams, host, credentials);

  const headers = new Headers();
  headers.append('Authorization', authHeader);
  headers.append('Host', `${bucketName}.${server}`);
  headers.append('Connection', '');
  headers.append('x-amz-content-sha256', awsHeaderPayloadHash());
  headers.append('x-amz-date', awsHeaderDate());

  const url = `https://${bucketName}.s3.amazonaws.com${objectKey}`;
  try {
    const res = await ngx.fetch(url, { method: 'HEAD', headers });
    
    utils.debug_log(r, JSON.stringify(res, undefined, 4));
    if (res.status == 200) {
      r.return(200, "{status: 'ok'}");
    } else {
      r.return(res.status);
    }
  } catch (e) {
    r.return(500);
  }
}

export default {
  indexExists
};

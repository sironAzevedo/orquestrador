package br.com.orquestrador.infra.cloud;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import org.springframework.beans.factory.annotation.Value;

public abstract class AbstractCloudConfig {

    @Value("${cloud.aws.credentials.access-key}")
    protected String accessKeyId;

    @Value("${cloud.aws.credentials.secret-key}")
    protected String secretAccessKey;

    @Value("${cloud.aws.region.static}")
    protected String region;

    protected AWSStaticCredentialsProvider getCredentialsProvider() {
        return new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKeyId, secretAccessKey));
    }
}

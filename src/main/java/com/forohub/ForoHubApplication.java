package com.forohub;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties
public class ForoHubApplication {

    public static void main(String[] args) {
        SpringApplication.run(ForoHubApplication.class, args);
    }

}
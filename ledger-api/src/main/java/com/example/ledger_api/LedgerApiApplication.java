package com.example.ledger_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;

@SpringBootApplication
@EnableMethodSecurity(prePostEnabled = true)
public class LedgerApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(LedgerApiApplication.class, args);
	}

}

package com.example.ledger_api.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class AuthController {

    @GetMapping("/user")
    public ResponseEntity<Map<String, Object>> user(@AuthenticationPrincipal OAuth2User principal) {
        return ResponseEntity.ok(Map.of(
            "name", principal.getAttribute("name"),
            "email", principal.getAttribute("email")
        ));
    }

    @GetMapping("/public")
    public ResponseEntity<String> publicEndpoint() {
        return ResponseEntity.ok("This is a public endpoint");
    }

    @GetMapping("/private")
    public ResponseEntity<String> privateEndpoint() {
        return ResponseEntity.ok("This is a private endpoint");
    }
}
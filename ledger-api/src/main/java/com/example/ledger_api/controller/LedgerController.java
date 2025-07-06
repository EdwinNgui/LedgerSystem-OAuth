package com.example.ledger_api.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class LedgerController {

    @GetMapping("/public/health")
    public ResponseEntity<Map<String, Object>> publicHealth() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("message", "Public endpoint - no authentication required");
        response.put("timestamp", System.currentTimeMillis());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/ledger/balance")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<Map<String, Object>> getBalance() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        Map<String, Object> response = new HashMap<>();
        response.put("user", authentication.getName());
        response.put("balance", 10000.00);
        response.put("currency", "USD");
        response.put("lastUpdated", System.currentTimeMillis());
        response.put("message", "Balance retrieved successfully");
        
        return ResponseEntity.ok(response);
    }

    @PostMapping("/ledger/transaction")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<Map<String, Object>> createTransaction(@RequestBody Map<String, Object> transaction) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        Map<String, Object> response = new HashMap<>();
        response.put("transactionId", "TXN-" + System.currentTimeMillis());
        response.put("user", authentication.getName());
        response.put("amount", transaction.get("amount"));
        response.put("type", transaction.get("type"));
        response.put("status", "COMPLETED");
        response.put("timestamp", System.currentTimeMillis());
        response.put("message", "Transaction created successfully");
        
        return ResponseEntity.ok(response);
    }

    @GetMapping("/admin/users")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Map<String, Object>> getUsers() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        Map<String, Object> response = new HashMap<>();
        response.put("admin", authentication.getName());
        response.put("users", new String[]{"user", "admin"});
        response.put("totalUsers", 2);
        response.put("timestamp", System.currentTimeMillis());
        response.put("message", "User list retrieved by admin");
        
        return ResponseEntity.ok(response);
    }

    @GetMapping("/profile")
    public ResponseEntity<Map<String, Object>> getProfile() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        Map<String, Object> response = new HashMap<>();
        response.put("username", authentication.getName());
        response.put("authorities", authentication.getAuthorities());
        response.put("authenticated", authentication.isAuthenticated());
        response.put("timestamp", System.currentTimeMillis());
        
        return ResponseEntity.ok(response);
    }
} 
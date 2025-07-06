#!/bin/bash

# OAuth 2.0 Test Script for Ledger API
# This script tests the OAuth 2.0 implementation

BASE_URL="http://localhost:8080"
CLIENT_ID="ledger-client"
CLIENT_SECRET="ledger-secret"
REDIRECT_URI="http://127.0.0.1:3000/callback"

echo "🧪 Testing OAuth 2.0 Implementation"
echo "=================================="

# Test 1: Public Health Check
echo "1. Testing public health endpoint..."
curl -s -X GET "$BASE_URL/api/public/health" | jq .
echo ""

# Test 2: OAuth 2.0 Discovery
echo "2. Testing OAuth 2.0 discovery endpoint..."
curl -s -X GET "$BASE_URL/.well-known/openid_configuration" | jq .
echo ""

# Test 3: JWK Set
echo "3. Testing JWK set endpoint..."
curl -s -X GET "$BASE_URL/.well-known/jwks.json" | jq .
echo ""

# Test 4: Client Credentials Flow
echo "4. Testing client credentials flow..."
TOKEN_RESPONSE=$(curl -s -X POST "$BASE_URL/oauth2/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic bGVkZ2VyLWNsaWVudDpsZWRnZXItc2VjcmV0" \
  -d "grant_type=client_credentials&scope=read write")

echo "Token Response:"
echo "$TOKEN_RESPONSE" | jq .

# Extract access token
ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')

if [ "$ACCESS_TOKEN" != "null" ] && [ "$ACCESS_TOKEN" != "" ]; then
    echo "✅ Access token obtained successfully"
    
    # Test 5: Use Access Token
    echo "5. Testing protected endpoint with access token..."
    curl -s -X GET "$BASE_URL/api/profile" \
      -H "Authorization: Bearer $ACCESS_TOKEN" | jq .
    echo ""
    
    # Test 6: Test role-based endpoint (should fail for client credentials)
    echo "6. Testing role-based endpoint (should show error)..."
    curl -s -X GET "$BASE_URL/api/ledger/balance" \
      -H "Authorization: Bearer $ACCESS_TOKEN" | jq .
    echo ""
    
else
    echo "❌ Failed to obtain access token"
    echo "$TOKEN_RESPONSE"
fi

echo "=================================="
echo "🎉 OAuth 2.0 tests completed!"
echo ""
echo "Next steps:"
echo "1. Test authorization code flow manually in browser"
echo "2. Test with Postman using the postman-client"
echo "3. Check the OAUTH2_GUIDE.md for detailed instructions" 
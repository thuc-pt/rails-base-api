module ApiErrorCode
  ERROR_CODES = {
    account_unauthenticated: 401,
    expired_signature: 401,
    decode_error: 401,
    varification_error: 401,
    record_not_found: 404,
    login_failed: 404,
    token_not_found: 404,
    record_invalid: 422,
    failure: 500
  }
end

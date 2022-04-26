-- Migration generated by the command below; DO NOT EDIT.
-- hydra:generate hydra migrate gen

INSERT INTO hydra_oauth2_flow (
    state,
    login_challenge,
    requested_scope,
    login_verifier,
    login_csrf,
    subject,
    request_url,
    login_skip,
    client_id,
    requested_at,
    login_initialized_at,
    oidc_context,
    login_session_id,
    requested_at_audience,

    login_remember,
    login_remember_for,
    login_error,
    acr,
    login_authenticated_at,
    login_was_used,
    forced_subject_identifier,
    context,
    amr,

    `consent_challenge_id`,
    `consent_verifier`,
    `consent_skip`,
    `consent_csrf`,

    `granted_scope`,
    `consent_remember`,
    `consent_remember_for`,
    `consent_error`,
    `session_access_token`,
    `session_id_token`,
    `consent_was_used`,
    `granted_at_audience`,
    `consent_handled_at`
) SELECT
    case
        when hydra_oauth2_authentication_request_handled.error IS NOT NULL then 128
        when hydra_oauth2_consent_request_handled.error IS NOT NULL then 129
        when hydra_oauth2_consent_request_handled.was_used = true then 6
        when hydra_oauth2_consent_request_handled.challenge IS NOT NULL then 5
        when hydra_oauth2_consent_request.challenge IS NOT NULL then 4
        when hydra_oauth2_authentication_request_handled.was_used = true then 3
        when hydra_oauth2_authentication_request_handled.challenge IS NOT NULL then 2
        else 1
    end,
    hydra_oauth2_authentication_request.challenge,
    hydra_oauth2_authentication_request.requested_scope,
    hydra_oauth2_authentication_request.verifier,
    hydra_oauth2_authentication_request.csrf,
    hydra_oauth2_authentication_request.subject,
    hydra_oauth2_authentication_request.request_url,
    hydra_oauth2_authentication_request.skip,
    hydra_oauth2_authentication_request.client_id,
    hydra_oauth2_authentication_request.requested_at,
    hydra_oauth2_authentication_request.authenticated_at,
    hydra_oauth2_authentication_request.oidc_context,
    hydra_oauth2_authentication_request.login_session_id,
    hydra_oauth2_authentication_request.requested_at_audience,

    hydra_oauth2_authentication_request_handled.remember,
    hydra_oauth2_authentication_request_handled.remember_for,
    hydra_oauth2_authentication_request_handled.error,
    hydra_oauth2_authentication_request_handled.acr,
    hydra_oauth2_authentication_request_handled.authenticated_at,
    hydra_oauth2_authentication_request_handled.was_used,
    hydra_oauth2_authentication_request_handled.forced_subject_identifier,
    hydra_oauth2_authentication_request_handled.context,
    hydra_oauth2_authentication_request_handled.amr,

    hydra_oauth2_consent_request.challenge,
    hydra_oauth2_consent_request.verifier,
    hydra_oauth2_consent_request.skip,
    hydra_oauth2_consent_request.csrf,

    hydra_oauth2_consent_request_handled.granted_scope,
    hydra_oauth2_consent_request_handled.remember,
    hydra_oauth2_consent_request_handled.remember_for,
    hydra_oauth2_consent_request_handled.error,
    hydra_oauth2_consent_request_handled.session_access_token,
    hydra_oauth2_consent_request_handled.session_id_token,
    hydra_oauth2_consent_request_handled.was_used,
    hydra_oauth2_consent_request_handled.granted_at_audience,
    hydra_oauth2_consent_request_handled.handled_at
FROM hydra_oauth2_authentication_request
LEFT JOIN hydra_oauth2_authentication_request_handled
ON hydra_oauth2_authentication_request.challenge = hydra_oauth2_authentication_request_handled.challenge
LEFT JOIN hydra_oauth2_consent_request
ON hydra_oauth2_authentication_request.challenge = hydra_oauth2_consent_request.login_challenge
LEFT JOIN hydra_oauth2_consent_request_handled
ON hydra_oauth2_consent_request.challenge = hydra_oauth2_consent_request_handled.challenge;

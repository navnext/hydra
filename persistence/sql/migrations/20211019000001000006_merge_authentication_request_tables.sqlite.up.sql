-- Migration generated by the command below; DO NOT EDIT.
-- hydra:generate hydra migrate gen

CREATE UNIQUE INDEX hydra_oauth2_flow_login_verifier_idx ON hydra_oauth2_flow (login_verifier);

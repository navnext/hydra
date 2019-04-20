/*
 * Copyright © 2015-2018 Aeneas Rekkas <aeneas+oss@aeneas.io>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author		Aeneas Rekkas <aeneas+oss@aeneas.io>
 * @Copyright 	2017-2018 Aeneas Rekkas <aeneas+oss@aeneas.io>
 * @license 	Apache-2.0
 */

package consent

import "context"

type ForcedObfuscatedLoginSession struct {
	ClientID          string `db:"client_id"`
	Subject           string `db:"subject"`
	SubjectObfuscated string `db:"subject_obfuscated"`
}

type Manager interface {
	CreateConsentRequest(ctx context.Context, req *ConsentRequest) error
	GetConsentRequest(ctx context.Context, challenge string) (*ConsentRequest, error)
	HandleConsentRequest(ctx context.Context, challenge string, r *HandledConsentRequest) (*ConsentRequest, error)
	RevokeSubjectConsentSession(ctx context.Context, user string) error
	RevokeSubjectClientConsentSession(ctx context.Context, user, client string) error

	VerifyAndInvalidateConsentRequest(ctx context.Context, verifier string) (*HandledConsentRequest, error)
	FindGrantedAndRememberedConsentRequests(ctx context.Context, client, user string) ([]HandledConsentRequest, error)
	FindSubjectsGrantedConsentRequests(ctx context.Context, user string, limit, offset int) ([]HandledConsentRequest, error)
	CountSubjectsGrantedConsentRequests(ctx context.Context, user string) (int, error)

	// Cookie management
	GetLoginSession(ctx context.Context, id string) (*SubjectSession, error)
	CreateLoginSession(ctx context.Context, session *SubjectSession) error
	DeleteLoginSession(ctx context.Context, id string) error
	RevokeSubjectLoginSession(ctx context.Context, user string) error

	CreateLoginRequest(ctx context.Context, req *LoginRequest) error
	GetLoginRequest(ctx context.Context, challenge string) (*LoginRequest, error)
	HandleLoginRequest(ctx context.Context, challenge string, r *HandledLoginRequest) (*LoginRequest, error)
	VerifyAndInvalidateLoginRequest(ctx context.Context, verifier string) (*HandledLoginRequest, error)

	CreateForcedObfuscatedLoginSession(ctx context.Context, session *ForcedObfuscatedLoginSession) error
	GetForcedObfuscatedLoginSession(ctx context.Context, client, obfuscated string) (*ForcedObfuscatedLoginSession, error)
}

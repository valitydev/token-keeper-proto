/**
 * Сервис хранения оффлайн токенов.
 */

namespace java com.rbkmoney.token.keeper
namespace erlang token_keeper

include "base.thrift"

typedef base.ID TokenID
typedef string Token
typedef base.Timestamp TokenExpTime

enum TokenStatus {
    active
    revoked
}

/**
 * Набор ролей для сервиса.
**/
struct RoleStorage {
    1: required List<string> roles
}

/**
 * Ссылка на party/shop.
**/
struct Reference {
    1: optional string shop_id
    2: optional string party_id
}

/**
 * Информация связанная с токеном.
**/
struct Scope {
    1: required Reference reference
    2: optional map<string, RoleStorage> resource_access
    3: required map<string, string> metadata
}

struct AuthData {
    1: required TokenID                id
    2: required Token                  token
    3: required TokenStatus            status
    4: required TokenExpTime           exp_time
    5: required Scope                  scope
}

exception InvalidRequest {
    1: required list<string> errors
}

exception TokenNotFound {}

service TokenKeeper {

    /**
    * Создать новый оффлайн токен.
    **/
    AuthData Create (1: Scope scope)
        throws (
            1: InvalidRequest ex1
    )

    /**
    * Создать новый токен с ограниченным временем жизни.
    **/
    AuthData CreateWithExpiration (1: Scope scope, 2: TokenExpTime exp_time)
        throws (
            1: InvalidRequest ex1
    )

    /**
    * Получить данные токена по токену.
    **/
    AuthData GetByToken (1: Token token)
        throws (
            1: TokenNotFound ex2
    )

    /**
    * Получить данные токена по идентификатору.
    **/
    AuthData Get (1: TokenID id)
        throws (
            1: TokenNotFound ex2
    )

    /**
    * Деактивировать оффлайн токен.
    **/
    void Revoke (1: TokenID id)
        throws (
            1: TokenNotFound ex2
    )

}

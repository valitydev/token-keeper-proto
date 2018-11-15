/**
 * Сервис хранения оффлайн токенов.
 */

namespace java com.rbkmoney.token.keeper
namespace erlang token_keeper

include "base.thrift"

typedef base.ID TokenID
typedef string Token

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
    1: optional string name
    2: optional string preferred_username
    3: optional string email
    4: optional string given_name
    5: optional string family_name
    6: required Reference reference
    7: optional map<string, RoleStorage> resource_access
}

struct TokenData {
    1: required TokenID                id
    2: required Token                  token
    3: required TokenStatus            status
    4: required Scope                  scope
}

exception InvalidRequest {
    1: required list<string> errors
}

exception TokenNotFound {}

exception TokenExpired {
    1: required TokenID token_id
}

service TokenKeeper {

    /**
    * Создать новый оффлайн токен.
    **/
    TokenData Create (1: Scope scope)
        throws (
            1: InvalidRequest ex1
    )

    /**
    * Создать новый токен с ограниченным временем жизни.
    **/
    TokenData CreateWithExpiration (1: Scope scope, 2: base.Timestamp exp_time)
        throws (
            1: InvalidRequest ex1
    )

    /**
    * Получить данные токена по токену.
    **/
    TokenData GetByToken (1: Token token)
        throws (
            1: InvalidRequest ex1,
            2: TokenNotFound ex2,
            3: TokenExpired ex3
    )

    /**
    * Получить данные токена по идентификатору.
    **/
    TokenData Get (1: TokenID id)
        throws (
            1: InvalidRequest ex1,
            2: TokenNotFound ex2
    )

    /**
    * Деактивировать оффлайн токен.
    **/
    void Revoke (1: TokenID id)
        throws (
            1: InvalidRequest ex1,
            2: TokenNotFound ex2
    )

}

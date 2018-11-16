/**
 * Сервис хранения оффлайн токенов.
 */

namespace java com.rbkmoney.token.keeper
namespace erlang token_keeper

include "base.thrift"

typedef base.ID TokenID
typedef string Token
typedef base.Timestamp TokenExpTime
typedef map<string, string> Metadata

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
}

struct AuthData {
    1: required TokenID                id
    2: required Token                  token
    3: required TokenStatus            status
    4: required TokenExpTime           exp_time
    5: required Scope                  scope
    6: required Metadata               metadata
}

exception TokenNotFound {}

service TokenKeeper {

    /**
    * Создать новый оффлайн токен.
    **/
    AuthData Create (1: Scope scope, 2: Metadata metadata)

    /**
    * Создать новый токен с ограниченным временем жизни.
    **/
    AuthData CreateWithExpiration (1: Scope scope, 2: Metadata metadata, 3: TokenExpTime exp_time)

    /**
    * Получить данные токена по токену.
    **/
    AuthData GetByToken (1: Token token)
        throws (
            1: TokenNotFound ex1
    )

    /**
    * Получить данные токена по идентификатору.
    **/
    AuthData Get (1: TokenID id)
        throws (
            1: TokenNotFound ex1
    )

    /**
    * Деактивировать оффлайн токен.
    **/
    void Revoke (1: TokenID id)
        throws (
            1: TokenNotFound ex1
    )

}

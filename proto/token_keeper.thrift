/**
 * Сервис хранения оффлайн токенов.
 */

namespace java com.rbkmoney.token.keeper
namespace erlang token_keeper

include "base.thrift"

typedef string JWT

enum TokenStatus {
    active,
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
struct Refference {
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
    6: required Refference refference
    7: optional map<string, RoleStorage> resource_access
}

struct Token {
    1: required base.ID                id
    2: required JWT                    token
    3: required TokenStatus            status
    4: required Scope                  scope
}

exception InvalidRequest {
    1: required list<string> errors
}

service TokenKeeper {

    /**
    * Создать новый оффлайн токен.
    **/
    Token CreateOffline (1: Scope scope)
        throws (
            1: InvalidRequest ex1
    )

    /**
    * Создать новый токен с ограниченным временем жизни.
    **/
    Token Create (1: Scope scope, 2: base.Timestamp exp_time)
        throws (
            1: InvalidRequest ex1
    )

    /**
    * Получить токен.
    **/
    Token Get (1: JWT jwt)
        throws (
            1: InvalidRequest ex1
    )

    /**
    * Деактивировать оффлайн токен.
    **/
    Token Revoke (1: base.ID id)
        throws (
            1: InvalidRequest ex1
    )

}

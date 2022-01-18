/*
 * Базовые, наиболее общие определения
 * Заимствовано из damsel/proto/base.thrift
 * commit id: b0806eb1d55646cbb937206ad8183e6d3f62719a
 */

namespace java dev.vality.token.keeper.base
namespace erlang token_keeper_base

/** Идентификатор */
typedef string ID

/**
 * Отметка во времени согласно RFC 3339.
 *
 * Строка должна содержать дату и время в UTC в следующем формате:
 * `2016-03-22T06:12:27Z`.
 */
typedef string Timestamp

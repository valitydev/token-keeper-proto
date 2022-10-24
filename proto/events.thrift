/**
 * События для Machinegun.
 */

namespace java dev.vality.token.keeper.events
namespace erlang tk.events
namespace elixir TokenKeeper.Events

include "token_keeper.thrift"

union AuthDataChange {
    1: AuthDataCreated       created
    2: AuthDataStatusChanged status_changed
}

struct AuthDataCreated {
    1: required token_keeper.AuthDataID      id
    2: required token_keeper.AuthDataStatus  status
    3: required token_keeper.ContextFragment context
    4: required token_keeper.Metadata        metadata
}

struct AuthDataStatusChanged {
    1: required token_keeper.AuthDataStatus status
}

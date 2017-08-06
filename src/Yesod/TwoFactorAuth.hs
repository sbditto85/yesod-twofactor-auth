module Yesod.TwoFactorAuth
  ( TwoFactorPlugin
  , YesodTwoFactorAuth
  ) where

import           Yesod.Auth
import           Yesod.Core
import           Yesod.TwoFactorAuth.Core hiding ( Method )

type Method = Text
type Piece = Text
type TwoFactorHandler master a = HandlerT TwoFactorAuth (HandlerT master IO) a

data TwoFactorPlugin master = TwoFactorPlugin
    { tfName :: Text
    , tfDispatch :: Method -> [Piece] -> TwoFactorHandler master TypedContent
    , tfLogin :: (Route Auth -> Route master) -> WidgetT master IO ()
    }


class YesodAuth master => YesodTwoFactorAuth master where
  twoFactorPlugins :: master -> [ TwoFactorPlugin master ]

  showTwoFactorHandler :: HandlerT TwoFactorAuth (HandlerT master IO) Html
  showTwoFactorHandler = defaultShowTwoFactorHandler

  success :: Creds master -> HandlerT master IO (AuthenticationResult master)
  success = authenticate

  failure :: Creds master -> HandlerT master IO (AuthenticationResult master)
  failure = defaultFailure


defaultShowTwoFactorHandler = error "do this"

defaultFailure = error "do this"

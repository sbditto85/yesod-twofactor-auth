module Yesod.TwoFactorAuth
  ( YesodTotp
  ) where

import           Yesod.Core
import           Yesod.TwoFactorAuth.Core

class YesodAuth master => YesodTwoFactorAuth master where
  enterTotpHandler :: HandlerT TwoFactorAuth (HandlerT master IO) Html
  enterTotpHandler = defaultEnterTotpHandler

  processTotpHandler :: HandlerT TwoFactorAuth (HandlerT master IO) Html
  processTotpHandler = defaultProcessTotpHandler

  success :: Creds master -> HandlerT master IO (AuthenticationResult master)
  success = defaultSuccess

  failure :: Creds master -> HandlerT master IO (AuthenticationResult master)
  failure = defaultFailure

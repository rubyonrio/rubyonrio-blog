# -*- coding: utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'key', 'key'
end

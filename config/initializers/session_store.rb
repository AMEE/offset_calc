# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_amee_offset_calc_session',
  :secret      => 'Efeith9taoshe4eitari4iedaeyia8queiTaeGooKiegaing6thohQuaeS1muChipahyi9aechaenaem6soghoozei0Ohqu8Ohbo'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store

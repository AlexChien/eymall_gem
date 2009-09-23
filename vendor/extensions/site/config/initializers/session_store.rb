# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eymall_session',
  :secret      => 'f35dc3bd347e0166999c82120c059f1869c1b5876d2094a46591ef5dca7f03d39c399ef5238a88095c51b49536c737249cddad2eb74f26a0693a12e2e4ad9708'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
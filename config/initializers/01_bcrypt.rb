# > The default cost factor used by bcrypt-ruby is 10, which is fine for
# > session-based authentication.
# > https://github.com/codahale/bcrypt-ruby

# On my laptop:
#
# cost | time
# ---- | --------
#    9 | 40 ms
#   10 | 80 ms
#   11 | 150 ms
#   12 | 300 ms
BCrypt::Engine.cost = 12

### Prerequisites

- Ruby installed: `ruby -v`
- (optional) rbenv installed: `rbenv -v`
- Docker installed: `docker -v`
- dotenv installed: `dotenv -v` \
  Install with `gem install dotenv`
- `.env` populated with
    - KAMAL_REGISTRY_PASSWORD=X
- `config/master.key` populated
- ssh key added to `~/.ssh/authorized_keys` on server \
  Add new with `ssh-copy-id <user>@railsguru.dev`

### Steps

```bash
# First time only
dotenv bin/kamal setup
# Afterwards
dotenv bin/kamal deploy
``` 